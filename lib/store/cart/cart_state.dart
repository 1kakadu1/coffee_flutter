import 'package:coffe_flutter/models/cart.model.dart';

class CartState {
  final List<CartItemModel> products;
  final bool isLoading;
  final String? error;
  CartState({required this.products, required this.isLoading, this.error});

  CartState copyWith(
      {List<CartItemModel>? products, bool? isLoading, String? error}) {
    return CartState(
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}
