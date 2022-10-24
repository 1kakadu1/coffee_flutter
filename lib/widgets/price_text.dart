import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final String price;
  const PriceText({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '\$',
          style: TextStyle(fontSize: 18, color: AppColors.primary),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
