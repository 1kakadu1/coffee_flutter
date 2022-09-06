import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  const TitleWidget({Key? key, required this.text, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Text(
        text,
        style: TextStyle()
            .copyWith(fontSize: fontSize ?? 30, fontWeight: FontWeight.w900),
      ),
    );
  }
}
