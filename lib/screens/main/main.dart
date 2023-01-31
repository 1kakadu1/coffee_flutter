import 'package:coffe_flutter/screens/about/about.screen.dart';
import 'package:coffe_flutter/screens/cart/cart.dart';
import 'package:coffe_flutter/screens/home/home.screen.dart';
import 'package:coffe_flutter/store/cart/cart_bloc.dart';
import 'package:coffe_flutter/store/favorite/favorite_bloc.dart';
import 'package:coffe_flutter/store/favorite/favorite_event.dart';
import 'package:coffe_flutter/widgets/app_bar_custom.dart';
import 'package:coffe_flutter/widgets/menu_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../store/cart/cart_event.dart';

const _appBarTitle = [
  null,
  null,
  null,
  "Корзина",
];

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(vsync: this, length: 4);
  late int active;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    active = 0;
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(CartInitProductsAction());
    final FavoriteBloc favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(FavoriteInitProductsAction());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MenuScaffoldBottom(
        onChange: (index) {
          setState(() {
            active = index;
          });
          _tabController.animateTo((index));
        },
      ),
      appBar: AppBarCustom(
        title: _appBarTitle[active],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          HomeScreen(),
          const AboutScreenContent(),
          const Center(
            child: Text("It's sunny here"),
          ),
          CartScreen(),
        ],
      ),
    );
  }
}
