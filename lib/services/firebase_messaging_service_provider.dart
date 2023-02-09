import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });
  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;

  String printData() {
    return "$title $body $dataTitle $dataBody";
  }
}

typedef CallbackType = void Function(Map<String, dynamic> data);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

class FirebaseMessagingService {
  FirebaseMessagingService();
  final BehaviorSubject<Map<String, dynamic>> onNotificationClick =
      BehaviorSubject();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String? token;

  Future<String?> getToken(String id) async {
    final token = await _messaging.getToken();
    await _saveToken(token, id);
    return token;
  }

  Future<void> _saveToken(String? token, String id) async {
    if (token != null) {
      await FirebaseFirestore.instance
          .collection("users_tokens")
          .doc(id)
          .set({'token': token});
    }
  }

  Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
    notification.printData();
  }

  Future<void> _firebaseMessagingOnOpenAppHandler(RemoteMessage message) async {
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
    onNotificationClick.add(message.data);
  }

  checkForInitialMessage(RemoteMessage? initialMessage,
      {CallbackType? callback}) async {
    if (initialMessage != null) {
      if (callback != null) {
        callback(initialMessage.data);
      }
    }
  }

  Future<String?> registerNotification(String id) async {
    final token = await getToken(id);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      FirebaseMessaging.onMessage.listen(_firebaseMessagingHandler);
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp
          .listen(_firebaseMessagingOnOpenAppHandler);
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    return token;
  }
}

final firebaseMessagingService = FirebaseMessagingService();
