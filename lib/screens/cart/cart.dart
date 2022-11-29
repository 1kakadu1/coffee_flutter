import 'dart:async';

import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                duration: const Duration(milliseconds: 500),
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.black,
                    child: const Center(child: Text("Empty"))),
              ),
            )
          ],
        );
      }),
    );
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
    return AnimatedList(
      key: listKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) =>
          buildItem(items[index], index, animation, context),
    );
  }

  Widget buildItem(CartItemModel item, int index, Animation<double> animation,
          BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            child: ProductCartCard(
          product: item,
        )),
      );

  void _onAdd(CartItemModel? product, String size, int count, int index,
      BuildContext context) {}

  void _onRemove(
      CartItemModel product, String size, int index, BuildContext context) {
    if (product != null) {
      this.removeItem(index);
      Timer(Duration(seconds: delay ?? 1), () => {});
    }
  }

  void _onSub(CartItemModel? product, String size, int count, int index,
      BuildContext context) {
    bool isRemove = false;
    if (count - 1 == 0) {
      isRemove = true;
      this.removeItem(index);
      Timer(Duration(seconds: delay ?? 1), () => {});
    }
    if (product != null && count - 1 >= 0 && isRemove == false) {}
  }

  void insertItem(int index, CartItemModel item) {
    items.insert(index, item);
    listKey.currentState?.insertItem(index);
  }

  void removeItem(int index) {
    final item = items.removeAt(index);

    listKey.currentState?.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation, context),
    );
  }
}
