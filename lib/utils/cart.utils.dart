import 'package:coffe_flutter/services/notification_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _CartNotification {
  _CartNotification();
  final _storage = const FlutterSecureStorage();
  final String _cartKey = "CART_ID_STORAGE";
  final int _id = 666;

  checkLocalNotification() async {
    String? value = await _storage.read(key: _cartKey);

    if (value != null) {
      return true;
    }

    return false;
  }

  setNotification() async {
    final date = DateTime.now();
    String? value = await _storage.read(key: _cartKey);
    if (value != null) {
      await _storage.delete(key: _cartKey);
    }
    await _storage.write(key: _cartKey, value: _id.toString());

    notificationService.showScheduledNotification(
        id: _id,
        title: "У вас есть товары",
        body: "Присутствует товар в корзине, который недавно добавили!",
        time: date.add(const Duration(hours: 1)),
        payload: "cart");
  }

  clearNotification() async {
    await _storage.delete(key: _cartKey);
    notificationService.cancel(_id);
  }
}

final cartNotification = _CartNotification();
