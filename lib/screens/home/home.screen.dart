import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/screens/login/login.screen.dart';
import 'package:coffe_flutter/widgets/buttons/btn_avatar.dart';
import 'package:coffe_flutter/widgets/cards/special_card.dart';
import 'package:coffe_flutter/widgets/fields/input_search.dart';
import 'package:coffe_flutter/widgets/list_view_products.dart';
import 'package:coffe_flutter/widgets/list_view_tabs.dart';
import 'package:coffe_flutter/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          ButtonAvatar(
            img: "https://www.ixbt.com/img/n1/news/2022/5/6/vk_large.jpg",
            radius: 10,
            width: 44,
            onPress: () {},
          )
        ],
      ),
      body: HomeScreenContent(key: homeScreenKey),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

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
            ListViewTabs(
              items: listViewMock,
              onPress: (int index, String id) {},
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListViewProducts(onPress: () {}, items: productsMock)),
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
