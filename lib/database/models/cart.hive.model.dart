import 'package:hive/hive.dart';
part 'cart.hive.model.g.dart';

@HiveType(typeId: 0)
class CartHive extends HiveObject {
  CartHive({
    required this.name,
    required this.preview,
    required this.id,
    required this.count,
    required this.price,
    required this.categorys,
    required this.comments,
    required this.currentSize,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  String? preview;
  @HiveField(2)
  String id;
  @HiveField(3)
  int count;
  @HiveField(4)
  dynamic price;
  @HiveField(5)
  List<String>? categorys;
  @HiveField(6)
  String? comments;
  @HiveField(7)
  String currentSize;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["count"] = count;
    data["price"] = price;
    data["preview"] = preview;
    data["name"] = name;
    data["currentSize"] = currentSize;
    data["categorys"] = categorys?.toList() ?? [];
    data["comments"] = comments ?? "";
    return data;
  }
}
