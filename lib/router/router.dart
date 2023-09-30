import 'dart:developer';

import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/services/firebase_messaging_service_provider.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_event.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/theme/theme_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RoutsAuthContainer extends StatefulWidget {
  const RoutsAuthContainer({Key? key}) : super(key: key);

  @override
  _RoutsAuthContainerState createState() => _RoutsAuthContainerState();
}

class _RoutsAuthContainerState extends State<RoutsAuthContainer> {
  User? user;
  @override
  void initState() {
    final ProfileBloc profile =
        BlocProvider.of<ProfileBloc>(context, listen: false);
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        final tokenPush =
            await firebaseMessagingService.registerNotification(user.uid);

        log("SET USER PUSH TOKEN: id 1 = $tokenPush");
        log('User is signed in! ${user.email}');
        profile.add(ProfileGetAction(user.uid));
        //apiServices.signOut();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previousState, state) {
          log("auth ${state.isAuth}");
          return previousState.isAuth != state.isAuth;
        },
        builder: (context, state) => _App(state.isAuth));
  }
}

class _App extends StatelessWidget {
  final bool isAuth;
  const _App(this.isAuth);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (themeContext) => MaterialApp(
        initialRoute: PathRoute.home,
        theme: customThemeLight(),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale("uk"),
        routes: AppRoutes().getRoutersMap(isAuth),
      ),
    );
  }
}
