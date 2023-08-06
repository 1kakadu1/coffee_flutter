import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/category/category_bloc.dart';
import 'package:coffe_flutter/store/home/home_event.dart';
import 'package:coffe_flutter/store/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState(
            categorys: const [],
            special: const [],
            isLoading: false,
            activeTab: "id-all",
            tabsProduct: const [])) {
    on<HomeEventInit>(_onGetHome);
    on<HomeEventChangeCategory>(_onChangeCategory);
  }

  @override
  Future<void> close() async {
    return super.close();
  }

  Future<void> _onGetHome(HomeEventInit event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var response = await apiServices.getHome();
      emit(state.copyWith(
          special: response.data.special,
          tabsProduct: response.data.tabsProduct,
          categorys: sortCart(response.data.categorys),
          isLoading: false,
          error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error"));
    }
  }

  Future<void> _onChangeCategory(
      HomeEventChangeCategory event, Emitter<HomeState> emit) async {
    try {
      var response = await apiServices.getProductCategory(event.categoryID);
      emit(state.copyWith(tabsProduct: response.data, error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error"));
    }
  }
}

List<CategoryModel> sortCart(List<CategoryModel> items) {
  bool swapped;
  List<CategoryModel> list = [...items];

  void swap(List<CategoryModel> itemsSwap, int left, int right) {
    if (left != right) {
      CategoryModel temp = itemsSwap[left];
      itemsSwap[left] = itemsSwap[right];
      itemsSwap[right] = temp;
    }
  }

  do {
    swapped = false;
    for (int i = 1; i < list.length; i++) {
      if (list[i - 1].order.compareTo(items[i].order) > 0) {
        swap(list, i - 1, i);
        swapped = true;
      }
    }
  } while (swapped != false);

  return list;
}
