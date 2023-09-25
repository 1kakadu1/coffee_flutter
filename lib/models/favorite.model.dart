class FavoriteItemModel {
  late String name;
  late String name_en;
  late String name_ua;
  late String? preview;
  late String id;
  late List<String>? categorys;
  late String? description;
  late String? description_ua;
  late String? description_en;

  FavoriteItemModel({
    required this.name,
    required this.preview,
    required this.name_ua,
    required this.name_en,
    required this.id,
    this.description,
    this.categorys,
    required description_en,
    required description_ua,
  });

  FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    name = json["name_en"] ?? "";
    name = json["name_ua"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    categorys = json["categorys"] ?? [];
    description = json['description'] ?? "";
    description_en = json['description_en'] ?? "";
    description_ua = json['description_ua'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["description"] = description ?? "";
    data["description_ua"] = description_ua ?? "";
    data["description_en"] = description_en ?? "";
    data["preview"] = preview;
    data["name"] = name;
    data["name_ua"] = name_ua;
    data["name_en"] = name_en;
    return data;
  }

  FavoriteItemModel copyWith({
    name,
    name_ua,
    name_en,
    preview,
    id,
    description,
    description_en,
    description_ua,
    categorys,
  }) {
    return FavoriteItemModel(
      name: name ?? this.name,
      name_en: name_en ?? this.name_en,
      name_ua: name_ua ?? this.name_ua,
      preview: preview ?? this.preview,
      id: id ?? this.id,
      description: description ?? this.description,
      description_en: description_en ?? this.description_en,
      description_ua: description_ua ?? this.description_ua,
      categorys: categorys ?? this.categorys,
    );
  }
}
