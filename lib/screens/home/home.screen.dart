import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/store/blog/blog_bloc.dart';
import 'package:coffe_flutter/store/blog/blog_state.dart';
import 'package:coffe_flutter/store/home/home_bloc.dart';
import 'package:coffe_flutter/store/home/home_event.dart';
import 'package:coffe_flutter/store/home/home_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/cards/special_card.dart';
import 'package:coffe_flutter/widgets/fields/input_search.dart';
import 'package:coffe_flutter/widgets/list_view_products.dart';
import 'package:coffe_flutter/widgets/list_view_tabs.dart';
import 'package:coffe_flutter/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final homeScreenKey = GlobalKey();

  @override
  void initState() {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeEventInit());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomeScreenContent(
      key: homeScreenKey,
      blocHome: null,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeScreenContent extends StatelessWidget {
  final HomeBloc? blocHome;
  const HomeScreenContent({Key? key, this.blocHome}) : super(key: key);
  static const platform = MethodChannel('com.example.coffe_flutter/payment');
  @override
  Widget build(BuildContext context) {
    final lang = Intl.getCurrentLocale();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              text: S.of(context).home_search_title,
            ),
            const SizedBox(
              height: 40,
            ),
            InputSearch(),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(
                  width: 200,
                  text: S.of(context).yourDrinks,
                  fontSize: 18,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PathRoute.products);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        S.of(context).seeAll,
                        style: const TextStyle(color: AppColors.write),
                      ),
                    ),
                  ),
                )
              ],
            ),
            BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) => ListViewTabs<dynamic>(
                      items: state.categorys,
                      onPress: (int index, String id) {
                        final HomeBloc homeBloc =
                            BlocProvider.of<HomeBloc>(context, listen: false);
                        homeBloc.add(HomeEventChangeCategory(id));
                      },
                    )),
            ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300, minWidth: 10),
                child: BlocBuilder<HomeBloc, HomeState>(
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
            TitleWidget(
              text: S.of(context).home_special_products,
              fontSize: 18,
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300, minWidth: 10),
                child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previousState, state) {
                      return previousState.special != state.special;
                    },
                    builder: (context, state) => ListViewProducts(
                        onPress: () {}, items: state.special))),
            const SizedBox(
              height: 20,
            ),
            TitleWidget(
              text: S.of(context).home_news_title,
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
                    ? Text(S.of(context).loading)
                    : ListView.builder(
                        itemCount: state.posts.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final itemJson = state.posts[index].toJson();
                          final title = lang == "ru"
                              ? itemJson["name"]
                              : lang == "ua" || lang == "uk"
                                  ? itemJson["name_ua"]
                                  : itemJson["name_$lang"];
                          final description = lang == "ru"
                              ? itemJson["description"]
                              : lang == "ua" || lang == "uk"
                                  ? itemJson["description_ua"]
                                  : itemJson["description_$lang"];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SpecialCard(
                              orientation: index == 0
                                  ? SpecialCardOrientation.vertical
                                  : SpecialCardOrientation.horizontal,
                              title: title,
                              description: description ?? "",
                              preview: state.posts[index].preview,
                              onPress: (dynamic value) {
                                _launchURL(state.posts[index].link, context);
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

  _launchURL(String link, BuildContext context) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw '${S.of(context).couldNotLaunch} $link';
    }
  }
}
