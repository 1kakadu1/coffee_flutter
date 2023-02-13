import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> setup() async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    final initSettings = InitializationSettings(
        android: androidSetting, iOS: initializationSettingsDarwin);

    await _localNotificationsPlugin
        .initialize(initSettings,
            onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse)
        .then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      String? payload}) async {
    final details = await _notificationDetails();
    await _localNotificationsPlugin.show(id, title, body, details,
        payload: payload);
  }

  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime time,
      String? payload}) async {
    final details = await _notificationDetails();
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        time,
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationsPlugin.show(id, title, body, details,
        payload: payload);
  }

  Future<void> cancel(int id, {String? tag}) async {
    await _localNotificationsPlugin.cancel(id, tag: tag);
  }

  Future<void> cancelAllNotifications() async {
    await _localNotificationsPlugin.cancelAll();
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      onNotificationClick.add(payload);
    }
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    debugPrint('_DidReceiveLocalNotification: $payload');
  }
}

final notificationService = NotificationService();
