import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/history/history_event.dart';

import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc()
      : super(const HistoryState(items: [], isLoading: false, error: null)) {
    on<HistoryEventGetItemsAction>(_onHistory);
  }

  Future<void> _onHistory(
      HistoryEventGetItemsAction event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var response =
          await apiServices.getUserOrders(event.id, event.limit, event.offset);
      if (event.isRefresh == false) {
        emit(state.copyWith(
            isLoading: false,
            error: response.error,
            items: [...state.items, ...response.data]));
      } else {
        emit(state.copyWith(
            isLoading: false, error: response.error, items: response.data));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error"));
    } finally {
      if (event.completer != null) {
        event.completer?.complete();
      }
    }
  }
}
