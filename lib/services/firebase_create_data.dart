import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCreateData {
  var _collectionProducts = FirebaseFirestore.instance.collection('products');

  Future<String> createProductsDB(List<ProductModel> products) async {
    try {
      for (int i = 0; i < products.length; i++) {
        var product = products[i].toJson();

        var rez = await _collectionProducts.add(product);
        log("product ${rez}");
      }
      log("PRODUCT CREATE SUCCESS");
      return "PRODUCT CREATE SUCCESS";
    } catch (e) {
      log("PRODUCT ERROR: ${e.toString()}");
      return "PRODUCT ERROR: ${e.toString()}";
    }
  }
}
