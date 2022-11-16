import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/store/product/product_bloc.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
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
                        builder: (context, state) => Positioned(
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
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              state.product?.description ?? "",
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
                                          children: const [
                                            ProductMarker(
                                              iconName: "coffee.png",
                                              title: "Coffee",
                                              color: AppColors.black,
                                              width: 44,
                                              height: 44,
                                            ),
                                            ProductMarker(
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
                                            state.product?.composition[0] ?? "",
                                        padding: const EdgeInsets.all(10),
                                        width: (44 * 2) + 20,
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                            ))),
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
                    buildWhen: (previousState, state) {
                      return previousState.product?.size != state.product?.size;
                    },
                    builder: (context, state) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ..._itemBuilder(state.product?.size ?? [],
                                state.product?.size[0] ?? "")
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
          buildWhen: (previousState, state) {
            return previousState.product != state.product;
          },
          builder: (context, state) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Цена",
                            style: TextStyle(
                                fontSize: 14, color: AppColors.subtext)),
                        SizedBox(
                          height: 6,
                        ),
                        PriceText(
                          price: "0.0",
                        ),
                      ],
                    ),
                    ButtonDefault(
                      onPress: () {},
                      text: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Добавить",
                          style: TextStyle(color: AppColors.write),
                        ),
                      ),
                    ),
                  ])),
    );
  }

  List<Widget> _itemBuilder(List<String> sizes, String currentSize) {
    List<Widget> items = [];
    for (int i = 0; i < sizes.length; i++) {
      items.add(ButtonCustom(
        borderColor: AppColors.blackLight,
        background: AppColors.blackLight,
        activeColor: AppColors.black,
        activeBorder: AppColors.primary,
        active: sizes[i] == currentSize,
        width: 60,
        color: AppColors.red[400],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text(sizes[i].toUpperCase())),
        ),
        onPress: () {},
      ));
    }
    return items;
  }
}


                //                 BlocBuilder<ProductBloc, ProductState>(
                // bloc: productBloc,
                // builder: (context, state) => )