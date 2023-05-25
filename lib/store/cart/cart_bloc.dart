import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/database/database.dart';
import 'package:coffe_flutter/database/models/cart.hive.model.dart';
import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/cart/cart_event.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';
import 'package:coffe_flutter/utils/cart.utils.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(products: const [], isLoading: false)) {
    on<CartClearAction>(_clearCartProduct);
    on<CartAddAction>(_addItem);
    on<CartSubAction>(_subItem);
    on<CartRemoveAction>(_removeItem);
    on<CartChangeCommentsAction>(_changeCommentItem);
    on<CartUpdateProductsAction>(_onUpdateCartProductData);
    on<CartInitProductsAction>(_onInitCart);
  }

  _clearCartProduct(CartClearAction event, Emitter<CartState> emit) async {
    await DatabaseHive.clearCartProducts();
    emit(state.copyWith(products: []));
  }

  _addItem(CartAddAction event, Emitter<CartState> emit) async {
    dynamic product = event.product ?? event.cartItem ?? event.cartItem;
    List<CartItemModel> items = [...state.products];
    if (product != null) {
      int item = [...state.products]
          .indexWhere((x) => x.id == product.id && x.currentSize == event.size);
      if (item == -1) {
        final value = CartItemModel(
            name: product.name,
            price: product.price,
            preview: product.preview,
            id: product.id,
            categorys: event.product!.categorys,
            count: 1,
            currentSize: event.size);
        items.add(value);
        DatabaseHive.createCartItem(
          CartHive(
              name: value.name,
              preview: value.preview ?? "",
              id: value.id,
              count: value.count,
              price: value.price,
              categorys: value.categorys,
              comments: value.comments,
              currentSize: value.currentSize),
        );
      } else {
        items[item] = items[item].copyWith(count: items[item].count + 1);
        DatabaseHive.whereUpdateCartItem(
            item: CartHive(
                name: items[item].name,
                preview: items[item].preview ?? "",
                id: items[item].id,
                count: items[item].count,
                price: items[item].price,
                categorys: items[item].categorys,
                comments: items[item].comments,
                currentSize: items[item].currentSize),
            size: items[item].currentSize,
            id: items[item].id);
      }

      final bool isNotification =
          await cartNotification.checkLocalNotification();
      if (isNotification == false) {
        cartNotification.setNotification();
      }

      emit(state.copyWith(products: items));
    }
  }

  _subItem(CartSubAction event, Emitter<CartState> emit) async {
    List<CartItemModel> items = [...state.products];
    dynamic product = event.product ?? event.cartItem ?? event.cartItem;
    if (product != null) {
      int item = [...state.products]
          .indexWhere((x) => x.id == product.id && x.currentSize == event.size);

      if (item != -1 && state.products[item].count - 1 > 0) {
        items[item] = items[item].copyWith(count: items[item].count - 1);
        DatabaseHive.whereUpdateCartItem(
            item: CartHive(
                name: items[item].name,
                preview: items[item].preview ?? "",
                id: items[item].id,
                count: items[item].count,
                price: items[item].price,
                categorys: items[item].categorys,
                comments: items[item].comments,
                currentSize: items[item].currentSize),
            size: items[item].currentSize,
            id: items[item].id);
      } else if (item != -1 && state.products[item].count - 1 <= 0) {
        await DatabaseHive.whereDelateCartItem(
            size: items[item].currentSize, id: items[item].id);
        items.removeAt(item);
        final bool isNotification =
            await cartNotification.checkLocalNotification();
        if (isNotification == true && items.isEmpty) {
          cartNotification.clearNotification();
        }
      }
    }

    emit(state.copyWith(products: items));
  }

  _removeItem(CartRemoveAction event, Emitter<CartState> emit) async {
    int item = [...state.products].indexWhere(
        (x) => x.id == event.product.id && x.currentSize == event.size);
    List<CartItemModel> items = [...state.products];

    if (item != -1) {
      DatabaseHive.whereUpdateCartItem(
          item: CartHive(
              name: items[item].name,
              preview: items[item].preview ?? "",
              id: items[item].id,
              count: items[item].count,
              price: items[item].price,
              categorys: items[item].categorys,
              comments: items[item].comments,
              currentSize: items[item].currentSize),
          size: items[item].currentSize,
          id: items[item].id);
      items.removeAt(item);
    }

    final bool isNotification = await cartNotification.checkLocalNotification();
    if (isNotification == true && items.isEmpty) {
      cartNotification.clearNotification();
    }

    return state.copyWith(products: items);
  }

  _changeCommentItem(CartChangeCommentsAction event, Emitter<CartState> emit) {
    List<CartItemModel> items = [...state.products];
    int itemIndex = items
        .indexWhere((x) => x.id == event.id && x.currentSize == event.size);
    items[itemIndex] =
        items[itemIndex].copyWith(comments: event.comments ?? "");
    return state.copyWith(products: items.toList());
  }

  Future<void> _onUpdateCartProductData(
      CartUpdateProductsAction event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var response = await apiServices.getCartProducts(state.products);

      response.data.toList().forEach(((value) {
        DatabaseHive.whereUpdateCartItem(
            item: CartHive(
                name: value.name,
                preview: value.preview ?? "",
                id: value.id,
                count: value.count,
                price: value.price,
                categorys: value.categorys,
                comments: value.comments,
                currentSize: value.currentSize),
            size: value.currentSize,
            id: value.id,
            notUpdateCount: true);
      }));

      emit(state.copyWith(
          products: response.data, isLoading: false, error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onInitCart(
      CartInitProductsAction event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final localProducts = await DatabaseHive.getCartProducts();
      if (localProducts.isNotEmpty) {
        final cart = localProducts
            .map((e) => CartItemModel.fromJson(e.toJson()))
            .toList();
        var response = await apiServices.getCartProducts(cart);

        emit(state.copyWith(
            products: response.data, isLoading: false, error: response.error));
      } else {
        emit(state.copyWith(products: [], isLoading: false, error: null));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
