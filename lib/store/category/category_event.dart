part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {}

class CategoryEventGet extends CategoryEvent {
  @override
  List<Object?> get props => [];
}

class CategorySetEventGet extends CategoryEvent {
  final List<CategoryModel> categorys;

  CategorySetEventGet(this.categorys);

  @override
  List<Object?> get props => [categorys];
}
