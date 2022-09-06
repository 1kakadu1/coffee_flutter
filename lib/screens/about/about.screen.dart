import 'dart:developer';

import 'package:coffe_flutter/widgets/buttons/btn_avatar.dart';
import 'package:coffe_flutter/widgets/fields/input_search.dart';
import 'package:coffe_flutter/widgets/title.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
      body: const AboutScreenContent(),
    );
  }
}

class AboutScreenContent extends StatelessWidget {
  const AboutScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("AboutScreenData");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(
              text: "Find the best coffee for you ",
            ),
            const SizedBox(
              height: 40,
            ),
            InputSearch(),
          ],
        ),
      ),
    );
  }
}
