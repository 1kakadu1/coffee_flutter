import 'package:coffe_flutter/models/user.model.dart';

class ProfileState {
  final UserCustom? user;
  final bool isAuth;
  final bool isLoadingAuth;
  final String? error;
  final bool isLoadingUpdate;
  final bool isLoadingAuthOut;
  ProfileState(
      {required this.user,
      required this.isAuth,
      required this.isLoadingAuth,
      required this.isLoadingUpdate,
      required this.isLoadingAuthOut,
      this.error});

  ProfileState copyWith(
      {UserCustom? user,
      bool? isLoadingAuth,
      String? error,
      bool? isAuth,
      bool? isLoadingUpdate,
      bool? isLoadingAuthOut}) {
    return ProfileState(
        isLoadingAuthOut: isLoadingAuthOut ?? this.isLoadingAuthOut,
        user: user ?? this.user,
        isLoadingAuth: isLoadingAuth ?? this.isLoadingAuth,
        isAuth: isAuth ?? this.isAuth,
        error: error ?? this.error,
        isLoadingUpdate: isLoadingUpdate ?? this.isLoadingUpdate);
  }
}
