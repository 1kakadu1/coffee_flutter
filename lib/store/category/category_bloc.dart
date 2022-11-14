import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState(isLoading: false, categorys: const [])) {
    on<CategoryEventGet>(_onGetCategory);
  }

  Future<void> _onGetCategory(
      CategoryEventGet event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var response = await apiServices.getHome();
      emit(state.copyWith(
          categorys: response.data.categorys,
          isLoading: false,
          error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error"));
    }
  }
}
