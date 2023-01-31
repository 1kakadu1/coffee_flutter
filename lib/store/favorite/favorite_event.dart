import 'package:coffe_flutter/models/favorite.model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteToggleAction extends FavoriteEvent {
  final FavoriteItemModel? product;
  FavoriteToggleAction({this.product});
}

class FavoriteClearAction extends FavoriteEvent {}

class FavoriteInitProductsAction extends FavoriteEvent {}
