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

  Future<String> updateProductsDB(List<ProductModel> products) async {
    try {
      for (int i = 0; i < products.length; i++) {
        final snapshotProduct = await _collectionProducts
            .where("id", isEqualTo: products[i].id)
            .get();
        final docs = snapshotProduct.docs.toList();
        _collectionProducts.doc(docs[0].id).update({
          "name_ua": products[i].name_ua,
          "name_en": products[i].name_en,
          "description_ua": products[i].description_ua,
          "description_en": products[i].description_en,
          "measurement_value_ua": products[i].measurement_value_ua,
          "measurement_value_en": products[i].measurement_value_en,
          "composition_ua": products[i].composition_ua,
          "composition_en": products[i].composition_en,
          "energy_and_nutritional_value_ua":
              products[i].energy_and_nutritional_value_ua,
          "energy_and_nutritional_value_en":
              products[i].energy_and_nutritional_value_en,
        });
      }
      log("PRODUCT UPDATE SUCCESS");
      return "PRODUCT UPDATE SUCCESS";
    } catch (e) {
      log("PRODUCT UPDATE ERROR: ${e.toString()}");
      return "PRODUCT UPDATE ERROR: ${e.toString()}";
    }
  }
}
