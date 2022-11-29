import 'package:coffe_flutter/screens/about/about.screen.dart';
import 'package:coffe_flutter/screens/cart/cart.dart';
import 'package:coffe_flutter/screens/home/home.screen.dart';
import 'package:coffe_flutter/widgets/app_bar_custom.dart';
import 'package:coffe_flutter/widgets/menu_bottom.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(vsync: this, length: 4);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
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
          _tabController.animateTo((index));
        },
      ),
      appBar: const AppBarCustom(),
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
