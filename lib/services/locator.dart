import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/favorite/favorite_bloc.dart';
import 'package:coffe_flutter/store/history/history_bloc.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:coffe_flutter/store/products/products_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Api>(Api());
  locator.registerSingleton<ProductsBloc>(ProductsBloc());
  locator.registerSingleton<HomeBloc>(HomeBloc());

  locator.registerLazySingleton<CartBloc>(() => CartBloc());
  locator.registerLazySingleton<FavoriteBloc>(() => FavoriteBloc());
  locator.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  locator.registerLazySingleton<HistoryBloc>(() => HistoryBloc());
}

void setupLocatorContext(BuildContext ctx) {
  locator.registerSingleton<Api>(Api());
}
