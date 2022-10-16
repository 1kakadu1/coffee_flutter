import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

class ButtonCart extends StatelessWidget {
  final String? img;
  final double? width;
  final double? height;
  final Function? onPress;
  final Color? color;
  final int counter;
  const ButtonCart({
    Key? key,
    this.img = "assets/img/icons/cart.png",
    this.width = 20,
    this.height = 20,
    this.onPress,
    this.color = AppColors.menuIcon,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: height,
      //width: width,
      child: Stack(children: [
        Image.asset(
          img!,
          width: width,
          height: height,
          color: color,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: counter > 0 ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.red[400],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                  child: Text(
                counter.toString(),
                style: const TextStyle(fontSize: 0),
              )),
            ),
          ),
        )
      ]),
    );
  }
}
