import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListViewTabModel {
  String id;
  String title;

  ListViewTabModel({required this.id, required this.title});
}

abstract class TypeExtends {
  String id;
  String? title;
  String? name;

  TypeExtends({required this.id, this.name, this.title});
}

class ListViewTabs<T> extends StatefulWidget {
  final void Function(int, String) onPress;
  final List<T> items;
  const ListViewTabs({Key? key, required this.onPress, required this.items})
      : super(key: key);

  @override
  State<ListViewTabs> createState() => _ListViewTabsState();
}

class _ListViewTabsState extends State<ListViewTabs> {
  late int activeItem;
  @override
  void initState() {
    activeItem = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ListViewTabModel> tabList = widget.items
        .map(((e) =>
            ListViewTabModel(id: e.id, title: e.name ?? e.title ?? "UNSET")))
        .toList();
    return SizedBox(
      height: 50,
      child: widget.items.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ListViewTabSkeleton(
                    height: 30,
                  ),
                  ListViewTabSkeleton(
                    height: 30,
                  ),
                  ListViewTabSkeleton(
                    height: 30,
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: widget.items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ListViewTab(
                  item: tabList[index],
                  onPress: (String id) {
                    widget.onPress(index, id);
                    setState(() {
                      activeItem = index;
                    });
                  },
                  active: index == activeItem,
                );
              }),
    );
  }
}

class ListViewTab extends StatelessWidget {
  final ListViewTabModel item;
  final bool active;
  final double? height;
  final void Function(String) onPress;
  const ListViewTab(
      {Key? key,
      required this.item,
      required this.active,
      required this.onPress,
      this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress(item.id);
      },
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Center(
          child: Column(
            children: [
              AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 100),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: active ? AppColors.primary : AppColors.write,
                  ),
                  child: Text(item.title, overflow: TextOverflow.ellipsis)),
              const SizedBox(
                height: 4,
              ),
              AnimatedOpacity(
                opacity: active ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: 6,
                  height: 6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListViewTabSkeleton extends StatelessWidget {
  final double? height;

  const ListViewTabSkeleton({super.key, this.height = 50});
  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      themeMode: ThemeMode.light,
      shimmerGradient: AppColors.skeletonGradient,
      child: SkeletonAvatar(
        style: SkeletonAvatarStyle(
          width: 100,
          height: height,
        ),
      ),
    );
  }
}

final List<ListViewTabModel> listViewMock = [
  ListViewTabModel(id: "id-all", title: "Все"),
  ListViewTabModel(id: "id-coffee", title: "Кофе"),
  ListViewTabModel(id: "id-tea", title: "Чай"),
];
