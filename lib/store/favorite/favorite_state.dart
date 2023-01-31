import 'package:coffe_flutter/models/favorite.model.dart';

class FavoriteState {
  final List<FavoriteItemModel> products;
  final bool isLoading;
  final String? error;
  FavoriteState({required this.products, required this.isLoading, this.error});

  FavoriteState copyWith(
      {List<FavoriteItemModel>? products, bool? isLoading, String? error}) {
    return FavoriteState(
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}
