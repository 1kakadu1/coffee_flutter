part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class ProductEventSet extends ProductEvent {
  final ProductModel? product;
  final String? error;
  final bool isLoading;

  ProductEventSet({this.product, this.error, required this.isLoading});
}

class ProductEventRefresh extends ProductEvent {
  final String id;

  ProductEventRefresh(this.id);
}
