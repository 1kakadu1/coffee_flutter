import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_flutter/models/favorite.model.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:text_scroll/text_scroll.dart';

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

class FavoriteCard extends StatelessWidget {
  final double? width;
  final FavoriteItemModel product;
  final Function() onToggle;
  final Function() onPress;
  final Animation<double> animation;
  const FavoriteCard({
    Key? key,
    this.width = double.infinity,
    required this.product,
    required this.onToggle,
    required this.animation,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthWidget = MediaQuery.of(context).size.width;
    final lang = Intl.getCurrentLocale();
    final itemJson = product.toJson();
    final title = lang == "ru"
        ? itemJson["name"]
        : lang == "ua" || lang == "uk"
            ? itemJson["name_ua"]
            : itemJson["name_$lang"];
    final description = lang == "ru"
        ? itemJson["description"]
        : lang == "ua" || lang == "uk"
            ? itemJson["description_ua"]
            : itemJson["description_$lang"];
    return GestureDetector(
      onLongPress: onToggle,
      onTap: onPress,
      child: ScaleTransition(
        scale: animation,
        child: Container(
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
                      width: widthWidget - 180,
                      child: TextScroll(
                        title,
                        delayBefore: const Duration(milliseconds: 1000),
                        pauseBetween: const Duration(milliseconds: 5000),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: widthWidget - 180,
                      child: Text(
                        description ?? "",
                        style: const TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ]),
                ),
                IconButton(
                  color: AppColors.primaryLight,
                  icon: const Icon(Icons.delete),
                  onPressed: onToggle,
                )
              ],
            )),
      ),
    );
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

class FavoriteCardSkeleton extends StatelessWidget {
  final double? width;

  const FavoriteCardSkeleton({super.key, this.width = 186});
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
