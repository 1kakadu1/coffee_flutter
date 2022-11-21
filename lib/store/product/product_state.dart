part of 'product_bloc.dart';

@immutable
abstract class ProductStateAbstract {}

class ProductState extends ProductStateAbstract {
  final ProductModel? product;
  final bool isLoading;
  final String? error;

  ProductState({this.product, required this.isLoading, this.error});

  ProductState copyWith({error, isLoading, product}) {
    return ProductState(
        product: product ?? this.product,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }
}
