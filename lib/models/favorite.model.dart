class FavoriteItemModel {
  late String name;
  late String? preview;
  late String id;
  late List<String>? categorys;
  late String? description;

  FavoriteItemModel({
    required this.name,
    required this.preview,
    required this.id,
    this.description,
    this.categorys,
  });

  FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    categorys = json["categorys"] ?? [];
    description = json['description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["description"] = description ?? "";
    data["preview"] = preview;
    data["name"] = name;
    return data;
  }

  FavoriteItemModel copyWith({
    name,
    preview,
    id,
    description,
    categorys,
  }) {
    return FavoriteItemModel(
      name: name ?? this.name,
      preview: preview ?? this.preview,
      id: id ?? this.id,
      description: description ?? this.description,
      categorys: categorys ?? this.categorys,
    );
  }
}
