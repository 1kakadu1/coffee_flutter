import 'package:coffe_flutter/models/favorite.model.dart';
import 'package:coffe_flutter/models/navigation.model.dart';
import 'package:coffe_flutter/router/routes.dart';
import 'package:coffe_flutter/store/favorite/favorite_bloc.dart';
import 'package:coffe_flutter/store/favorite/favorite_event.dart';
import 'package:coffe_flutter/store/favorite/favorite_state.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/cards/favorite_card.dart';
import 'package:coffe_flutter/widgets/cards/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
          buildWhen: (previousState, state) {
        return previousState.products != state.products;
      }, builder: (context, state) {
        return Stack(
          children: [
            _AnimatedListCart(
              items: state.products,
              ctx: context,
            ),
            Positioned.fill(
              child: AnimatedScale(
                scale: state.products.isEmpty ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/favorite_empty.png",
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          color: AppColors.primaryLight,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("У вас нет пока избранного товара")
                      ],
                    )),
              ),
            )
          ],
        );
      }),
    );
  }
}

class _AnimatedListCart extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<FavoriteItemModel> items;
  final int? delay;
  final BuildContext ctx;

  _AnimatedListCart(
      {Key? key, required this.items, this.delay = 1, required this.ctx})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loading =
        BlocProvider.of<FavoriteBloc>(context, listen: true).state.isLoading;
    return AnimatedList(
      key: listKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) =>
          buildItem(items[index], index, animation, context, loading),
    );
  }

  Widget buildItem(FavoriteItemModel item, int index,
          Animation<double> animation, BuildContext context, bool loading) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: loading
            ? const FavoriteCardSkeleton()
            : FavoriteCard(
                product: item,
                onToggle: () {
                  _onToggle(item, context);
                },
                animation: animation,
                onPress: () {
                  _onPress(item, context);
                },
              ),
      );

  void _onToggle(FavoriteItemModel? product, BuildContext context) {
    if (product != null) {
      final FavoriteBloc favoriteBloc =
          BlocProvider.of<FavoriteBloc>(context, listen: false);
      favoriteBloc.add(FavoriteToggleAction(product: product));
    }
  }

  void _onPress(FavoriteItemModel? product, BuildContext context) {
    if (product != null) {
      Navigator.pushNamed(context, PathRoute.product,
          arguments: NavigationArgumentsProduct(product.id, null));
    }
  }

  void insertItem(int index, FavoriteItemModel item) {
    items.insert(index, item);
    listKey.currentState?.insertItem(index);
  }

  void removeItem(int index) {
    final item = items.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) {
        final loading = BlocProvider.of<FavoriteBloc>(context, listen: false)
            .state
            .isLoading;
        return buildItem(item, index, animation, context, loading);
      },
    );
  }
}
