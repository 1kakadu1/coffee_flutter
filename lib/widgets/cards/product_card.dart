import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final double? width;
  final ProductModel product;
  const ProductCard({Key? key, this.width = 186, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgraundLight,
            AppColors.backgraundLightBotto,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            Container(
              width: width,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(product.preview),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 60,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(19, 19, 19, 0.8),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.primary,
                      size: 16.0,
                    ),
                    Text(product.rating.toString())
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 40,
          child: Text(
            product.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          product.description,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: AppColors.subtext),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _cardPrice(),
            ButtonDefault(
              onPress: () {},
              width: 32,
              height: 32,
              radius: 12,
              text: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16.0,
              ),
            )
          ],
        )
      ]),
    );
  }

  Widget _cardPrice() {
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
          product.price[product.size[0]].toString(),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
