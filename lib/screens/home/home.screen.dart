import 'dart:developer';

import 'package:coffe_flutter/store/blog/blog_bloc.dart';
import 'package:coffe_flutter/store/blog/blog_state.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:coffe_flutter/store/home/home_event.dart';
import 'package:coffe_flutter/store/home/home_state.dart';
import 'package:coffe_flutter/widgets/cards/special_card.dart';
import 'package:coffe_flutter/widgets/fields/input_search.dart';
import 'package:coffe_flutter/widgets/list_view_products.dart';
import 'package:coffe_flutter/widgets/list_view_tabs.dart';
import 'package:coffe_flutter/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
  static const platform = MethodChannel('com.example.coffe_flutter/payment');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(
              text: "Найдите напиток для себя ",
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
                constraints: const BoxConstraints(maxHeight: 300, minWidth: 10),
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
            //TODO: shoew test native module activity. Type: 'payment_bottom_sheet' or 'payment'
            // ElevatedButton(
            //     onPressed: () async {
            //       var result = await platform.invokeMethod<String>(
            //           'payment_bottom_sheet',
            //           <String, dynamic>{'price': 2000.0});
            //       log("RESULT NATIVE MODULE $result");
            //     },
            //     child: Text("оплата")),
            const TitleWidget(
              text: "Специальные продукты",
              fontSize: 18,
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300, minWidth: 10),
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
              text: "Последние новости",
              fontSize: 18,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<BlogBloc, BlogState>(
              buildWhen: (previousState, state) {
                return previousState.posts.length != state.posts.length;
              },
              builder: (context, state) {
                return state.isLoading
                    ? const Text("loading...")
                    : ListView.builder(
                        itemCount: state.posts.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SpecialCard(
                              orientation: index == 0
                                  ? SpecialCardOrientation.vertical
                                  : SpecialCardOrientation.horizontal,
                              title: state.posts[index].name,
                              description: state.posts[index].description ?? "",
                              preview: state.posts[index].preview,
                              onPress: (dynamic value) {
                                _launchURL(state.posts[index].link);
                              },
                              horizontalWidgetReverse: index % 2 == 0,
                            ),
                          );
                        });
              },
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String link) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $link';
    }
  }
}
