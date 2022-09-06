import 'dart:developer';

import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/theme/theme_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RoutsAuthContianer extends StatefulWidget {
  RoutsAuthContianer({Key? key}) : super(key: key);

  @override
  _RoutsAuthContianerState createState() => _RoutsAuthContianerState();
}

class _RoutsAuthContianerState extends State<RoutsAuthContianer> {
  User? user;
  @override
  void initState() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in! ${user.email}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _App(false);
  }
}

class _App extends StatelessWidget {
  final bool isAuth;
  _App(this.isAuth);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (themeContext) => MaterialApp(
        initialRoute: PathRoute.home,
        theme: customThemeLight(),
        routes: AppRoutes().getRoutersMap(isAuth),
      ),
    );
  }
}
