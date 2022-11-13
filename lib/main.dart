import 'package:coffe_flutter/firebase_options.dart';
import 'package:coffe_flutter/router/router.dart';
import 'package:coffe_flutter/services/api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final db = FirebaseCreateData();
  // await db.createProductsDB(productsMock);
  final a = await apiServices.getHome();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoutsAuthContainer();
  }
}
