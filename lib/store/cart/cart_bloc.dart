import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coffe_flutter/database/database.dart';
import 'package:coffe_flutter/database/models/cart.hive.model.dart';
import 'package:coffe_flutter/models/cart.model.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:coffe_flutter/store/cart/cart_event.dart';
import 'package:coffe_flutter/store/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(products: const [], isLoading: false)) {
    on<CartClearAction>(_clearCartProduct);
    on<CartAddAction>(_addItem);
    on<CartSubAction>(_subItem);
    on<CartRemoveAction>(_removeItem);
    on<CartChangeCommentsAction>(_changeCommentItem);
    on<CartUpdateProductsAction>(_onUpdateCartProductData);
  }

  _clearCartProduct(CartClearAction event, Emitter<CartState> emit) {
    emit(state.copyWith(products: []));
  }

  _addItem(CartAddAction event, Emitter<CartState> emit) {
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
            category: event.product != null
                ? event.product!.categorys[1]
                : event.cartItem!.category ?? "",
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
              category: value.category,
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
                count: items[item].count + 1,
                price: items[item].price,
                category: items[item].category,
                comments: items[item].comments,
                currentSize: items[item].currentSize),
            size: items[item].currentSize,
            id: items[item].id);
      }
      emit(state.copyWith(products: items));
    }
  }

  _subItem(CartSubAction event, Emitter<CartState> emit) {
    List<CartItemModel> items = [...state.products];
    dynamic product = event.product ?? event.cartItem ?? event.cartItem;
    if (product != null) {
      int item = [...state.products]
          .indexWhere((x) => x.id == product.id && x.currentSize == event.size);

      if (item != -1 && state.products[item].count - 1 > 0) {
        items[item] = items[item].copyWith(count: items[item].count - 1);
      } else if (item != -1 && state.products[item].count - 1 <= 0) {
        items.removeAt(item);
      }
    }

    emit(state.copyWith(products: items));
  }

  _removeItem(CartRemoveAction event, Emitter<CartState> emit) {
    int item = [...state.products].indexWhere(
        (x) => x.id == event.product.id && x.currentSize == event.size);
    List<CartItemModel> items = [...state.products];

    if (item != -1) {
      items.removeAt(item);
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
      emit(state.copyWith(
          products: response.data, isLoading: false, error: response.error));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
