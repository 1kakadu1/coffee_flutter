import 'package:coffe_flutter/database/database.dart';
import 'package:coffe_flutter/firebase_options.dart';
import 'package:coffe_flutter/router/router.dart';
import 'package:coffe_flutter/services/firebase_messaging_service_provider.dart';
import 'package:coffe_flutter/store/blog/blog_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/category/category_bloc.dart';
import 'package:coffe_flutter/store/favorite/favorite_bloc.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  await firebaseMessagingService.checkForInitialMessage(initialMessage);
  await DatabaseHive.initDB();
  //await DatabaseHive.clearBoxes();
  // final db = FirebaseCreateData();
  // await db.createProductsDB(productsMock);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<FavoriteBloc>(
        lazy: true,
        create: (context) => FavoriteBloc(),
      ),
      BlocProvider<CategoryBloc>(
        lazy: true,
        create: (context) => CategoryBloc(),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
      BlocProvider<BlogBloc>(
        create: (context) => BlogBloc(),
      ),
    ], child: RoutsAuthContainer());
  }
}
