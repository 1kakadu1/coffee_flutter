import 'dart:developer';

import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/widgets/buttons/btn_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  AppBarCustom({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      actions: [
        BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previousState, state) {
              log("auth ${state.isAuth}");
              return previousState.isAuth != state.isAuth ||
                  state.user?.preview != previousState.user?.preview;
            },
            builder: (context, state) => ButtonAvatar(
                  img: state.isAuth &&
                          state.user?.preview != null &&
                          state.user?.preview != ""
                      ? state.user!.preview!
                      : "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/users%2Fno-avatar-25359d55aa3c93ab3466622fd2ce712d1.jpg?alt=media&token=55ad603a-222f-4cb9-844c-11e2b9c41d51&_gl=1*1se3xc1*_ga*OTY2NjYwNjYwLjE2NjI1NzYwMzA.*_ga_CW55HF8NVT*MTY4NjU4NzgwMC4xMi4xLjE2ODY1ODc4NzUuMC4wLjA.",
                  radius: 10,
                  width: 44,
                  assets: false,
                  onPress: () {
                    if (state.isAuth == false) {
                      Navigator.pushNamed(
                        context,
                        PathRoute.login,
                      );
                    }
                  },
                ))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
