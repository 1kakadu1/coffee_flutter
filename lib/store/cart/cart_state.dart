import 'package:coffe_flutter/models/cart.model.dart';

class CartState {
  final List<CartItemModel> products;

  CartState({required this.products});

  CartState copyWith({List<CartItemModel>? products}) {
    return CartState(products: products ?? this.products);
  }
}
