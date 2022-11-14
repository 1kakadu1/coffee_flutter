import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/home/home_event.dart';
import 'package:coffe_flutter/store/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState(
            categorys: const [], special: const [], isLoading: false)) {
    on<HomeEventInit>(_onGetHome);
  }

  Future<void> _onGetHome(HomeEventInit event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var response = await apiServices.getHome();
      emit(state.copyWith(
          special: response.data.special,
          categorys: response.data.categorys,
          isLoading: false,
          error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error"));
    }
  }
}
