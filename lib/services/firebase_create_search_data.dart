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
        List<String> splitListEn = products[i].name_en.split(" ");
        List<String> splitListUa = products[i].name_ua.split(" ");
        List<String> searchList = [];
        List<String> searchListEn = [];
        List<String> searchListUa = [];
        for (int j = 0; j < splitList.length; j++) {
          for (int a = 1; a < splitList[j].length + 1; a++) {
            searchList.add(splitList[j].substring(0, a).toLowerCase());
          }
        }
        for (int j = 0; j < splitListUa.length; j++) {
          for (int a = 1; a < splitListUa[j].length + 1; a++) {
            searchListUa.add(splitListUa[j].substring(0, a).toLowerCase());
          }
        }
        for (int j = 0; j < splitListEn.length; j++) {
          for (int a = 1; a < splitListEn[j].length + 1; a++) {
            searchListEn.add(splitList[j].substring(0, a).toLowerCase());
          }
        }
        _collectionProducts.doc(docs[0].id).update({
          field: [...searchList, ...searchListUa, ...searchListEn]
        });
      }
      log("PRODUCT CREATE SEARCH SUCCESS");
      return "PRODUCT CREATE SEARCH SUCCESS";
    } catch (e) {
      log("PRODUCT SEARCH ERROR: ${e.toString()}");
      return "PRODUCT SEARCH ERROR: ${e.toString()}";
    }
  }
}
