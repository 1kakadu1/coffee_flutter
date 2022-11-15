import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/product.model.dart';

class HomeModel {
  late List<ProductModel> special;
  late List<CategoryModel> categorys;
  late List<ProductModel> tabsProduct;

  HomeModel({
    required this.special,
    required this.categorys,
    required this.tabsProduct,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    special = json["special"] ?? [];
    categorys = json["categorys"] ?? [];
    tabsProduct = json["tabsProduct"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["special"] = special;
    data["categorys"] = categorys;
    data["tabsProduct"] = tabsProduct;
    return data;
  }

  HomeModel copyWith({special, categorys, tabsProduct}) {
    return HomeModel(
        special: special ?? this.special,
        tabsProduct: tabsProduct ?? this.tabsProduct,
        categorys: categorys ?? this.categorys);
  }
}
