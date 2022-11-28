import 'dart:developer';

import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/screens/login/login.screen.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:coffe_flutter/store/home/home_event.dart';
import 'package:coffe_flutter/store/home/home_state.dart';
import 'package:coffe_flutter/widgets/cards/special_card.dart';
import 'package:coffe_flutter/widgets/fields/input_search.dart';
import 'package:coffe_flutter/widgets/list_view_products.dart';
import 'package:coffe_flutter/widgets/list_view_tabs.dart';
import 'package:coffe_flutter/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final homeScreenKey = GlobalKey();
  late HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeEventInit());
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenContent(
      key: homeScreenKey,
      blocHome: homeBloc,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeScreenContent extends StatelessWidget {
  final HomeBloc blocHome;
  const HomeScreenContent({Key? key, required this.blocHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(
              text: "Найдите лучший кофе для себя ",
            ),
            const SizedBox(
              height: 40,
            ),
            InputSearch(),
            const SizedBox(
              height: 40,
            ),
            BlocBuilder<HomeBloc, HomeState>(
                bloc: blocHome,
                builder: (context, state) => ListViewTabs<dynamic>(
                      items: state.categorys,
                      onPress: (int index, String id) {
                        blocHome.add(HomeEventChangeCategory(id));
                      },
                    )),
            ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: BlocBuilder<HomeBloc, HomeState>(
                    bloc: blocHome,
                    buildWhen: (previousState, state) {
                      return previousState.tabsProduct != state.tabsProduct;
                    },
                    builder: (context, state) => ListViewProducts(
                        onPress: () {}, items: state.tabsProduct))),
            const SizedBox(
              height: 40,
            ),
            const TitleWidget(
              text: "Специальные продукты",
              fontSize: 18,
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: BlocBuilder<HomeBloc, HomeState>(
                    bloc: blocHome,
                    buildWhen: (previousState, state) {
                      return previousState.special != state.special;
                    },
                    builder: (context, state) => ListViewProducts(
                        onPress: () {}, items: state.special))),
            const SizedBox(
              height: 20,
            ),
            const TitleWidget(
              text: "Последние посты",
              fontSize: 18,
            ),
            const SizedBox(
              height: 20,
            ),
            SpecialCard(
              title: productsMock[0].name,
              description: productsMock[0].description,
              preview: productsMock[0].preview,
              onPress: (dynamic value) {},
            ),
            const SizedBox(
              height: 20,
            ),
            SpecialCard(
              title: productsMock[1].name,
              description: productsMock[1].description,
              preview: productsMock[1].preview,
              orientation: SpecialCardOrientation.horizontal,
              onPress: (dynamic value) {
                pushNewScreen(
                  context,
                  screen: LoginScreen(),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SpecialCard(
              horizontalWidgetReverse: true,
              title: productsMock[2].name,
              description: productsMock[2].description,
              preview: productsMock[2].preview,
              orientation: SpecialCardOrientation.horizontal,
              onPress: (dynamic value) {},
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
