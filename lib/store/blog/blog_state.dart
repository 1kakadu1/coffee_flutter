import 'package:coffe_flutter/models/blog.model.dart';

class BlogState {
  final List<BlogModel> posts;
  final bool isLoading;
  final String? error;
  BlogState({required this.posts, required this.isLoading, this.error});

  BlogState copyWith({List<BlogModel>? posts, bool? isLoading, String? error}) {
    return BlogState(
        posts: posts ?? this.posts,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}
