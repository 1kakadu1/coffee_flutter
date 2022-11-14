import 'package:coffe_flutter/firebase_options.dart';
import 'package:coffe_flutter/router/router.dart';
import 'package:coffe_flutter/store/category/category_bloc.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final db = FirebaseCreateData();
  // await db.createProductsDB(productsMock);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CategoryBloc>(
        lazy: true,
        create: (context) => CategoryBloc(),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
      ),
    ], child: RoutsAuthContainer());
  }
}
