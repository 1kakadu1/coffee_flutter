import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final HomeBloc homeBloc;
  late final StreamSubscription homeBlocSubscription;
  CategoryBloc(this.homeBloc)
      : super(const CategoryState(isLoading: false, categorys: [])) {
    on<CategoryEventGet>(_onGetCategory);
    on<CategorySetEventGet>(_setCategoryList);
    homeBlocSubscription = homeBloc.stream.listen((state) {
      if (state.isLoading == false &&
          state.error == null &&
          state.categorys.isNotEmpty) {
        add(CategorySetEventGet(state.categorys));
      }
    });
  }

  @override
  Future<void> close() async {
    homeBlocSubscription.cancel();
    return super.close();
  }

  Future<void> _onGetCategory(
      CategoryEventGet event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var response = await apiServices.getCategoryList();
      emit(state.copyWith(
          categorys: response.data, isLoading: false, error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _setCategoryList(
      CategorySetEventGet event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(
        categorys: event.categorys, isLoading: false, error: null));
  }
}
