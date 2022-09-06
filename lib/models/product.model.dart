class ProductModel {
  late String id;
  late String preview;
  late String name;
  late String code;
  late String description;
  late double price;
  late double rating;
  ProductModel(
      {required this.code,
      required this.id,
      required this.description,
      required this.name,
      required this.preview,
      required this.price,
      required this.rating});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    code = json["code"] ?? 0;
    price = json["price"] ?? 0;
    description = json["description"] ?? "";
    rating = json["rating"] ?? 0;
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
    return data;
  }

  ProductModel copyWith({code, description, name, preview, price, rating, id}) {
    return ProductModel(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      name: name ?? this.name,
      preview: preview ?? this.preview,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }
}

final List<ProductModel> productsMock = [
  ProductModel(
      id: "1",
      name: "Cappuccino",
      description: "loprem lorem lorem",
      preview:
          "https://www.ornelio.ru/upload/iblock/c60/c60aeac97d6f41f7292b764c40016c7e.jpg",
      price: 55.4,
      rating: 4.2,
      code: "134445"),
  ProductModel(
      id: "2",
      name: "Cappuccino milk top",
      description: "loprem lorem lorem",
      preview:
          "https://st2.depositphotos.com/5355656/7813/i/450/depositphotos_78138608-stock-photo-a-cup-of-cappuccino.jpg",
      price: 4,
      rating: 5.0,
      code: "134442"),
  ProductModel(
      id: "1",
      name: "Cappuccino",
      description: "loprem lorem lorem",
      preview:
          "https://www.ornelio.ru/upload/iblock/c60/c60aeac97d6f41f7292b764c40016c7e.jpg",
      price: 55.4,
      rating: 4.2,
      code: "134445"),
  ProductModel(
      id: "2",
      name: "Cappuccino milk top",
      description: "loprem lorem lorem",
      preview:
          "https://st2.depositphotos.com/5355656/7813/i/450/depositphotos_78138608-stock-photo-a-cup-of-cappuccino.jpg",
      price: 4,
      rating: 5.0,
      code: "134442")
];
