import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/product.model.dart';

class HomeState {
  final List<CategoryModel> categorys;
  final List<ProductModel> special;
  final bool isLoading;
  final String? error;

  HomeState(
      {required this.categorys,
      required this.special,
      required this.isLoading,
      this.error});

  HomeState copyWith({categorys, error, isLoading, special}) {
    return HomeState(
        special: special ?? this.special,
        categorys: categorys ?? this.categorys,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }
}
