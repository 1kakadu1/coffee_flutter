class ProductModel {
  late String id;
  late String preview;
  late String name;
  late String code;
  late String description;
  late double rating;
  late List<String> composition;
  late List<Map<String, dynamic>> energy_and_nutritional_value;
  late List<String> gallary;
  late bool isPublic;
  late String measurement_value;
  late Map<String, double> price;
  late List<String> size;
  late List<String> categorys;

  ProductModel(
      {required this.code,
      required this.id,
      required this.description,
      required this.name,
      required this.preview,
      required this.price,
      required this.rating,
      required this.composition,
      required this.energy_and_nutritional_value,
      required this.gallary,
      required this.isPublic,
      required this.measurement_value,
      required this.size,
      required categorys});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    code = json["code"] ?? 0;
    price = json["price"] ?? {"0": 0};
    description = json["description"] ?? "";
    rating = json["rating"] ?? 0;
    size = json["size"] ?? ["0"];
    measurement_value = json["measurement_value"] ?? "unset";
    gallary = json["gallary"] ?? [];
    energy_and_nutritional_value = json["energy_and_nutritional_value"] ?? [];
    isPublic = json["isPublic"] ?? true;
    composition = json["composition"] ?? [];
    categorys = json["categorys"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["code"] = code;
    data["price"] = price;
    data["rating"] = rating;
    data["preview"] = preview;
    data["name"] = name;
    data["description"] = description;
    data["composition"] = composition;
    data["isPublic"] = isPublic;
    data["energy_and_nutritional_value"] = energy_and_nutritional_value;
    data["gallary"] = gallary;
    data["measurement_value"] = measurement_value;
    data["size"] = size;
    data["categorys"] = categorys;
    return data;
  }

  ProductModel copyWith({
    code,
    description,
    name,
    preview,
    price,
    rating,
    id,
    composition,
    size,
    energy_and_nutritional_value,
    gallary,
    isPublic,
    measurement_value,
    categorys,
  }) {
    return ProductModel(
        id: id ?? this.id,
        code: code ?? this.code,
        description: description ?? this.description,
        name: name ?? this.name,
        preview: preview ?? this.preview,
        price: price ?? this.price,
        rating: rating ?? this.rating,
        composition: composition ?? this.composition,
        size: size ?? this.size,
        energy_and_nutritional_value:
            energy_and_nutritional_value ?? this.energy_and_nutritional_value,
        gallary: gallary ?? this.gallary,
        isPublic: isPublic ?? this.isPublic,
        measurement_value: measurement_value ?? this.measurement_value,
        categorys: categorys ?? this.categorys);
  }
}

final List<ProductModel> productsMock = [
  ProductModel(
      id: "1",
      name: "Cappuccino",
      description: "loprem lorem lorem",
      preview:
          "https://www.ornelio.ru/upload/iblock/c60/c60aeac97d6f41f7292b764c40016c7e.jpg",
      rating: 4.2,
      code: "134445",
      price: {"350": 55.4},
      isPublic: true,
      gallary: [],
      composition: [],
      measurement_value: "мл",
      energy_and_nutritional_value: [],
      size: ["350"],
      categorys: []),
  ProductModel(
      id: "2",
      name: "Cappuccino milk top",
      description: "loprem lorem lorem",
      preview:
          "https://st2.depositphotos.com/5355656/7813/i/450/depositphotos_78138608-stock-photo-a-cup-of-cappuccino.jpg",
      rating: 5.0,
      code: "134442",
      price: {"350": 55.4},
      isPublic: true,
      gallary: [],
      composition: [],
      measurement_value: "мл",
      energy_and_nutritional_value: [],
      size: ["350"],
      categorys: []),
  ProductModel(
      id: "1",
      name: "Cappuccino",
      description: "loprem lorem lorem",
      preview:
          "https://www.ornelio.ru/upload/iblock/c60/c60aeac97d6f41f7292b764c40016c7e.jpg",
      price: {"350": 55.4},
      isPublic: true,
      gallary: [],
      composition: [],
      measurement_value: "мл",
      energy_and_nutritional_value: [],
      size: ["350"],
      rating: 4.2,
      code: "134445",
      categorys: []),
  ProductModel(
    id: "2",
    name: "Cappuccino milk top",
    description: "loprem lorem lorem",
    preview:
        "https://st2.depositphotos.com/5355656/7813/i/450/depositphotos_78138608-stock-photo-a-cup-of-cappuccino.jpg",
    price: {"350": 55.4},
    isPublic: true,
    gallary: [],
    composition: [],
    measurement_value: "мл",
    energy_and_nutritional_value: [],
    size: ["350"],
    rating: 5.0,
    code: "134442",
    categorys: [],
  )
];
