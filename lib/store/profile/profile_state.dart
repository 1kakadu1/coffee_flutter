import 'package:coffe_flutter/models/user.model.dart';

class ProfileState {
  final UserCustom? user;
  final bool isAuth;
  final bool isLoadingAuth;
  final String? error;
  ProfileState(
      {required this.user,
      required this.isAuth,
      required this.isLoadingAuth,
      this.error});

  ProfileState copyWith(
      {UserCustom? user, bool? isLoadingAuth, String? error, bool? isAuth}) {
    return ProfileState(
        user: user ?? this.user,
        isLoadingAuth: isLoadingAuth ?? this.isLoadingAuth,
        isAuth: isAuth ?? this.isAuth,
        error: error ?? this.error);
  }
}
