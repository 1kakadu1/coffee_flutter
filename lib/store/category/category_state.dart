part of 'category_bloc.dart';

class CategoryState {
  final List<CategoryModel> categorys;
  final bool isLoading;
  final String? error;

  CategoryState({required this.categorys, required this.isLoading, this.error});

  CategoryState copyWith({categorys, error, isLoading}) {
    return CategoryState(
        categorys: categorys ?? this.categorys,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }
}
