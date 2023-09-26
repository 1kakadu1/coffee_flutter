import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? width;
  const TitleWidget({Key? key, required this.text, this.fontSize, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 260,
      child: Text(
        text,
        style: TextStyle()
            .copyWith(fontSize: fontSize ?? 30, fontWeight: FontWeight.w900),
      ),
    );
  }
}
