import 'package:coffe_flutter/screens/about/about.screen.dart';
import 'package:coffe_flutter/screens/cart/cart.dart';
import 'package:coffe_flutter/screens/favorite/favorite.dart';
import 'package:coffe_flutter/screens/login/login.screen.dart';
import 'package:coffe_flutter/screens/main/main.dart';
import 'package:coffe_flutter/screens/order/order.dart';
import 'package:coffe_flutter/screens/product/product.dart';
import 'package:coffe_flutter/screens/products/products.screen.dart';
import 'package:coffe_flutter/screens/profile/profile_screen.dart';
import 'package:coffe_flutter/screens/registration/registration.screen.dart';
import 'package:flutter/material.dart';

class PathRoute {
  static const String home = "/home";
  static const String product = "/product";
  static const String products = "/products";
  static const String order = "/order";
  static const String cart = "/cart";
  static const String login = "/login";
  static const String registration = "/registration";
  static const String profile = "/profile";
  static const String about = "/about";
  static const String favorite = '/favorite';
}

class RouteItem {
  final IconData icon;
  final Widget Function(BuildContext) route;
  final String routePath;
  final bool isPrivate;
  final String titleKey;
  final bool? isMenu;

  RouteItem(
      {required this.icon,
      required this.route,
      required this.routePath,
      required this.isPrivate,
      required this.titleKey,
      this.isMenu});
}

class AppRoutes {
  final List<RouteItem> _listRoutes = [
    RouteItem(
        titleKey: "menu.home",
        isMenu: true,
        icon: Icons.home,
        isPrivate: false,
        routePath: PathRoute.home,
        route: (context) => MainPage()),
    RouteItem(
        titleKey: "about",
        isMenu: true,
        icon: Icons.home,
        isPrivate: false,
        routePath: PathRoute.about,
        route: (context) => AboutScreen()),
    RouteItem(
        titleKey: "login",
        isMenu: false,
        icon: Icons.home,
        isPrivate: false,
        routePath: PathRoute.login,
        route: (context) => LoginScreen()),
    RouteItem(
        titleKey: "registartion",
        isMenu: false,
        icon: Icons.home,
        isPrivate: false,
        routePath: PathRoute.registration,
        route: (context) => RegistrationScreen()),
    RouteItem(
      titleKey: "product",
      isMenu: false,
      icon: Icons.production_quantity_limits,
      isPrivate: false,
      routePath: PathRoute.product,
      route: (context) => const ProductScreen(),
    ),
    RouteItem(
      titleKey: "products",
      isMenu: false,
      icon: Icons.production_quantity_limits,
      isPrivate: false,
      routePath: PathRoute.products,
      route: (context) => const ProductsScreen(),
    ),
    RouteItem(
      titleKey: "cart",
      isMenu: true,
      icon: Icons.production_quantity_limits,
      isPrivate: false,
      routePath: PathRoute.cart,
      route: (context) => CartScreen(),
    ),
    RouteItem(
      titleKey: "favorite",
      isMenu: true,
      icon: Icons.production_quantity_limits,
      isPrivate: false,
      routePath: PathRoute.favorite,
      route: (context) => const FavoriteScreen(),
    ),
    RouteItem(
      titleKey: "order",
      isMenu: false,
      icon: Icons.production_quantity_limits,
      isPrivate: false,
      routePath: PathRoute.order,
      route: (context) => const OrderScreen(),
    ),
    RouteItem(
      titleKey: "profile",
      isMenu: false,
      icon: Icons.production_quantity_limits,
      isPrivate: true,
      routePath: PathRoute.profile,
      route: (context) => const ProfileScreen(),
    ),
  ];

  List<RouteItem> getRouterList(bool isAuth) {
    List<RouteItem> routes = [];
    for (var element in this._listRoutes) {
      if (isAuth == true && element.isPrivate == true) {
        routes.add(element);
      }
      if (element.isPrivate != true && element.isMenu == true) {
        routes.add(element);
      }
    }

    return routes;
  }

  Map<String, Widget Function(BuildContext)> getRoutersMap(bool isAuth) {
    Map<String, Widget Function(BuildContext)> routes = {};
    for (var element in this._listRoutes) {
      if (isAuth == true && element.isPrivate == true) {
        routes[element.routePath] = element.route;
      }

      if (element.isPrivate != true) {
        routes[element.routePath] = element.route;
      }
    }

    return routes;
  }
}
