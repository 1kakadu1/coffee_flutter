import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent {}

class HomeEventInit extends HomeEvent {}

class HomeEventSetCategory extends HomeEvent {
  final List<CategoryModel> categorys;

  HomeEventSetCategory(this.categorys);
}
