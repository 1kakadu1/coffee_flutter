import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/product.model.dart';

class HomeState {
  final List<CategoryModel> categorys;
  final List<ProductModel> special;
  final List<ProductModel> tabsProduct;
  final String activeTab;
  final bool isLoading;
  final String? error;

  HomeState(
      {required this.categorys,
      required this.special,
      required this.isLoading,
      required this.tabsProduct,
      required this.activeTab,
      this.error});

  HomeState copyWith(
      {categorys, error, isLoading, special, tabsProduct, activeTab}) {
    return HomeState(
        special: special ?? this.special,
        activeTab: activeTab ?? this.activeTab,
        tabsProduct: tabsProduct ?? this.tabsProduct,
        categorys: categorys ?? this.categorys,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }
}
