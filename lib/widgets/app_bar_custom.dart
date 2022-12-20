import 'package:coffe_flutter/widgets/buttons/btn_avatar.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  const AppBarCustom({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      actions: [
        ButtonAvatar(
          img: "assets/img/icon_appbar.png",
          radius: 10,
          width: 44,
          assets: true,
          onPress: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
