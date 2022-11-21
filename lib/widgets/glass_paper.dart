import 'dart:ui';

import 'package:flutter/material.dart';

class GlassPaper extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  const GlassPaper(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.color,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              color: color ?? Colors.grey.shade200.withOpacity(0.5)),
          child: child,
        ),
      ),
    );
  }
}
