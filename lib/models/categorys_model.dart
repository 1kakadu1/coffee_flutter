class CategoryModel {
  late String id;
  late String name;
  late int order;
  late String? preview;
  late String slug;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.order,
      this.preview,
      required String slug});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    order = json["order"] ?? 0;
    preview = json["preview"] ?? "";
    slug = json["slug"] ?? "unset";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["order"] = order;
    data["preview"] = preview;
    data["slug"] = slug;
    return data;
  }

  CategoryModel copyWith({
    id,
    name,
    order,
    preview,
    slug,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      preview: preview ?? this.preview,
      slug: slug ?? this.slug,
    );
  }
}
