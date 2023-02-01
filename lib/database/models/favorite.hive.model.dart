import 'package:hive/hive.dart';
part 'favorite.hive.model.g.dart';

@HiveType(typeId: 1)
class FavoriteHive extends HiveObject {
  FavoriteHive({
    required this.name,
    required this.preview,
    required this.id,
    this.description,
    required this.categorys,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  String? preview;
  @HiveField(2)
  String id;
  @HiveField(3)
  List<String>? categorys;
  @HiveField(4)
  String? description;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["preview"] = preview;
    data["name"] = name;
    data["description"] = description;
    data["categorys"] = categorys?.toList() ?? [];
    return data;
  }
}
