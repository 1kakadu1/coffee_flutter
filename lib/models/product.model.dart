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
      required this.categorys});

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
      name: "Бамбл кофе",
      description:
          "Холодный веселый напиток: кофе с апельсиновым соком, уложенные полосками. Отсюда и сравнение со шмелем (bumblebee по-английски — шмель). Перед употреблением напиток лучше размешать. Этот рецепт — из «Кофемании».",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fp_O.jpg?alt=media&token=24682faf-6aef-48c4-a86f-3a2b9792e971",
      rating: 4.2,
      code: "134445",
      price: {"280": 55.4},
      isPublic: true,
      gallary: [],
      composition: ["Эспрессо", "апельсиновый сок", "карамельный сироп", "лёд"],
      measurement_value: "мл",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "0,7"},
        {"title": "Жиры, гр", "value": "3,83"},
        {"title": "Углеводы, гр", "value": "3,44"},
        {"title": "Энергетическая ценность, ккал", "value": "34,82"}
      ],
      size: ["280"],
      categorys: ["id-all", "id-coffee"]),
  ProductModel(
      id: "2",
      name: "Латте-халва",
      description:
          "Этот кофейный напиток можно назвать самым русским, ведь в нем неожиданное сочетание семечек и кофе. Но вы будете приятно удивлены, этот кофе получается нежным, сладким и ароматным.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fdawd.jpg?alt=media&token=df9c8b64-6890-44ff-be97-deb523710b40",
      rating: 5.0,
      code: "134442",
      price: {"300": 100},
      isPublic: true,
      gallary: [],
      composition: ["Эспрессо", "молоко", "соус из халвы"],
      measurement_value: "мл",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "3,56"},
        {"title": "Жиры, гр", "value": "6,34"},
        {"title": "Углеводы, гр", "value": "14,63"},
        {"title": "Энергетическая ценность, ккал", "value": "127,91"}
      ],
      size: ["300"],
      categorys: ["id-all", "id-coffee"]),
  ProductModel(
      id: "3",
      name: "Раф",
      description:
          "Раф кофе — это горячий кофейный напиток на основе эспрессо, ванильного сахара и жирных сливок, которые смешиваются в питчере и взбиваются паром с помощью кофемашины.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Floj.jpg?alt=media&token=214c886e-352a-49f0-aca1-b1062fe2a3ba",
      price: {
        "250": 25,
        "350": 55.4,
      },
      isPublic: true,
      gallary: [],
      composition: ["спрессо", "сливки", "ваниль"],
      measurement_value: "мл",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "2,37"},
        {"title": "Жиры, гр", "value": "7,99"},
        {"title": "Углеводы, гр", "value": "10,1"},
        {"title": "Энергетическая ценность, ккал", "value": "160,86"}
      ],
      size: ["250", "350"],
      rating: 4.2,
      code: "134445",
      categorys: ["id-all", "id-coffee"]),
  ProductModel(
    id: "4",
    name: "Чай Молочный улун",
    description:
        "Молочный улун (оолонг) – самый знаменитый светлый улун, особый вид полуферментированного китайского чая. Сливочный вкус, а также необыкновенно полезный состав — все это делает чай очень востребованным и популярным. Легенда и история открытия нового сорта чая начинается с 1982 году, в горной области Наньтоу на острове Тайвань. Настоящий молочный улун получил официальное название «Най Сян Цзинь Сюань» - что означает «золотой цветок», и в короткие сроки стал широко известен среди ценителей чая по всему миру.",
    preview:
        "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2F008e015cd907da87f5f306f673337439b1c.jpeg?alt=media&token=bbe919da-ba86-49ce-adb5-aeb241dd94bb",
    price: {"400": 62},
    isPublic: true,
    gallary: [],
    composition: ["китайский чай" "сливки"],
    measurement_value: "мл",
    energy_and_nutritional_value: [
      {"title": "Белки, гр", "value": "0,22"},
      {"title": "Жиры, гр", "value": "0,06"},
      {"title": "Углеводы, гр", "value": "2,95"},
      {"title": "Энергетическая ценность, ккал", "value": "12,61"}
    ],
    size: ["400"],
    rating: 5.0,
    code: "134442",
    categorys: ["id-all", "id-tea"],
  )
];
