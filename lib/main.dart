import 'package:coffe_flutter/database/database.dart';
import 'package:coffe_flutter/firebase_options.dart';
import 'package:coffe_flutter/router/router.dart';
import 'package:coffe_flutter/services/firebase_messaging_service_provider.dart';
import 'package:coffe_flutter/services/locator.dart';
import 'package:coffe_flutter/services/notification_service.dart';
import 'package:coffe_flutter/store/blog/blog_bloc.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/category/category_bloc.dart';
import 'package:coffe_flutter/store/favorite/favorite_bloc.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:coffe_flutter/store/products/products_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  await firebaseMessagingService.checkForInitialMessage(initialMessage);
  await notificationService.setup();
  await DatabaseHive.initDB();
  setupLocator();
  //await DatabaseHive.clearBoxes();
  // final db = FirebaseCreateData();
  // await db.createProductsDB(productsMock);
  //final db = FirebaseCreateSearchData();
  //db.createSearchDataDB(productsMock, "search_name");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<FavoriteBloc>(
        lazy: true,
        create: (context) => locator.get<FavoriteBloc>(),
      ),
      BlocProvider<HomeBloc>(
        create: (context) {
          return locator.get<HomeBloc>();
        },
      ),
      BlocProvider<CategoryBloc>(
        lazy: false,
        create: (context) {
          /* 
            TODO: Так можно прокинуть что-то в блок. Например, блок home, в блок с категориями 
            Можно использовать get_it для прямого изменения. Сейчас так и работает.
            
            final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
            return CategoryBloc(homeBloc);
          */
          return CategoryBloc();
        },
      ),
      BlocProvider<CartBloc>(
        create: (context) => locator.get<CartBloc>(),
        lazy: true,
      ),
      BlocProvider<BlogBloc>(
        create: (context) => BlogBloc(),
      ),
      BlocProvider<ProductsBloc>(
        create: (context) => ProductsBloc(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => locator.get<ProfileBloc>(),
        lazy: true,
      ),
    ], child: RoutsAuthContainer());
  }
}
