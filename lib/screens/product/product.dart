import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/buttons/btn_custom.dart';
import 'package:coffe_flutter/widgets/glass_paper.dart';
import 'package:coffe_flutter/widgets/product_marker.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height + 12,
              ),
              Container(
                child: Stack(children: [
                  Container(
                    height: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: DecorationImage(
                        image: NetworkImage(productsMock[0].preview),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonPrimary(
                              onPress: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 12,
                                    color: AppColors.btnText,
                                  ),
                                ],
                              ),
                            ),
                            ButtonPrimary(
                              onPress: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.favorite,
                                    size: 12,
                                    color: AppColors.btnText,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: GlassPaper(
                        height: 114,
                        radius: 12,
                        color: AppColors.glass,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productsMock[0].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      productsMock[0].description,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.subtext),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Row(
                                  children: const [
                                    ProductMarker(
                                      iconName: "coffee.png",
                                      title: "Coffee",
                                      color: AppColors.black,
                                      width: 44,
                                      height: 44,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    ProductMarker(
                                      iconName: "water.png",
                                      color: AppColors.black,
                                      width: 44,
                                      height: 44,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                ProductMarker(
                                  color: AppColors.black,
                                  title: "Lorem lorem",
                                  padding: const EdgeInsets.all(10),
                                  width: (44 * 2) + 6,
                                ),
                              ],
                            )
                          ]),
                        ),
                      ))
                ]),
              )
            ],
          ),
        )),
      ),
    );
  }
}
