import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/models/navigation.model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InputSearch extends StatefulWidget {
  InputSearch({Key? key}) : super(key: key);

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(),
          hintText: S.of(context).hintSearch),
      onSubmitted: (String value) async {
        showMaterialModalBottomSheet(
            isDismissible: true,
            enableDrag: false,
            context: context,
            builder: (context) => Container(
                  height: 400,
                  color: AppColors.backgroundLight,
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: (_controller.text == "")
                          ? FirebaseFirestore.instance
                              .collection('products')
                              .limit(20)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection('products')
                              .limit(20)
                              .where("search_name",
                                  arrayContains: _controller.text)
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text("Error"));
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          default:
                            return SizedBox(
                              height: 400,
                              child: snapshot.data!.docs.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            "${S.of(context).searchFind} ${snapshot.data!.docs.length}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children: snapshot.data!.docs.map((
                                              DocumentSnapshot doc,
                                            ) {
                                              Map<String, dynamic> data =
                                                  doc.data()!
                                                      as Map<String, dynamic>;
                                              return SizedBox(
                                                child: ListTile(
                                                  onTap: () {
                                                    ProductModel product =
                                                        ProductModel.fromJson(
                                                            data);
                                                    Navigator.pushNamed(context,
                                                        PathRoute.product,
                                                        arguments:
                                                            NavigationArgumentsProduct(
                                                                product.id,
                                                                product));
                                                  },
                                                  title: Text(data["name"]),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Text(
                                          S.of(context).searchTitle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                            );
                        }
                      },
                    ),
                  ),
                ));
      },
    );
  }
}
