import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/models/favorite.model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_event.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';
import 'package:coffe_flutter/store/favorite/favorite_bloc.dart';
import 'package:coffe_flutter/store/favorite/favorite_event.dart';
import 'package:coffe_flutter/store/favorite/favorite_state.dart';
import 'package:coffe_flutter/store/product/product_bloc.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/product.utils.dart';
import 'package:coffe_flutter/widgets/buttons/btn_custom.dart';
import 'package:coffe_flutter/widgets/counter.dart';
import 'package:coffe_flutter/widgets/glass_paper.dart';
import 'package:coffe_flutter/widgets/price_text.dart';
import 'package:coffe_flutter/widgets/product_marker.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/navigation.model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductBloc productBloc = ProductBloc();
  bool _init = false;
  final _lang = Intl.getCurrentLocale();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      final NavigationArgumentsProduct arguments = ModalRoute.of(context)
          ?.settings
          .arguments as NavigationArgumentsProduct;
      if (arguments.product != null) {
        productBloc
            .add(ProductEventSet(isLoading: false, product: arguments.product));
      } else if (arguments.id != null) {
        productBloc.add(ProductEventRefresh(arguments.id));
      }
    }

    setState(() {
      _init = true;
    });
  }

  Future<void> _pullRefresh() async {
    final NavigationArgumentsProduct arguments = ModalRoute.of(context)
        ?.settings
        .arguments as NavigationArgumentsProduct;
    if (arguments.product != null) {
      productBloc.add(ProductEventRefresh(arguments.product!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return BlocProvider(
      create: (_) => productBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _scaffoldBottom(),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height + 12,
                  ),
                  Container(
                    child: Stack(children: [
                      BlocBuilder<ProductBloc, ProductState>(
                          bloc: productBloc,
                          buildWhen: (previousState, state) {
                            return previousState.product?.preview !=
                                state.product?.preview;
                          },
                          builder: (context, state) => Container(
                                height: 420,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  image: DecorationImage(
                                    image: state.product != null
                                        ? CachedNetworkImageProvider(
                                            state.product!.preview)
                                        : const AssetImage(
                                                "assets/img/no_img_avaliable.jpg")
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
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
                                BlocBuilder<ProductBloc, ProductState>(
                                    bloc: productBloc,
                                    builder: (contextProduct, stateProduct) =>
                                        BlocBuilder<FavoriteBloc,
                                            FavoriteState>(
                                          buildWhen: (previousState, state) {
                                            return previousState
                                                    .products.length !=
                                                state.products.length;
                                          },
                                          builder: (context, state) {
                                            bool isFavorite = state.products
                                                .where((element) =>
                                                    element.id ==
                                                    stateProduct.product?.id)
                                                .toList()
                                                .isNotEmpty;
                                            return ButtonPrimary(
                                              onPress: () {
                                                final product =
                                                    stateProduct.product;
                                                if (product != null) {
                                                  context
                                                      .read<FavoriteBloc>()
                                                      .add(FavoriteToggleAction(
                                                          product: FavoriteItemModel(
                                                              description_en:
                                                                  product
                                                                      .description_en,
                                                              description_ua:
                                                                  product
                                                                      .description_ua,
                                                              categorys: product
                                                                  .categorys,
                                                              id: product.id,
                                                              description: product
                                                                  .description,
                                                              name:
                                                                  product.name,
                                                              name_en: product
                                                                  .name_en,
                                                              name_ua: product
                                                                  .name_ua,
                                                              preview: product
                                                                  .preview)));
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.favorite,
                                                    size: 12,
                                                    color: isFavorite == true
                                                        ? AppColors.primaryLight
                                                        : AppColors.btnText,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )),
                              ]),
                        ),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                          bloc: productBloc,
                          buildWhen: (previousState, state) {
                            return previousState.product != state.product;
                          },
                          builder: (context, state) {
                            final isTea = state.product?.categorys
                                    .where((element) => element == "id-tea")
                                    .isNotEmpty ??
                                false;
                            String? name = state.product?.name_en;
                            String? description = state.product?.description_en;
                            List<String>? composition =
                                state.product?.composition_en;
                            if (_lang == 'ru') {
                              name = state.product?.name;
                              description = state.product?.description;
                              composition = state.product?.composition;
                            } else if (_lang == "uk") {
                              name = state.product?.name_ua;
                              description = state.product?.description_ua;
                              composition = state.product?.composition_ua;
                            }
                            return Positioned(
                                bottom: 0,
                                child: GlassPaper(
                                  height: 130,
                                  radius: 12,
                                  color: AppColors.glass,
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name ?? "",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  description ?? "",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ProductMarker(
                                                  iconName: isTea
                                                      ? "tea.png"
                                                      : "coffee.png",
                                                  title: isTea
                                                      ? S.of(context).markerTea
                                                      : S
                                                          .of(context)
                                                          .markerCoffee,
                                                  color: AppColors.black,
                                                  width: 44,
                                                  height: 44,
                                                ),
                                                const ProductMarker(
                                                  iconName: "water.png",
                                                  color: AppColors.black,
                                                  width: 44,
                                                  height: 44,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: AppColors.primary,
                                                size: 16.0,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(state.product?.rating
                                                      .toString() ??
                                                  "0")
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          ProductMarker(
                                            color: AppColors.black,
                                            title: composition?[0] ?? "",
                                            padding: const EdgeInsets.all(10),
                                            width: (44 * 2) + 20,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ));
                          }),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).description,
                    style:
                        const TextStyle(fontSize: 16, color: AppColors.subtext),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                      bloc: productBloc,
                      buildWhen: (previousState, state) {
                        return previousState.product?.description !=
                            state.product?.description;
                      },
                      builder: (context, state) {
                        final description = _lang == 'ru'
                            ? state.product?.description
                            : _lang == "uk"
                                ? state.product?.description_ua
                                : state.product?.description_en;
                        return ExpandableText(
                          description ?? "",
                          expandText: S.of(context).more,
                          collapseText: S.of(context).hide,
                          maxLines: 2,
                          linkColor: AppColors.primaryLight,
                          animation: true,
                          collapseOnTextTap: true,
                          style: const TextStyle(fontSize: 16),
                        );
                      }),
                  const SizedBox(
                    height: 36,
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                      bloc: productBloc,
                      buildWhen: (previousState, state) {
                        return previousState
                                .product?.energy_and_nutritional_value !=
                            state.product?.energy_and_nutritional_value;
                      },
                      builder: (context, state) {
                        final list_lang = _lang == 'ru'
                            ? state.product?.energy_and_nutritional_value
                            : _lang == "uk"
                                ? state.product?.energy_and_nutritional_value_ua
                                : state
                                    .product?.energy_and_nutritional_value_en;
                        final list = list_lang?.map((item) => (Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(item["title"] + ": "),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(item["value"].toString())
                                  ],
                                ))) ??
                            [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).composition,
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.subtext),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ...list,
                            const SizedBox(
                              height: 14,
                            ),
                          ],
                        );
                      }),
                  BlocBuilder<ProductBloc, ProductState>(
                      bloc: productBloc,
                      buildWhen: (previousState, state) {
                        return previousState.product?.measurement_value !=
                            state.product?.measurement_value;
                      },
                      builder: (context, state) {
                        final measurement = _lang == 'ru'
                            ? state.product?.measurement_value
                            : _lang == "uk"
                                ? state.product?.measurement_value_ua
                                : state.product?.measurement_value_en;
                        final sizeLabel = S.of(context).productSize;
                        return Text(
                          "$sizeLabel (${measurement ?? "ml"}): ",
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.subtext),
                        );
                      }),
                  const SizedBox(
                    height: 14,
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                      bloc: productBloc,
                      builder: (context, state) => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ..._itemBuilder(state.product?.size ?? [],
                                  state.size ?? state.product?.size[0] ?? "",
                                  (String value) {
                                productBloc.add(ProductEventChangeSize(value));
                              }),
                            ],
                          )),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget _scaffoldBottom() {
    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: AppColors.black,
      child: BlocBuilder<ProductBloc, ProductState>(
          bloc: productBloc,
          builder: (context, state) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).price,
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.subtext)),
                        const SizedBox(
                          height: 6,
                        ),
                        PriceText(
                          price: getPrice(
                                  price: state.product?.price,
                                  filtersSize: state.product?.size,
                                  size: state.size ??
                                      state.product?.size[0] ??
                                      "")
                              .toString(),
                        ),
                      ],
                    ),
                    ProductCounter(
                      size: state.size ?? state.product?.size[0] ?? "",
                      product: state.product,
                    )
                  ])),
    );
  }

  List<Widget> _itemBuilder(
      List<String> sizes, String currentSize, Function(String value) onChange) {
    List<Widget> items = [];
    for (int i = 0; i < sizes.length; i++) {
      items.add(ButtonCustom(
        key: Key(sizes[i]),
        borderColor: AppColors.blackLight,
        background: AppColors.blackLight,
        activeColor: AppColors.black,
        activeBorder: AppColors.primary,
        active: sizes[i] == currentSize,
        width: 60,
        color: AppColors.red[400],
        onPress: () {
          onChange(sizes[i]);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text(sizes[i].toUpperCase())),
        ),
      ));
    }
    return items;
  }
}

class ProductCounter extends StatelessWidget {
  final ProductModel? product;
  final String size;
  const ProductCounter({
    Key? key,
    required this.product,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final index = state.products.indexWhere((element) =>
            element.currentSize == size && element.id == product?.id);
        final int count = index == -1 ? 0 : state.products[index].count;

        return Counter(
          counter: count,
          onAdd: () {
            context
                .read<CartBloc>()
                .add(CartAddAction(size: size, product: product));
          },
          onSub: () {
            BlocProvider.of<CartBloc>(context)
                .add(CartSubAction(size: size, product: product));
          },
        );
      },
    );
  }
}
