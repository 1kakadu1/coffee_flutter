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
      splashColor: splashColor ?? Colors.brown.withOpacity(0.5),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 12),
      ),
      child: Ink(
        height: height,
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        child: child,
      ),
    );
  }
}
