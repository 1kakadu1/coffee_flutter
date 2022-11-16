import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState(isLoading: false, product: null)) {
    on<ProductEventSet>(_onSetProduct);
    on<ProductEventRefresh>(_onRefreshProduct);
  }

  Future<void> _onSetProduct(
      ProductEventSet event, Emitter<ProductState> emit) async {
    emit(state.copyWith(
        error: event.error,
        isLoading: event.isLoading,
        product: event.product));
  }

  Future<void> _onRefreshProduct(
      ProductEventRefresh event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {} catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error"));
    }
  }
}
