import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCart extends StatelessWidget {
  final String? img;
  final double? width;
  final double? height;
  final Function? onPress;
  final Color? color;
  final int? counter;
  const ButtonCart({
    Key? key,
    this.img = "assets/img/icons/cart.png",
    this.width = 20,
    this.height = 20,
    this.onPress,
    this.color = AppColors.menuIcon,
    this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(buildWhen: (previousState, state) {
      return previousState.products != state.products;
    }, builder: (context, state) {
      int countSum = 0;
      for (int i = 0; i < state.products.length; i++) {
        countSum += state.products[i].count;
      }

      return Stack(children: [
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
            opacity: countSum > 0 ? 1 : 0,
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
                countSum.toString(),
                style: const TextStyle(fontSize: 0),
              )),
            ),
          ),
        )
      ]);
    });
  }
}
