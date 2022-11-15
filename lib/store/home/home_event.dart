import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent {}

class HomeEventInit extends HomeEvent {}

class HomeEventChangeCategory extends HomeEvent {
  final String categoryID;

  HomeEventChangeCategory(this.categoryID);
}
