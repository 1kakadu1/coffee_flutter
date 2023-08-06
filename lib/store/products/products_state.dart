part of 'products_bloc.dart';

@immutable
abstract class ProductStateAbstract extends Equatable {}

class ProductsState extends ProductStateAbstract {
  final List<ProductModel> products;
  final bool isLoading;
  final String? error;
  final String? catID;

  ProductsState(
      {required this.products,
      required this.isLoading,
      this.error,
      this.catID = 'id-all'});

  ProductsState copyWith({error, isLoading, products, catID}) {
    return ProductsState(
        catID: catID ?? this.catID,
        products: products ?? this.products,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [products, isLoading, error, catID];
}
