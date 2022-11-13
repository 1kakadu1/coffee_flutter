import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter/material.dart';

class ListViewTabModel {
  String id;
  String title;

  ListViewTabModel({required this.id, required this.title});
}

class ListViewTabs extends StatefulWidget {
  final void Function(int, String) onPress;
  final List<ListViewTabModel> items;
  ListViewTabs({Key? key, required this.onPress, required this.items})
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
    return Container(
      height: 50,
      child: ListView.builder(
          itemCount: widget.items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ListViewTab(
              item: widget.items[index],
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
  final void Function(String) onPress;
  const ListViewTab(
      {Key? key,
      required this.item,
      required this.active,
      required this.onPress})
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

final List<ListViewTabModel> listViewMock = [
  ListViewTabModel(id: "id-all", title: "Все"),
  ListViewTabModel(id: "id-coffee", title: "Кофе"),
  ListViewTabModel(id: "id-tea", title: "Чай"),
];
