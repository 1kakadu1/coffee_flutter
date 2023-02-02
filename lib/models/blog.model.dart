class BlogModel {
  late String id;
  late String preview;
  late String name;
  late String? description;
  late String link;

  BlogModel({
    required this.id,
    required this.description,
    required this.name,
    required this.preview,
    required this.link,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    description = json["description"] ?? "";
    link = json["link"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["preview"] = preview;
    data["name"] = name;
    data["description"] = description;
    data["link"] = link;
    return data;
  }

  BlogModel copyWith({
    description,
    name,
    preview,
    id,
    link,
  }) {
    return BlogModel(
      id: id ?? this.id,
      description: description ?? this.description,
      name: name ?? this.name,
      preview: preview ?? this.preview,
      link: link ?? this.link,
    );
  }
}
