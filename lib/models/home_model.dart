import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/product.model.dart';

class HomeModel {
  late List<ProductModel> special;
  late List<CategoryModel> categorys;

  HomeModel({
    required this.special,
    required this.categorys,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    special = json["special"] ?? [];
    categorys = json["categorys"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["special"] = special;
    data["categorys"] = categorys;
    return data;
  }

  HomeModel copyWith({special, categorys}) {
    return HomeModel(
        special: special ?? this.special,
        categorys: categorys ?? this.categorys);
  }
}
