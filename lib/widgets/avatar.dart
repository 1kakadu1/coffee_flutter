import 'package:coffe_flutter/models/user.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final bool isAuth;
  final UserCustom user;
  final bool? isBorder;
  final double? size;
  final bool? hideName;
  final bool? isTap;
  const UserAvatar(
      {super.key,
      required this.isAuth,
      required this.user,
      this.isBorder,
      this.size = 40.0,
      this.hideName = false,
      this.isTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isTap == true) {
          Navigator.pushNamed(context, PathRoute.profile);
        }
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: size != null && isBorder == true ? size! + 3.0 : size,
        child: CircleAvatar(
          radius: size,
          backgroundColor: AppColors.red[300],
          backgroundImage: _getAvatar(isAuth, user, context),
          child: Text(
            hideName == true ? "" : _getAvatarName(isAuth, user),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

String _getAvatarName(bool isAuth, UserCustom info) {
  if (isAuth == false) {
    return "";
  }
  final nameSplit = info.name.toUpperCase().split("");
  return nameSplit[0] + nameSplit[1];
}

ImageProvider<Object>? _getAvatar(
    bool isAuth, UserCustom info, BuildContext context) {
  final isImageUser = info.preview != null && info.preview != "" ? true : false;
  const ImageProvider fake = AssetImage('assets/img/man.png');
  final ImageProvider preview = isAuth == true
      ? isImageUser == true
          ? NetworkImage(info.preview!)
          : fake
      : fake;

  return preview;
}
