import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

ThemeData customThemeLight() {
  final ThemeData base = ThemeData.dark();
  return ThemeData(
    fontFamily: 'JosefinSans',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    inputDecorationTheme:
        _customInputDecorationTheme(base.inputDecorationTheme),
    appBarTheme: _customAppBarTheme(base.appBarTheme),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.write),
  );
}

AppBarTheme _customAppBarTheme(AppBarTheme base) {
  return base.copyWith(
      // shadowColor: const Color(0xFFE5E5E5),
      //iconTheme: IconThemeData().copyWith(color: const Color(0xFF000000)),
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.write);
}

InputDecorationTheme _customInputDecorationTheme(InputDecorationTheme base) {
  return base.copyWith(
    labelStyle: const TextStyle(color: AppColors.subtext),
    filled: true,
    fillColor: AppColors.backgraundLight,
    prefixIconColor: AppColors.subtext,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.subtext),
      borderRadius: BorderRadius.circular(14.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.backgraundLight),
      borderRadius: BorderRadius.circular(14.0),
    ),
  );
}
