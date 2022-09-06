import 'package:coffe_flutter/widgets/buttons/btn_avatar.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  const AppBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ButtonAvatar(
          img: "https://www.ixbt.com/img/n1/news/2022/5/6/vk_large.jpg",
          radius: 10,
          width: 44,
          onPress: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
