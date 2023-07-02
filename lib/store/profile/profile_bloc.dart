import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/profile/profile_event.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileState(user: null, isLoadingAuth: false, isAuth: false)) {
    on<ProfileSingInAction>(_onSingIn);
    on<ProfileGetAction>(_getUser);
  }

  Future<void> _onSingIn(
      ProfileSingInAction event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoadingAuth: true, error: null));
    try {
      var response = await apiServices.signInWithEmailAndPassword(
          event.email, event.password);
      emit(state.copyWith(
          isLoadingAuth: false, isAuth: true, user: response.data));
    } catch (e) {
      emit(state.copyWith(isLoadingAuth: false, error: e.toString()));
    }
  }

  Future<void> _getUser(
      ProfileGetAction event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoadingAuth: true, error: null));
    try {
      var response = await apiServices.getUser(event.id);
      log("profile get ${response.data?.email.toString() ?? "not"}");
      emit(state.copyWith(
          isLoadingAuth: false, isAuth: true, user: response.data));
    } catch (e) {
      emit(state.copyWith(isLoadingAuth: false, error: e.toString()));
    }
  }
}
