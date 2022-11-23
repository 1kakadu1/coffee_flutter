import 'dart:developer';

import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_event.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';
import 'package:coffe_flutter/store/product/product_bloc.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/utils/product.utils.dart';
import 'package:coffe_flutter/widgets/buttons/btn_custom.dart';
import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:coffe_flutter/widgets/glass_paper.dart';
import 'package:coffe_flutter/widgets/price_text.dart';
import 'package:coffe_flutter/widgets/product_marker.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/navigation.model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductBloc productBloc = ProductBloc();
  bool _init = false;
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
      }
    }

    setState(() {
      _init = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return BlocProvider(
      create: (_) => productBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _scaffoldBottom(),
        body: Container(
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
                                      ? NetworkImage(state.product!.preview)
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
                                                state.product?.name ?? "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                state.product?.description ??
                                                    "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ProductMarker(
                                                iconName: isTea
                                                    ? "tea.png"
                                                    : "coffee.png",
                                                title: isTea ? "чай" : "кофе",
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
                                          title:
                                              state.product?.composition[0] ??
                                                  "",
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
                const Text(
                  "Описание: ",
                  style: TextStyle(fontSize: 16, color: AppColors.subtext),
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
                    builder: (context, state) => ExpandableText(
                          state.product?.description ?? "",
                          expandText: 'ещё',
                          collapseText: 'скрыть',
                          maxLines: 2,
                          linkColor: AppColors.primaryLight,
                          animation: true,
                          collapseOnTextTap: true,
                          style: const TextStyle(fontSize: 16),
                        )),
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
                      final list = state.product?.energy_and_nutritional_value
                              .map((item) => (Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                          const Text(
                            "Состав:",
                            style: TextStyle(
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
                    builder: (context, state) => Text(
                          "Размер (${state.product?.measurement_value ?? "мл"}): ",
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.subtext),
                        )),
                const SizedBox(
                  height: 14,
                ),
                BlocBuilder<ProductBloc, ProductState>(
                    bloc: productBloc,
                    builder: (context, state) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ..._itemBuilder(
                                state.product?.size ?? [], state.size ?? "",
                                (String value) {
                              productBloc.add(ProductEventChangeSize(value));
                            })
                          ],
                        ))
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _scaffoldBottom() {
    return Container(
      height: 70,
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
                        const Text("Цена",
                            style: TextStyle(
                                fontSize: 14, color: AppColors.subtext)),
                        const SizedBox(
                          height: 6,
                        ),
                        PriceText(
                          price: getPrice(
                                  price: state.product?.price,
                                  filtersSize: state.product?.size,
                                  size: state.size)
                              .toString(),
                        ),
                      ],
                    ),
                    ProductCounter(
                      size: state.size ?? "",
                      product: state.product,
                    )
                  ])),
    );
  }

  List<Widget> _itemBuilder(
      List<String> sizes, String currentSize, Function(String value) onChange) {
    List<Widget> items = [];
    for (int i = 0; i < sizes.length; i++) {
      log("current ${currentSize}");
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
            BlocProvider.of<CartBloc>(context)
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

class Counter extends StatelessWidget {
  final int? counter;
  final Function onAdd;
  final Function onSub;
  const Counter(
      {Key? key, this.counter = 0, required this.onAdd, required this.onSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonDefault(
          onPress: onSub,
          width: 30,
          height: 30,
          radius: 30,
          text: const Icon(
            Icons.remove,
            color: Colors.white,
            size: 16.0,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          counter.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          width: 12,
        ),
        ButtonDefault(
          onPress: onAdd,
          width: 30,
          height: 30,
          radius: 30,
          text: const Icon(
            Icons.add,
            color: Colors.white,
            size: 16.0,
          ),
        )
      ],
    );
  }
}
