import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_flutter/models/cart.model.dart';
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

      var requestTabs = await _collectionProducts
          .limit(10)
          .where("categorys", arrayContains: "id-all")
          .get();

      List<ProductModel> tabsProduct = requestTabs.docs.toList().map((element) {
        var data = element.data();
        return ProductModel.fromJson(data);
      }).toList();

      var requestCategory = await _collectionCategories.get();
      List<CategoryModel> cat = requestCategory.docs.map((item) {
        return CategoryModel.fromJson(item.data());
      }).toList();

      return ApiData<HomeModel>(
          data: HomeModel(
              special: special, categorys: cat, tabsProduct: tabsProduct),
          hashCode: requestCategory.hashCode +
              requestSpecial.hashCode +
              requestTabs.hashCode);
    } catch (e) {
      return ApiData(
          data: HomeModel(special: [], categorys: [], tabsProduct: []),
          error: "Error ${e.toString()}",
          hashCode: e.hashCode);
    }
  }

  Future<ApiData<List<ProductModel>>> getProductCategory(String id,
      {int limit = 10}) async {
    try {
      var request = await _collectionProducts
          .limit(limit)
          .where("categorys", arrayContains: id)
          .get();

      List<ProductModel> products = request.docs.toList().map((element) {
        var data = element.data();
        return ProductModel.fromJson(data);
      }).toList();

      return ApiData<List<ProductModel>>(
          data: products, hashCode: request.hashCode);
    } catch (e) {
      return ApiData(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<List<CartItemModel>>> getCartProducts(
    List<CartItemModel> items,
  ) async {
    try {
      var cart = items;
      var request = await _collectionProducts
          .where("id", whereIn: items.map((e) => (e.id)).toList())
          .get();

      request.docs.toList().forEach((element) {
        final product = ProductModel.fromJson(element.data());
        final int indexToCart =
            cart.indexWhere((item) => item.id == product.id);
        if (indexToCart != -1) {
          cart[indexToCart].price = product.price;
        }
      });

      return ApiData<List<CartItemModel>>(
          data: cart, hashCode: request.hashCode);
    } catch (e) {
      return ApiData(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }
}

final apiServices = Api();
