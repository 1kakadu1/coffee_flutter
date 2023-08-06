part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent extends Equatable {}

class ProductsEventChangeCategory extends ProductsEvent {
  final String categoryID;

  ProductsEventChangeCategory(this.categoryID);

  @override
  List<Object?> get props => [categoryID];
}

class ProductsEventGetCategory extends ProductsEvent {
  final String? categoryID;

  ProductsEventGetCategory({this.categoryID});

  @override
  List<Object?> get props => [categoryID];
}

class ProductsEventRefresh extends ProductsEvent {
  final Completer completer;
  ProductsEventRefresh(this.completer);

  @override
  List<Object?> get props => [completer];
}
