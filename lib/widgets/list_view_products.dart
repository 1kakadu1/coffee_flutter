import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';

class ListViewProducts extends StatefulWidget {
  final void Function() onPress;
  final List<ProductModel> items;
  ListViewProducts({Key? key, required this.onPress, required this.items})
      : super(key: key);

  @override
  State<ListViewProducts> createState() => _ListViewProductsState();
}

class _ListViewProductsState extends State<ListViewProducts> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return SizedBox(
      height: 300,
      child: ListView.separated(
          itemCount: widget.items.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProductCard(
              product: widget.items[index],
              width: (queryData.size.width / 2) - 30,
            );
          }),
    );
  }
}
