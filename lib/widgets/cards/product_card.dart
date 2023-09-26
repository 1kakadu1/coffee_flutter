import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_event.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:coffe_flutter/widgets/counter.dart';
import 'package:coffe_flutter/widgets/price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:cached_network_image/cached_network_image.dart';

final _decorationContainer = BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.backgroundLight,
      AppColors.backgraundLightBotto,
    ],
  ),
  borderRadius: BorderRadius.circular(12),
);

class ProductCard extends StatelessWidget {
  final double? width;
  final void Function(String id, ProductModel product) onPress;
  final ProductModel product;
  const ProductCard(
      {Key? key,
      this.width = 186,
      required this.product,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Intl.getCurrentLocale();
    final itemJson = product.toJson();
    final title = lang == "ru" ? itemJson["name"] : itemJson["name_$lang"];
    final description =
        lang == "ru" ? itemJson["description"] : itemJson["description_$lang"];
    return Container(
      width: width,
      decoration: _decorationContainer,
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
                  image: CachedNetworkImageProvider(product.preview),
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
            Positioned(
              top: 3,
              left: 3,
              child: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previousState, state) {
                return previousState.products != state.products;
              }, builder: (context, state) {
                int countSum = 0;
                for (int i = 0; i < product.size.length; i++) {
                  final index = state.products.indexWhere((element) =>
                      element.currentSize == product.size[i] &&
                      element.id == product.id);
                  final int count =
                      index == -1 ? 0 : state.products[index].count;
                  countSum += count;
                }

                return AnimatedOpacity(
                  opacity: countSum > 0 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(19, 19, 19, 0.8),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        countSum.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.write, fontSize: 14),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        onPress(product.id, product);
                      },
                    )))
          ],
        ),
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
                  description,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 14, color: AppColors.subtext),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        onPress(product.id, product);
                      },
                    )))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PriceText(
              price: product.price[product.size[0]].toString(),
            ),
            BlocBuilder<CartBloc, CartState>(buildWhen: (previousState, state) {
              return previousState.products != state.products;
            }, builder: (context, state) {
              return ButtonDefault(
                onPress: () {
                  context.read<CartBloc>().add(
                      CartAddAction(size: product.size[0], product: product));
                },
                width: 32,
                height: 32,
                radius: 12,
                text: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16.0,
                ),
              );
            }),
          ],
        )
      ]),
    );
  }
}

class ProductCartCard extends StatelessWidget {
  final double? width;
  final CartItemModel product;
  final Function? onAdd;
  final Function? onSub;
  final Function()? onRemove;
  final Animation<double>? animation;
  const ProductCartCard({
    Key? key,
    this.width = double.infinity,
    required this.product,
    this.onAdd,
    this.onSub,
    this.onRemove,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthWidget = MediaQuery.of(context).size.width;
    return animation == null
        ? _content(widthWidget)
        : GestureDetector(
            onLongPress: onRemove,
            child: ScaleTransition(
              scale: animation!,
              child: _content(widthWidget),
            ),
          );
  }

  _content(widthWidget) {
    return Container(
        width: width,
        decoration: _decorationContainer,
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: product.preview != null
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(product.preview!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(
                  width: widthWidget - 140,
                  child: TextScroll(
                    product.name,
                    delayBefore: const Duration(milliseconds: 1000),
                    pauseBetween: const Duration(milliseconds: 5000),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: widthWidget - 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          PriceText(
                            price: (product.price[product.currentSize] *
                                    product.count)
                                .toString(),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text("(${product.currentSize})")
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Counter(
                        onAdd: onAdd,
                        onSub: onSub,
                        counter: product.count,
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ));
  }
}

class ProductCartCardSkeleton extends StatelessWidget {
  final double? width;
  const ProductCartCardSkeleton({
    Key? key,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthWidget = MediaQuery.of(context).size.width;
    return SkeletonTheme(
      themeMode: ThemeMode.light,
      shimmerGradient: AppColors.skeletonGradient,
      child: Container(
        width: width,
        decoration: _decorationContainer,
        child: Row(children: [
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 90,
              height: 90,
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(
                    width: widthWidget - 140,
                    child: SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                          lines: 1,
                          spacing: 0,
                          padding: EdgeInsets.all(0),
                          lineStyle: SkeletonLineStyle(
                            maxLength: 10,
                          )),
                    )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: widthWidget - 140,
                    child: SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                          lines: 1,
                          spacing: 0,
                          padding: EdgeInsets.all(0),
                          lineStyle: SkeletonLineStyle(
                            maxLength: 10,
                          )),
                    )),
              ])),
        ]),
      ),
    );
  }
}

class ProductCardSkeleton extends StatelessWidget {
  final double? width;

  const ProductCardSkeleton({super.key, this.width = 186});
  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      themeMode: ThemeMode.light,
      shimmerGradient: AppColors.skeletonGradient,
      child: Container(
        width: width,
        height: 160,
        decoration: _decorationContainer,
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: width,
              height: 160,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SkeletonParagraph(
            style: const SkeletonParagraphStyle(
              lines: 1,
              spacing: 0,
              padding: EdgeInsets.all(0),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SkeletonParagraph(
            style: const SkeletonParagraphStyle(
              lines: 1,
              spacing: 0,
              padding: EdgeInsets.all(0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            Expanded(
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                    lines: 1,
                    spacing: 0,
                    padding: EdgeInsets.all(0),
                    lineStyle: SkeletonLineStyle(
                      maxLength: 10,
                    )),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 32,
                height: 32,
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
