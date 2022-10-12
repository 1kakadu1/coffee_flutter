import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

class ButtonDefault extends StatelessWidget {
  final Function onPress;
  final Widget text;
  final double? radius;
  final double? width;
  final double? height;
  const ButtonDefault(
      {Key? key,
      required this.onPress,
      required this.text,
      this.radius = 6,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      foregroundColor: AppColors.text,
      backgroundColor: AppColors.primary,
      minimumSize: const Size(32, 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 32)),
      ),
    );
    return Container(
      width: width,
      height: height,
      child: TextButton(
        style: flatButtonStyle,
        onPressed: () {},
        child: text,
      ),
    );
  }
}
