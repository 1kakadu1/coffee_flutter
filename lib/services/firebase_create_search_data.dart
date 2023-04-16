import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_flutter/models/product.model.dart';

class FirebaseCreateSearchData {
  final _collectionProducts = FirebaseFirestore.instance.collection('products');

  Future<String> createSearchDataDB(
      List<ProductModel> products, String field) async {
    try {
      for (int i = 0; i < products.length; i++) {
        final snapshotProduct = await _collectionProducts
            .where("id", isEqualTo: products[i].id)
            .get();
        final docs = snapshotProduct.docs.toList();
        List<String> splitList = products[i].name.split(" ");
        List<String> searchList = [];
        for (int j = 0; j < splitList.length; j++) {
          for (int a = 1; a < splitList[j].length + 1; a++) {
            searchList.add(splitList[j].substring(0, a).toLowerCase());
          }
        }
        _collectionProducts.doc(docs[0].id).update({field: searchList});
      }
      log("PRODUCT CREATE SEARCH SUCCESS");
      return "PRODUCT CREATE SEARCH SUCCESS";
    } catch (e) {
      log("PRODUCT SEARCH ERROR: ${e.toString()}");
      return "PRODUCT SEARCH ERROR: ${e.toString()}";
    }
  }
}
