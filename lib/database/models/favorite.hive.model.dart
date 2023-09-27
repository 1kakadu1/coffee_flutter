import 'package:hive/hive.dart';
part 'favorite.hive.model.g.dart';

@HiveType(typeId: 1)
class FavoriteHive extends HiveObject {
  FavoriteHive({
    required this.name,
    required this.name_ua,
    required this.name_en,
    required this.preview,
    required this.id,
    this.description,
    this.description_ua,
    this.description_en,
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
  @HiveField(5)
  String? description_ua;
  @HiveField(6)
  String? description_en;
  @HiveField(7)
  String name_ua;
  @HiveField(8)
  String name_en;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["preview"] = preview;
    data["name"] = name;
    data["name_en"] = name_en;
    data["name_ua"] = name_ua;
    data["description"] = description;
    data["description_ua"] = description_ua ?? "";
    data["description_en"] = description_en ?? "";
    data["categorys"] = categorys?.toList() ?? [];
    return data;
  }
}
