import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? padding;
  final Function onPress;
  final LinearGradient? gradient;
  final Color? color;
  final Color? splashColor;
  const ButtonCustom(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      required this.onPress,
      this.radius,
      this.padding,
      this.gradient,
      this.color,
      this.splashColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      splashColor: splashColor ?? Colors.brown,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
      child: Ink(
        height: height,
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(radius ?? 12),
            ),
            child: child),
      ),
    );
  }
}

class ButtonPrimary extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? radius;
  final Function onPress;
  final double? borderWidth;
  const ButtonPrimary(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.radius,
      this.borderWidth,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      radius: radius ?? 14,
      width: width ?? 36,
      height: height ?? 36,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          AppColors.gradientBlack[100]!,
          AppColors.gradientBlack[400]!,
        ],
      ),
      onPress: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 14),
          border: Border.all(
            color: AppColors.backgraundLight,
            width: borderWidth ?? 0,
          ),
        ),
        child: child,
      ),
    );
  }
}
