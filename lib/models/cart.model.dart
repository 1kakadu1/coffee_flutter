typedef ChangeCartItemCommentsType = void Function(
    String id, String size, String? comments);

class CartItemModel {
  late String name;
  late String? preview;
  late String id;
  late int count;
  late dynamic price;
  late List<String>? categorys;
  late String? comments;
  late String currentSize;

  CartItemModel(
      {required this.name,
      required this.preview,
      required this.id,
      required this.count,
      this.price,
      this.categorys,
      this.comments,
      required this.currentSize});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    count = json["count"] ?? 0;
    categorys = json["categorys"] ?? [];
    comments = json["comments"] ?? "";
    currentSize = json["currentSize"] ?? "";
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["count"] = count;
    data["price"] = price;
    data["preview"] = preview;
    data["name"] = name;
    data["currentSize"] = currentSize;
    return data;
  }

  CartItemModel copyWith({
    name,
    preview,
    id,
    count,
    price,
    categorys,
    comments,
    currentSize,
  }) {
    return CartItemModel(
      name: name ?? this.name,
      preview: preview ?? this.preview,
      id: id ?? this.id,
      count: count ?? this.count,
      price: price ?? this.price,
      categorys: categorys ?? this.categorys,
      comments: comments ?? this.comments,
      currentSize: currentSize ?? this.currentSize,
    );
  }
}

class CartItemCommentsModel {
  final String id;
  final String size;
  final String comments;

  CartItemCommentsModel(
      {required this.id, required this.size, required this.comments});
}
