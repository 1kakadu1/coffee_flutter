import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc()
      : super(ProductsState(
          isLoading: false,
          products: const [],
        )) {
    on<ProductsEventRefresh>(_onRefreshProduct);
    on<ProductsEventChangeCategory>(_onChangeCategory);
    on<ProductsEventGetCategory>(_onGetProducts);
  }

  Future<void> _onGetProducts(
      ProductsEventGetCategory event, Emitter<ProductsState> emit) async {
    try {
      if (state.products.isEmpty) {
        emit(state.copyWith(isLoading: true, error: null));
      }
      var response =
          await apiServices.getProductCategory(event.categoryID ?? 'id-all');
      emit(state.copyWith(
          products: [...state.products, ...response.data],
          error: response.error,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onChangeCategory(
      ProductsEventChangeCategory event, Emitter<ProductsState> emit) async {
    try {
      var response = await apiServices.getProductCategory(event.categoryID);
      emit(state.copyWith(
          products: response.data,
          error: response.error,
          catID: event.categoryID));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error"));
    }
  }

  Future<void> _onRefreshProduct(
      ProductsEventRefresh event, Emitter<ProductsState> emit) async {
    try {
      var response =
          await apiServices.getProductCategory(state.catID ?? 'id-all');
      emit(state.copyWith(
          products: response.data, error: response.error, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    } finally {
      event.completer.complete();
    }
  }
}
