import 'package:coffe_flutter/screens/about/about.screen.dart';
import 'package:coffe_flutter/screens/login/login.screen.dart';
import 'package:coffe_flutter/screens/main/main.dart';
import 'package:flutter/material.dart';

class PathRoute {
  static const String home = "/home";
  static const String product = "/product";
  static const String products = "/products";
  static const String order = "/order";
  static const String cart = "/cart";
  static const String login = "/login";
  static const String profile = "/profile";
  static const String about = "/about";
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
        isMenu: true,
        icon: Icons.home,
        isPrivate: false,
        routePath: PathRoute.login,
        route: (context) => LoginScreen()),
  ];

  List<RouteItem> getRouterList(bool isAuth) {
    List<RouteItem> routes = [];
    this._listRoutes.forEach((element) {
      if (isAuth == true && element.isPrivate == true) {
        routes.add(element);
      }
      if (element.isPrivate != true && element.isMenu == true) {
        routes.add(element);
      }
    });

    return routes;
  }

  Map<String, Widget Function(BuildContext)> getRoutersMap(bool isAuth) {
    Map<String, Widget Function(BuildContext)> routes = {};
    this._listRoutes.forEach((element) {
      if (isAuth == true && element.isPrivate == true) {
        routes[element.routePath] = element.route;
      }

      if (element.isPrivate != true) {
        routes[element.routePath] = element.route;
      }
    });

    return routes;
  }
}
