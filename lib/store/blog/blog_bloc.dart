import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/blog/blog_event.dart';
import 'package:coffe_flutter/store/blog/blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogState(posts: const [], isLoading: false)) {
    on<BlogInitAction>(_onInitFavorite);
  }

  Future<void> _onInitFavorite(
      BlogInitAction event, Emitter<BlogState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var response = await apiServices.getBlog(4);
      emit(state.copyWith(
          posts: response.data, isLoading: false, error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
