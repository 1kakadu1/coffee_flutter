import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_flutter/models/blog.model.dart';
import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/favorite.model.dart';
import 'package:coffe_flutter/models/home_model.dart';
import 'package:coffe_flutter/models/order.model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../const/env.dart';

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
  final _collectionBlog = FirebaseFirestore.instance.collection('blog');
  final _collectionProducts = FirebaseFirestore.instance.collection('products');
  final _collectionOrders = FirebaseFirestore.instance.collection('orders');
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

  Future<ApiData<ProductModel?>> getProductById(String id) async {
    try {
      var request = await _collectionProducts.where("id", isEqualTo: id).get();

      List<ProductModel> data = [];
      for (var element in request.docs) {
        var doc = element.data();
        data.add(ProductModel.fromJson(doc));
      }

      if (data.isEmpty) {
        throw Exception("Not found 404");
      }

      return ApiData<ProductModel>(data: data[0], hashCode: request.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
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
          cart[indexToCart].copyWith(price: product.price);
        }
      });

      return ApiData<List<CartItemModel>>(
          data: cart, hashCode: request.hashCode);
    } catch (e) {
      return ApiData(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<List<FavoriteItemModel>>> getFavoriteProducts(
    List<FavoriteItemModel> items,
  ) async {
    try {
      var favorite = items;
      var request = await _collectionProducts
          .where("id", whereIn: items.map((e) => (e.id)).toList())
          .get();

      request.docs.toList().forEach((element) {
        final product = ProductModel.fromJson(element.data());
        final int indexToCart =
            favorite.indexWhere((item) => item.id == product.id);
        if (indexToCart != -1) {
          favorite[indexToCart].copyWith(
              description: product.description,
              preview: product.preview,
              name: product.name,
              categorys: product.categorys);
        }
      });

      return ApiData<List<FavoriteItemModel>>(
          data: favorite, hashCode: request.hashCode);
    } catch (e) {
      return ApiData(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<List<BlogModel>>> getBlog(
    int limit,
  ) async {
    try {
      var request = await _collectionBlog.limit(limit).get();

      List<BlogModel> posts = request.docs.toList().map((element) {
        var data = element.data();
        return BlogModel.fromJson(data);
      }).toList();

      return ApiData<List<BlogModel>>(data: posts, hashCode: request.hashCode);
    } catch (e) {
      return ApiData(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<bool?>> createOrder(OrderModel data) async {
    try {
      List<Map<String, dynamic>> cartJson =
          data.products.map((e) => (e.toJson())).toList();

      var rez = _collectionOrders.add({
        "key": data.key ?? Env.orderKey,
        "name": data.name,
        "email": data.phone,
        "date": data.date, //DateTime.parse(data.date),
        "comments": data.comments,
        "address": data.address,
        "products": cartJson,
        "userID": data.userID ?? 'not_register_user',
      });
      return ApiData<bool>(data: true, error: "", hashCode: rez.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }
}

final apiServices = Api();
