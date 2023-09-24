import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_flutter/models/blog.model.dart';
import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/favorite.model.dart';
import 'package:coffe_flutter/models/home_model.dart';
import 'package:coffe_flutter/models/order.model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../const/env.dart';

class ApiData<T> {
  final T data;
  final String? error;
  final int hashCode;
  final dynamic offset;

  ApiData(
      {required this.data, this.error, required this.hashCode, this.offset});

  @override
  bool operator ==(Object other) {
    return super == other;
  }
}

class UpdateApiData {
  final String field;
  final data;

  UpdateApiData({required this.data, required this.field});

  @override
  bool operator ==(Object other) {
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}

class Api {
  final _collectionBlog = FirebaseFirestore.instance.collection('blog');
  final _collectionProducts = FirebaseFirestore.instance.collection('products');
  final _collectionOrders = FirebaseFirestore.instance.collection('orders');
  final _collectionUsers = FirebaseFirestore.instance.collection('users');
  final _collectionCategories =
      FirebaseFirestore.instance.collection('categorys');
  final _auth = FirebaseAuth.instance;

  Future<ApiData<bool?>> createUserWithEmailAndPassword({
    required String password,
    required String email,
    required String name,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _collectionUsers.add({
        "name": name,
        "email": email,
        "address": '',
        "preview": '',
        "orders": [],
        "phone": phone,
        "userID": userCredential.user?.uid,
      });

      return ApiData<bool?>(
          data: true, error: "", hashCode: userCredential.hashCode);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("The account already exists for that email.");
      }
      throw Exception(e.toString());
    } catch (e) {
      return ApiData(
          data: null, error: "Error: ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<UserCustom?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      final data = await getUser(user.uid);
      if (data.error != null) {
        throw Exception("No user found for that email or user.");
      }
      return ApiData(data: data.data, error: "", hashCode: user.hashCode);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Wrong password provided for that user.");
      }
      throw Exception(e.toString());
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<UserCustom?>> getUser(String id) async {
    try {
      final req = await _collectionUsers.where("userID", isEqualTo: id).get();
      List<UserCustom> data = [];
      req.docs.forEach((element) {
        var doc = element.data();
        data.add(UserCustom.fromJson(doc));
      });

      if (data.isEmpty || data[0].id != id) {
        throw Exception("Not found 404");
      }

      return ApiData<UserCustom>(
          data: UserCustom(
              address: data[0].address,
              email: data[0].email,
              name: data[0].name,
              phone: data[0].phone,
              preview: data[0].preview,
              id: id),
          error: "",
          hashCode: req.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

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

  Future<ApiData<UserCustom?>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return ApiData(data: UserCustom.initial(), error: "", hashCode: 200);
    } catch (e) {
      return ApiData(
          data: null,
          error:
              "Problem when exiting the application. Restart and repeat again",
          hashCode: 200);
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
        "email": data.email,
        "phone": data.phone,
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

  Future<ApiData<List<CategoryModel>>> getCategoryList() async {
    try {
      var requestCategory = await _collectionCategories.get();
      List<CategoryModel> cat = requestCategory.docs.map((item) {
        return CategoryModel.fromJson(item.data());
      }).toList();

      return ApiData<List<CategoryModel>>(
          data: cat, hashCode: requestCategory.hashCode);
    } catch (e) {
      return ApiData<List<CategoryModel>>(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<UpdateApiData?>> updateUserField(
      String userID, String field, dynamic value) async {
    try {
      final req =
          await _collectionUsers.where("userID", isEqualTo: userID).get();
      List<UserCustom> data = [];
      String docID = "";
      for (var element in req.docs) {
        var doc = element.data();
        data.add(UserCustom.fromJson(doc));
        docID = element.id;
      }

      if (data.isEmpty || data[0].id != userID || docID == "") {
        throw Exception("Not found 404");
      }

      await _collectionUsers.doc(docID).update({field: value});

      return ApiData<UpdateApiData>(
          data: UpdateApiData(field: field, data: value),
          error: "",
          hashCode: req.hashCode);
    } catch (e) {
      return ApiData(
          data: null, error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }

  Future<ApiData<List<OrderModel>>> getUserOrders(
      String userID, int limit, dynamic offset) async {
    try {
      QuerySnapshot<Map<String, dynamic>> rez;
      if (offset != null) {
        rez = await _collectionOrders
            .where("userID", isEqualTo: userID)
            .orderBy("date", descending: true)
            .startAfter([offset.data()["date"]])
            .limit(limit)
            .get();
      } else {
        rez = await _collectionOrders
            .where("userID", isEqualTo: userID)
            .orderBy("date", descending: true)
            .limit(limit)
            .get();
      }

      var docs = rez.docs;
      var lastVisible;

      List<OrderModel> data = [];
      if (docs.isNotEmpty) {
        lastVisible = docs[docs.length - 1];
        for (var element in docs) {
          var doc = element.data();
          doc["date"] = doc["date"];
          doc['id'] = element.id;
          data.add(OrderModel.fromJson(doc));
        }
      }
      return ApiData<List<OrderModel>>(
          data: data,
          error: "",
          hashCode: rez.hashCode,
          offset: lastVisible ?? offset);
    } catch (e) {
      return ApiData(
          data: [], error: "Error ${e.toString()}", hashCode: e.hashCode);
    }
  }
}

final apiServices = Api();
