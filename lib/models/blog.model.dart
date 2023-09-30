class BlogModel {
  late String id;
  late String preview;
  late String name;
  late String? description;
  late String name_ua;
  late String? description_ua;
  late String name_en;
  late String? description_en;
  late String link;

  BlogModel({
    required this.id,
    required this.description,
    required this.name,
    required this.description_en,
    required this.name_ua,
    required this.description_ua,
    required this.name_en,
    required this.preview,
    required this.link,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    name_ua = json["name_ua"] ?? "";
    name_en = json["name_en"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    description = json["description"] ?? "";
    description_en = json["description_en"] ?? "";
    description_ua = json["description_ua"] ?? "";
    link = json["link"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["preview"] = preview;
    data["name"] = name;
    data["description"] = description;
    data["name_ua"] = name_ua;
    data["description_en"] = description_en;
    data["name_en"] = name_en;
    data["description_ua"] = description_ua;
    data["link"] = link;
    return data;
  }

  BlogModel copyWith({
    description,
    description_ua,
    description_en,
    name,
    name_en,
    name_ua,
    preview,
    id,
    link,
  }) {
    return BlogModel(
      id: id ?? this.id,
      description: description ?? this.description,
      description_ua: description_ua ?? this.description_ua,
      description_en: description_en ?? this.description_en,
      name_en: name_en ?? this.name_en,
      name_ua: name_ua ?? this.name_ua,
      name: name ?? this.name,
      preview: preview ?? this.preview,
      link: link ?? this.link,
    );
  }
}

// final List<BlogModel> productsMock = [
//   BlogModel(
    
//   )
// ];
