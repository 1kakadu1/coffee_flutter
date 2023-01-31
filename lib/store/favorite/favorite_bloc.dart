import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/database/database.dart';
import 'package:coffe_flutter/database/models/cart.hive.model.dart';
import 'package:coffe_flutter/database/models/favorite.hive.model.dart';
import 'package:coffe_flutter/models/favorite.model.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/favorite/favorite_event.dart';
import 'package:coffe_flutter/store/favorite/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(products: const [], isLoading: false)) {
    on<FavoriteClearAction>(_clearCartProduct);
    on<FavoriteToggleAction>(_toggleItemFavorite);
    on<FavoriteInitProductsAction>(_onInitFavorite);
  }

  _clearCartProduct(FavoriteClearAction event, Emitter<FavoriteState> emit) {
    emit(state.copyWith(products: []));
  }

  _toggleItemFavorite(
      FavoriteToggleAction event, Emitter<FavoriteState> emit) async {
    final product = event.product;
    List<FavoriteItemModel> items = [...state.products];
    if (product != null) {
      int item = [...state.products].indexWhere((x) => x.id == product.id);
      if (item == -1) {
        final value = FavoriteItemModel(
          name: product.name,
          preview: product.preview,
          id: product.id,
          categorys: event.product!.categorys,
          description: product.description,
        );
        items.add(value);
        await DatabaseHive.createFavoriteItem(
          FavoriteHive(
            name: value.name,
            preview: value.preview ?? "",
            id: value.id,
            categorys: value.categorys,
            description: value.description,
          ),
        );
      } else {
        await DatabaseHive.whereDelateFavoriteItem(id: items[item].id);
        items.removeAt(item);
      }

      emit(state.copyWith(products: items));
    }
  }

  Future<void> _onInitFavorite(
      FavoriteInitProductsAction event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final localProducts = await DatabaseHive.getFavoriteProducts();
      if (localProducts.isNotEmpty) {
        final favorites = localProducts
            .map((e) => FavoriteItemModel.fromJson(e.toJson()))
            .toList();
        var response = await apiServices.getFavoriteProducts(favorites);

        emit(state.copyWith(
            products: response.data, isLoading: false, error: response.error));
      } else {
        emit(state.copyWith(products: [], isLoading: false, error: null));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
