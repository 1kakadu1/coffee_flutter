import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartEvent {}

class CartAddAction extends CartEvent {
  final ProductModel? product;
  final CartItemModel? cartItem;
  final String size;
  CartAddAction({this.product, this.cartItem, required this.size});
}

class CartSubAction extends CartEvent {
  final ProductModel? product;
  final CartItemModel? cartItem;
  final String size;
  CartSubAction({this.product, this.cartItem, required this.size});
}

class CartRemoveAction extends CartEvent {
  final CartItemModel product;
  final String size;
  CartRemoveAction({required this.product, required this.size});
}

class CartChangeCommentsAction extends CartEvent {
  final String? comments;
  final String id;
  final String size;
  CartChangeCommentsAction(
      {this.comments, required this.id, required this.size});
}

class CartClearAction extends CartEvent {}

class CartUpdateProductsAction extends CartEvent {}

class CartInitProductsAction extends CartEvent {}
