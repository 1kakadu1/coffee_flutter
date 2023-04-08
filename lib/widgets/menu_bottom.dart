import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

import 'buttons/btn_cart.dart';

final iconListUrl = <String>[
  "assets/img/icons/home.png",
  "assets/img/icons/favorite.png",
  "assets/img/icons/cart.png",
  "assets/img/icons/login.png",
];

class MenuScaffoldBottom extends StatefulWidget {
  final Function(int value) onChange;
  MenuScaffoldBottom({Key? key, required this.onChange}) : super(key: key);

  @override
  State<MenuScaffoldBottom> createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuScaffoldBottom> {
  late int _bottomNavIndex;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_6,
    Icons.brightness_7,
    Icons.brightness_4,
  ];

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      notchMargin: -4,
      gapWidth: 0,
      itemCount: iconList.length,
      splashColor: AppColors.primary,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? AppColors.primary : AppColors.menuIcon;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index != 2
                ? Image.asset(
                    iconListUrl[index],
                    width: 20,
                    height: 20,
                    color: color,
                    fit: BoxFit.cover,
                  )
                : ButtonCart(
                    counter: 0,
                    color: color,
                    width: 20,
                    height: 20,
                  )
          ],
        );
      },
      backgroundColor: AppColors.black,
      activeIndex: _bottomNavIndex,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) {
        setState(() => _bottomNavIndex = index);
        widget.onChange(index);
      },
    );
  }
}
