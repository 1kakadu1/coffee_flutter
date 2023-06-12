import 'package:flutter/material.dart';

@immutable
abstract class ProfileEvent {}

class ProfileLoadingAction extends ProfileEvent {
  final bool isLoadingAuth;

  ProfileLoadingAction(this.isLoadingAuth);
}

class ProfileChangeAuthAction extends ProfileEvent {
  final bool isAuth;

  ProfileChangeAuthAction(this.isAuth);
}

class ProfileSetErrorAction extends ProfileEvent {
  final String? error;
  ProfileSetErrorAction(this.error);
}

class ProfileGetAction extends ProfileEvent {
  final String id;
  ProfileGetAction(this.id);
}

class ProfileSingInAction extends ProfileEvent {
  final String email;
  final String password;
  ProfileSingInAction({required this.email, required this.password});
}
