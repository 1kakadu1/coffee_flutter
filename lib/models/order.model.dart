import 'package:coffe_flutter/models/cart.model.dart';
import 'package:intl/intl.dart';

class OrderModel {
  late String? key;
  late String? id;
  late String name;
  late String phone;
  late String date;
  late String? comments;
  late String address;
  late List<CartItemModel> products;
  late String? userID;

  OrderModel(
      {this.key,
      required this.name,
      required this.phone,
      required this.date,
      this.comments,
      required this.address,
      required this.products,
      this.id,
      this.userID});

  OrderModel.fromJson(Map<String, dynamic> json) {
    key = json["key"] ?? "";
    name = json["name"] ?? "";
    phone = json["phone"] ?? "";
    address = json["address"] ?? "";
    comments = json["comments"] ?? "";
    id = json["id"] ?? "";
    final arr0 = <CartItemModel>[];
    if (json["products"] != null) {
      final v = json["products"];
      v.forEach((v) {
        arr0.add(CartItemModel.fromJson(v));
      });
    }
    products = arr0;
    date = json[
        "date"]; //DateFormat('dd.MM.yyyy  kk:mm').format(json["date"]).toString();
    userID = json["userID"] ?? "";
  }
}
