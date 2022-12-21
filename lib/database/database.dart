import 'dart:developer';

import 'package:coffe_flutter/database/models/cart.hive.model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class DatabaseHive<T> {
  T? findOne(Box<T> box, String field, dynamic data) {
    final list = box.values.toList();
    final int index = box.values
        .toList()
        .indexWhere((dynamic element) => element[field] == data);

    return index == -1 ? null : list[index];
  }

  static Future<void> initDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartHiveAdapter());
  }

  static Future<Box<CartHive>> cartBox() async {
    try {
      return await Hive.openBox<CartHive>('UserHiveModels');
    } on Exception catch (e) {
      log("Error open table Cart: ${e.toString()}");
      throw Exception("Error open table Cart: ${e.toString()}");
    }
  }

  static Future<void> whereUpdateCartItem(
      {required CartHive item,
      required String size,
      required String id}) async {
    try {
      final box = await cartBox();
      final cartFilter = box.values
          .toList()
          .where((element) => element.id == id && element.currentSize == size)
          .toList();
      if (cartFilter.isNotEmpty) {
        final cartBox = box.get(cartFilter[0].key);
        if (cartBox != null) {
          cartBox.category = item.category;
          cartBox.currentSize = item.currentSize;
          cartBox.id = item.id;
          cartBox.preview = item.preview;
          cartBox.comments = item.comments;
          cartBox.price = item.price;
          cartBox.count = item.count;
          await cartBox.save();
        } else {
          throw Exception('Cart item ${item.id} not found');
        }
      }
    } catch (e) {
      Exception('Cart item ${item.id} error: ${e.toString()}');
    }
  }

  static Future<void> whereDelateCartItem(
      {required CartHive item,
      required String size,
      required String id}) async {
    final box = await cartBox();
    final cartFilter = box.values
        .toList()
        .where((element) => element.id == id && element.currentSize == size)
        .toList();
    try {
      final box = await cartBox();
      final cartFilter = box.values
          .toList()
          .where((element) => element.id == id && element.currentSize == size)
          .toList();
      if (cartFilter.isNotEmpty) {
        final cartBox = box.get(cartFilter[0]);
        if (cartBox != null) {
        } else {
          throw Exception('Cart item ${item.id} not found');
        }
      }
    } catch (e) {
      Exception('Cart item ${item.id} error: ${e.toString()}');
    }
  }

  static createCartItem(CartHive item) async {
    var uuid = const Uuid();
    final db = await cartBox();
    final key = uuid.v1();
    final tesdt = db.values.toList();
    log("create ${key}");
    db.put(key, item);
  }

  static clearBoxes() async {
    final users = await cartBox();
    users.deleteFromDisk();
  }
}
