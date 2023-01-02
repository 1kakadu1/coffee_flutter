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
      return await Hive.openBox<CartHive>('CartHiveModels');
    } on Exception catch (e) {
      log("Error open table Cart: ${e.toString()}");
      throw Exception("Error open table Cart: ${e.toString()}");
    }
  }

  static Future<void> whereUpdateCartItem(
      {required CartHive item,
      required String size,
      required String id,
      bool notUpdateCount = false}) async {
    try {
      final box = await cartBox();
      final cartFilter = box.values
          .toList()
          .where((element) => element.id == id && element.currentSize == size)
          .toList();
      if (cartFilter.isNotEmpty) {
        final cartBox = box.get(cartFilter[0].key);
        if (cartBox != null) {
          cartBox.categorys = item.categorys;
          cartBox.currentSize = item.currentSize;
          cartBox.id = item.id;
          cartBox.preview = item.preview;
          cartBox.comments = item.comments;
          cartBox.price = item.price;
          cartBox.count =
              notUpdateCount == true ? cartFilter[0].count : item.count;
          await cartBox.save();
        } else {
          throw Exception('Cart item ${item.id} not found');
        }
      }
    } catch (e) {
      Exception('Cart item ${item.id} error: ${e.toString()}');
    }
  }

  static Future<List<CartHive>> getCartProducts() async {
    try {
      final box = await cartBox();
      return box.values.toList();
    } catch (e) {
      throw Exception('Cart items not found');
    }
  }

  static Future<void> whereDelateCartItem(
      {required String size, required String id}) async {
    try {
      final box = await cartBox();
      final cartFilter = box.values
          .toList()
          .where((element) => element.id == id && element.currentSize == size)
          .toList();
      if (cartFilter.isNotEmpty) {
        final cartBox = box.get(cartFilter[0].key);
        if (cartBox != null) {
          box.delete(cartBox.key);
        } else {
          throw Exception('Cart item ${id} not found');
        }
      }
    } catch (e) {
      Exception('Cart item ${id} error: ${e.toString()}');
    }
  }

  static createCartItem(CartHive item) async {
    var uuid = const Uuid();
    final db = await cartBox();
    final key = uuid.v1();
    db.put(key, item);
  }

  static clearBoxes() async {
    final users = await cartBox();
    users.deleteFromDisk();
  }
}
