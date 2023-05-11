import 'dart:async';

import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_event.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:coffe_flutter/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/price_text.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    initCart();
  }

  void initCart() async {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    if (cartBloc.state.products.isNotEmpty) {
      cartBloc.add(CartUpdateProductsAction());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: BlocBuilder<CartBloc, CartState>(buildWhen: (previousState, state) {
        return previousState.products != state.products;
      }, builder: (context, state) {
        return Stack(
          children: [
            _AnimatedListCart(
              items: state.products,
              ctx: context,
            ),
            Positioned.fill(
              child: AnimatedScale(
                scale: state.products.isEmpty ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/cart-empty.png",
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Корзина пуста")
                      ],
                    )),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _bottomNavigationBar() {
    return BlocBuilder<CartBloc, CartState>(buildWhen: (previousState, state) {
      return previousState.products != state.products;
    }, builder: (context, state) {
      return AnimatedSlide(
        offset: state.products.isNotEmpty
            ? const Offset(0, 0)
            : const Offset(0, 400),
        duration: const Duration(milliseconds: 5000),
        curve: Curves.easeInOut,
        child: Container(
            height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundLight,
                  AppColors.backgraundLightBotto,
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Всего к оплате:",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    PriceText(
                      price: ("34").toString(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonDefault(
                  width: double.infinity,
                  onPress: () {
                    Navigator.pushNamed(context, PathRoute.order);
                  },
                  text: const Text(
                    "Оформить заказ",
                    style: TextStyle(color: AppColors.write),
                  ),
                )
              ],
            )),
      );
    });
  }
}

class _AnimatedListCart extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<CartItemModel> items;
  final int? delay;
  final BuildContext ctx;

  _AnimatedListCart(
      {Key? key, required this.items, this.delay = 1, required this.ctx})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loading =
        BlocProvider.of<CartBloc>(context, listen: true).state.isLoading;
    return AnimatedList(
      key: listKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) =>
          buildItem(items[index], index, animation, context, loading),
    );
  }

  Widget buildItem(CartItemModel item, int index, Animation<double> animation,
          BuildContext context, bool loading) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: loading
            ? const ProductCartCardSkeleton()
            : ProductCartCard(
                animation: animation,
                product: item,
                onAdd: () => _onAdd(item, context),
                onSub: () => _onSub(item, index, context),
                onRemove: () => _onRemove(item, index, context)),
      );

  void _onAdd(CartItemModel? product, BuildContext context) {
    if (product != null) {
      final CartBloc cartBloc =
          BlocProvider.of<CartBloc>(context, listen: false);
      cartBloc.add(CartAddAction(size: product.currentSize, cartItem: product));
    }
  }

  void _onRemove(CartItemModel product, int index, BuildContext context) {
    removeItem(index);
    Timer(Duration(seconds: delay ?? 1), () {
      final CartBloc cartBloc =
          BlocProvider.of<CartBloc>(context, listen: false);
      cartBloc.add(CartSubAction(size: product.currentSize, cartItem: product));
    });
  }

  void _onSub(CartItemModel? product, int index, BuildContext context) {
    if (product != null) {
      final CartBloc cartBloc =
          BlocProvider.of<CartBloc>(context, listen: false);
      bool isRemove = false;
      if (product.count - 1 == 0) {
        isRemove = true;
        //removeItem(index);
        //  Timer(
        // Duration(seconds: delay ?? 1),
        //() => {
        cartBloc
            .add(CartSubAction(size: product.currentSize, cartItem: product));
        // });
      } else if (product.count - 1 > 0 && !isRemove) {
        cartBloc
            .add(CartSubAction(size: product.currentSize, cartItem: product));
      }
    }
  }

  void insertItem(int index, CartItemModel item) {
    items.insert(index, item);
    listKey.currentState?.insertItem(index);
  }

  void removeItem(int index) {
    final item = items.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) {
        final loading =
            BlocProvider.of<CartBloc>(context, listen: false).state.isLoading;
        return buildItem(item, index, animation, context, loading);
      },
    );
  }
}
