import 'dart:developer';

import 'package:coffe_flutter/models/user.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/services/locator.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_event.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/validation.utils.dart';
import 'package:coffe_flutter/widgets/avatar.dart';
import 'package:coffe_flutter/widgets/fields/input_field.dart';
import 'package:coffe_flutter/widgets/upload_img_in_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Профиль"),
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app_outlined),
                onPressed: () {
                  final ProfileBloc profileBloc = locator.get<ProfileBloc>();
                  profileBloc.add(ProfileSingOutAction());
                  Navigator.popAndPushNamed(context, PathRoute.home);
                },
              ),
            ],
            bottom: const TabBar(
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(icon: Icon(Icons.settings)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) => BlocBuilder<ProfileBloc,
                        ProfileState>(
                    builder: (context, state) => SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: Text(
                                    "Ваши данные",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                UserAvatar(
                                  user: state.user!,
                                  isAuth: true,
                                  size: 80,
                                  isBorder: true,
                                  hideName: true,
                                ),
                                UploadImgInFirebase(
                                    onUploadSuccess: (String url) async {
                                  apiServices
                                      .updateUserField(
                                          state.user!.id, "preview", url)
                                      .then((value) {
                                    if (state.user != null) {
                                      context.read<ProfileBloc>().add(
                                          ProfileChangeFieldsAction(state.user!
                                              .copyWith(preview: url)));
                                    }
                                  });
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Input(
                                  enabled: state.isLoadingUpdate,
                                  label: "Имя",
                                  defaultValue: state.user?.name,
                                  onValidation: (value) {
                                    if (value.length < 3) {
                                      return "Минимальная длина 3 символа";
                                    }
                                    return null;
                                  },
                                  suffix: const Icon(Icons.save),
                                  onSubmit: (value) {
                                    _onUpdateField(context,
                                        userID: state.user!.id,
                                        field: 'name',
                                        value: value,
                                        user: state.user!);
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Input(
                                  enabled: state.isLoadingUpdate,
                                  label: "Email",
                                  defaultValue: state.user?.email,
                                  onValidation: validationEmail,
                                  suffix: const Icon(Icons.save),
                                  onSubmit: (value) {
                                    _onUpdateField(context,
                                        userID: state.user!.id,
                                        field: 'email',
                                        value: value,
                                        user: state.user!);
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Input(
                                  enabled: state.isLoadingUpdate,
                                  label: "Телефон",
                                  defaultValue: state.user?.phone,
                                  onValidation: validationPhone,
                                  suffix: const Icon(Icons.save),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    MaskedInputFormatter('+# (###) ####-###')
                                  ],
                                  onSubmit: (value) {
                                    _onUpdateField(context,
                                        userID: state.user!.id,
                                        field: 'phone',
                                        value: value,
                                        user: state.user!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
              Icon(Icons.directions_transit),
            ],
          ),
        ));
  }

  void _onUpdateField<T>(BuildContext context,
      {required String userID,
      required String field,
      required T value,
      required UserCustom user}) {
    context.read<ProfileBloc>().add(ProfileLoadingUpdateAction(true));
    apiServices.updateUserField(userID, field, value).then((r) {
      context.read<ProfileBloc>().add(ProfileChangeFieldsAction(user));
      const snackBar = SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          'Данные успешно обновлены',
          style: TextStyle(color: AppColors.black),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((Object error) {
      final snackBar = SnackBar(
        backgroundColor: AppColors.red[300],
        content: Text(
          'Ошибка: ${error.toString()}',
          style: const TextStyle(color: AppColors.write),
        ),
      );
      context.read<ProfileBloc>().add(ProfileLoadingUpdateAction(false));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
