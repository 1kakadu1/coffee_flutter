import 'package:coffe_flutter/models/user.model.dart';
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

class ProfileChangeFieldsAction extends ProfileEvent {
  final UserCustom fields;
  ProfileChangeFieldsAction(this.fields);
}

class ProfileLoadingUpdateAction extends ProfileEvent {
  final bool value;
  ProfileLoadingUpdateAction(this.value);
}

class ProfileSingOutAction extends ProfileEvent {}
