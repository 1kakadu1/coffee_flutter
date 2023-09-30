class CategoryModel {
  late String id;
  late String name;
  late String name_ua;
  late String name_en;
  late int order;
  late String? preview;
  late String slug;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.name_ua,
      required this.name_en,
      required this.order,
      this.preview,
      required String slug});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    name_en = json["name_en"];
    name_ua = json["name_ua"];
    order = json["order"] ?? 0;
    preview = json["preview"] ?? "";
    slug = json["slug"] ?? "unset";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["name_ua"] = name_ua;
    data["name_en"] = name_en;
    data["order"] = order;
    data["preview"] = preview;
    data["slug"] = slug;
    return data;
  }

  CategoryModel copyWith({
    id,
    name,
    name_ua,
    name_en,
    order,
    preview,
    slug,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      name_en: name_en ?? this.name_en,
      name_ua: name_ua ?? this.name_ua,
      order: order ?? this.order,
      preview: preview ?? this.preview,
      slug: slug ?? this.slug,
    );
  }
}
