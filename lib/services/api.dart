import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/home_model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiData<T> {
  final T data;
  final String? error;
  final int hashCode;

  ApiData({
    required this.data,
    this.error,
    required this.hashCode,
  });

  @override
  bool operator ==(Object other) {
    return super == other;
  }
}

class Api {
  final _collectionProducts = FirebaseFirestore.instance.collection('products');
  final _collectionCategories =
      FirebaseFirestore.instance.collection('categorys');
  final _auth = FirebaseAuth.instance;

  Future<ApiData<HomeModel>> getHome() async {
    try {
      var requestSpecial = await _collectionProducts
          .limit(4)
          .where("isSpecial", isEqualTo: true)
          .get();
      List<ProductModel> special = requestSpecial.docs.toList().map((element) {
        var data = element.data();
        return ProductModel.fromJson(data);
      }).toList();

      var requestCategory = await _collectionCategories.get();
      List<CategoryModel> cat = requestCategory.docs.map((item) {
        return CategoryModel.fromJson(item.data());
      }).toList();

      return ApiData<HomeModel>(
          data: HomeModel(special: special, categorys: cat),
          hashCode: requestCategory.hashCode + requestSpecial.hashCode);
    } catch (e) {
      return ApiData(
          data: HomeModel(special: [], categorys: []),
          error: "Error ${e.toString()}",
          hashCode: e.hashCode);
    }
  }
}

final apiServices = Api();
