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
    required this.category,
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
  String? category;
  @HiveField(6)
  String? comments;
  @HiveField(7)
  String currentSize;
}
