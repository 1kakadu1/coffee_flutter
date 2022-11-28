part of 'product_bloc.dart';

@immutable
abstract class ProductStateAbstract {}

class ProductState extends ProductStateAbstract {
  final ProductModel? product;
  final bool isLoading;
  final String? error;
  final String? size;

  ProductState({this.product, required this.isLoading, this.error, this.size});

  ProductState copyWith({error, isLoading, product, size}) {
    return ProductState(
        size: size ?? this.size,
        product: product ?? this.product,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }
}
