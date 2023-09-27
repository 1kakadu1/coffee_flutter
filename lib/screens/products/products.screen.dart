import 'dart:async';

import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/models/categorys_model.dart';
import 'package:coffe_flutter/models/navigation.model.dart';
import 'package:coffe_flutter/models/product.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/store/category/category_bloc.dart';
import 'package:coffe_flutter/store/products/products_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_bloc.dart';
import 'package:coffe_flutter/store/profile/profile_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/buttons/btn_avatar.dart';
import 'package:coffe_flutter/widgets/cards/product_card.dart';
import 'package:coffe_flutter/widgets/list_view_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    final CategoryBloc categoryBloc =
        BlocProvider.of<CategoryBloc>(context, listen: false);
    final ProductsBloc productsBloc =
        BlocProvider.of<ProductsBloc>(context, listen: false);
    if (categoryBloc.state.categorys.isEmpty) {
      categoryBloc.add(CategoryEventGet());
    }
    if (productsBloc.state.products.isEmpty &&
        productsBloc.state.isLoading == false) {
      productsBloc.add(ProductsEventGetCategory());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(S.of(context).screenProducts),
                  ),
                  actions: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                        buildWhen: (previousState, state) {
                          return previousState.isAuth != state.isAuth ||
                              state.user?.preview !=
                                  previousState.user?.preview;
                        },
                        builder: (context, state) => ButtonAvatar(
                              img: state.isAuth &&
                                      state.user?.preview != null &&
                                      state.user?.preview != ""
                                  ? state.user!.preview!
                                  : "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/users%2Fno-avatar-25359d55aa3c93ab3466622fd2ce712d1.jpg?alt=media&token=55ad603a-222f-4cb9-844c-11e2b9c41d51&_gl=1*1se3xc1*_ga*OTY2NjYwNjYwLjE2NjI1NzYwMzA.*_ga_CW55HF8NVT*MTY4NjU4NzgwMC4xMi4xLjE2ODY1ODc4NzUuMC4wLjA.",
                              radius: 10,
                              width: 44,
                              assets: false,
                              onPress: () {
                                if (state.isAuth == false) {
                                  Navigator.pushNamed(
                                    context,
                                    PathRoute.login,
                                  );
                                }
                              },
                            )),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                  backgroundColor: AppColors.blackLight,
                  pinned: true,
                  floating: true,
                  expandedHeight: 100.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.only(
                          top: statusBarHeight + 60,
                          left: 8,
                          right: 8,
                          bottom: 5),
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                        final ProductsBloc productsBloc =
                            BlocProvider.of<ProductsBloc>(context,
                                listen: false);
                        return ListViewTabs<CategoryModel>(
                          activeIndex: state.categorys.indexWhere((element) =>
                              element.id == productsBloc.state.catID),
                          items: state.categorys,
                          onPress: (int index, String id) {
                            productsBloc.add(ProductsEventChangeCategory(id));
                          },
                        );
                      }),
                    ),
                  ),
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) => SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: state.isLoading
                              ? ProductCardSkeleton(
                                  width: (queryData.size.width / 2) - 46,
                                )
                              : ProductCard(
                                  onPress: (String id, ProductModel product) {
                                    Navigator.pushNamed(
                                        context, PathRoute.product,
                                        arguments: NavigationArgumentsProduct(
                                            id, product));
                                  },
                                  product: state.products[index],
                                ),
                        );
                      },
                      childCount: state.isLoading ? 6 : state.products.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 320,
                            crossAxisCount: 2,
                            childAspectRatio: 1.0),
                  ),
                ),
              ],
            )));
  }

  Future<void> _pullRefresh() async {
    final Completer completer = Completer();
    final ProductsBloc productsBloc =
        BlocProvider.of<ProductsBloc>(context, listen: false);
    productsBloc.add(ProductsEventRefresh(completer));
    return completer.future;
  }
}
