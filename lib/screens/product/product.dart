import 'package:coffe_flutter/widgets/buttons/btn_avatar.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [Text("PRODUCT")],
          ),
        )),
      ),
    );
  }
}
