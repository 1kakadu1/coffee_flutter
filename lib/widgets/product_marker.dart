import 'package:flutter/material.dart';

import '../theme/theme_const.dart';

class ProductMarker extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final String? title;
  final String? iconName;
  final Color? iconColor;
  final Color? color;
  final EdgeInsets? padding;
  const ProductMarker(
      {Key? key,
      this.width,
      this.height,
      this.radius,
      this.iconName,
      this.title,
      this.iconColor,
      this.color,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.backgraundLight,
        borderRadius: BorderRadius.circular(radius ?? 8),
        border: Border.all(
          color: color ?? AppColors.backgraundLight,
          width: 2,
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconName != null
                ? Image.asset(
                    'assets/img/icons/$iconName',
                    width: 20,
                    height: 20,
                    color: iconColor ?? AppColors.primary,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
            title != null
                ? Padding(
                    padding: EdgeInsets.only(top: iconName != null ? 4 : 0),
                    child: Text(
                      title!,
                      style: const TextStyle(fontSize: 10),
                    ),
                  )
                : const SizedBox(),
          ]),
    );
  }
}
