import 'package:coffe_flutter/utils/parse.util.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  late String id;
  late String slug;
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
  late bool? isTop;
  late bool? isSpecial;

  ProductModel(
      {required this.code,
      this.isTop,
      this.isSpecial,
      required this.slug,
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
    slug = json["slug"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    code = json["code"] ?? 0;
    price = Map<String, double>.from(json["price"]);
    description = json["description"] ?? "";
    rating = json["rating"] ?? 0;
    size = parseArrayString(json["size"], ["0"]);
    measurement_value = json["measurement_value"] ?? "unset";
    gallary = parseArrayString(json["gallary"], []);
    energy_and_nutritional_value =
        parseArrayMap<dynamic>(json["energy_and_nutritional_value"], []);
    isPublic = json["isPublic"] ?? true;
    composition = parseArrayString(json["composition"], []);
    categorys = parseArrayString(json["categorys"], []);
    isSpecial = json["isSpecial"] ?? false;
    isTop = json["isTop"] ?? false;
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
    data["isTop"] = isTop ?? false;
    data["isSpecial"] = isSpecial ?? false;
    data["slug"] = slug;
    return data;
  }

  ProductModel copyWith(
      {code,
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
      isSpecial,
      isTop,
      slug}) {
    return ProductModel(
        slug: slug ?? this.slug,
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
        isSpecial: isSpecial ?? this.isSpecial,
        isTop: isTop ?? this.isTop,
        categorys: categorys ?? this.categorys);
  }

  @override
  List<Object> get props => [
        slug,
        id,
        description,
        name,
        preview,
        price,
        rating,
        composition,
        energy_and_nutritional_value,
        gallary,
        isPublic,
        measurement_value,
        size,
        categorys,
      ];
}

final List<ProductModel> productsMock = [
  ProductModel(
      id: "1",
      slug: "bumble-coffee",
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
      isSpecial: true,
      categorys: ["id-all", "id-coffee"]),
  ProductModel(
      id: "2",
      slug: "latte-halva",
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
      slug: 'raf',
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
      isSpecial: true,
      categorys: ["id-all", "id-coffee"]),
  ProductModel(
      id: "4",
      slug: 'milk-oolong-tea',
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
      isSpecial: true),
  ProductModel(
      id: "5",
      slug: 'karkade',
      name: "Каркаде",
      description:
          "Каркаде — цветочный чай родом с Востока. Первыми высушенные лепестки гибискуса и розеллы для приготовления бодрящего напитка начали использовать жители Древнего Египта. Отсюда пошло и альтернативное название каркаде — «напиток фараонов». Также этот чай поэтично называют суданской розой, мальвой Венеции, розой Шарона. В Европе каркаде появился лишь в XVIII веке, и поначалу его кисловатый привкус пришелся консервативным обывателям Старого Света не по душе. Ситуация изменялась лишь к середине XX столетия.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2F148630-ed4_wide.jpg?alt=media&token=5bcb8960-cc36-445a-81e6-ee72a30e283e",
      price: {"250": 15},
      isPublic: true,
      gallary: [],
      composition: ["каркаде", "вода", "сахар", "мускатный орех"],
      measurement_value: "мл",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "0"},
        {"title": "Жиры, гр", "value": "0"},
        {"title": "Углеводы, гр", "value": "14"},
        {"title": "Энергетическая ценность, ккал", "value": "54"}
      ],
      size: ["250"],
      rating: 4.2,
      code: "1342368",
      categorys: ["id-all", "id-tea"],
      isTop: true),
  ProductModel(
      id: "6",
      slug: 'irish-coffee',
      name: "Ирландский кофе",
      description:
          "Вам нравятся классические горячие коктейли? Тогда попробуйте этот слабоалкогольный сливочный, кофейный и сладкий коктейль на основе виски. ",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Firlandskii-kofe-1024x683.jpg?alt=media&token=c0115d4c-56d4-47e7-91ce-9ca9bfb13003",
      price: {"250": 25},
      isPublic: true,
      gallary: [],
      composition: ["сливки", "вода", "сахар", "виски", "кофе молотый"],
      measurement_value: "мл",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "7"},
        {"title": "Жиры, гр", "value": "16"},
        {"title": "Углеводы, гр", "value": "16"},
        {"title": "Энергетическая ценность, ккал", "value": "304"}
      ],
      size: ["250"],
      rating: 4.8,
      code: "45342368",
      categorys: ["id-all", "id-coffee"],
      isTop: true),
  ProductModel(
      id: "7",
      slug: "iced-tea-with-persian-rose-and-raspberry",
      name: "Холодный чай с персидской розой и малиной",
      description:
          "Сладкий, ягодный, красивый, освежающий — этот напиток создан для тёплых летних дней.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fshutterstock_314532605_1625232057-736x368.jpeg?alt=media&token=e7d4fe59-1cc6-4e4e-aca9-df673c72bcf4",
      price: {"250": 25},
      isPublic: true,
      gallary: [],
      composition: ["малина", "вода", "сахар", "чёрный чай", "лимонный сок"],
      measurement_value: "мл",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "0"},
        {"title": "Жиры, гр", "value": "0"},
        {"title": "Углеводы, гр", "value": "14"},
        {"title": "Энергетическая ценность, ккал", "value": "55"}
      ],
      size: ["250"],
      rating: 4.8,
      code: "2345342368",
      categorys: ["id-all", "id-tea"],
      isTop: true),
  ProductModel(
    id: "8",
    name: "Холодный кофе с молоком",
    slug: "cold-coffee-with-milk",
    description:
        "Лето в городе — на улицах, в парках и в любимых кофейнях. И пока заведения пытаются спасти посетителей от жары, нам следует узнать кое-что о прохладительных напитках для кофеманов. Вы уже пробовали колдбрю в бутылках, газированный кофейный лимонад, кофе сауэр или эспрессо-тоник? Если нет, еще есть немного времени в запасе. Мы же хотим рассказать вам, как сделать простые и вкусные холодные коктейли с кофе в домашних условиях.",
    preview:
        "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fshutterstock_1311397970-1_1589904357-e1654685691974-1280x640.jpg?alt=media&token=a8ba347e-7939-4465-a43b-97e9eb40b3c6",
    price: {"350": 25},
    isPublic: true,
    gallary: [],
    composition: ["колотый лед", "вода", "сахар", "корица", "молоко"],
    measurement_value: "мл",
    energy_and_nutritional_value: [
      {"title": "Белки, гр", "value": "20"},
      {"title": "Жиры, гр", "value": "34"},
      {"title": "Углеводы, гр", "value": "14"},
      {"title": "Энергетическая ценность, ккал", "value": "228"}
    ],
    size: ["350"],
    rating: 4.2,
    code: "82345342368",
    categorys: ["id-all", "id-coffee"],
  )
];
