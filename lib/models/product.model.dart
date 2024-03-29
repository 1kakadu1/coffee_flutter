import 'package:coffe_flutter/utils/parse.util.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  late String id;
  late String slug;
  late String preview;
  late String name;
  late String name_ua;
  late String name_en;
  late String code;
  late String description;
  late String description_ua;
  late String description_en;
  late double rating;
  late List<String> composition;
  late List<String> composition_ua;
  late List<String> composition_en;
  late List<Map<String, dynamic>> energy_and_nutritional_value;
  late List<Map<String, dynamic>> energy_and_nutritional_value_ua;
  late List<Map<String, dynamic>> energy_and_nutritional_value_en;
  late List<String> gallary;
  late bool isPublic;
  late String measurement_value;
  late String measurement_value_ua;
  late String measurement_value_en;
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
      required this.description_ua,
      required this.description_en,
      required this.name,
      required this.name_ua,
      required this.name_en,
      required this.preview,
      required this.price,
      required this.rating,
      required this.composition,
      required this.composition_ua,
      required this.composition_en,
      required this.energy_and_nutritional_value,
      required this.energy_and_nutritional_value_ua,
      required this.energy_and_nutritional_value_en,
      required this.gallary,
      required this.isPublic,
      required this.measurement_value,
      required this.measurement_value_ua,
      required this.measurement_value_en,
      required this.size,
      required this.categorys});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    name_en = json["name_en"] ?? "";
    name_ua = json["name_ua"] ?? "";
    slug = json["slug"] ?? "";
    preview = json["preview"] ?? "";
    id = json["id"] ?? "";
    code = json["code"] ?? 0;
    price = Map<String, double>.from(json["price"]);
    description = json["description"] ?? "";
    description_ua = json["description_ua"] ?? "";
    description_en = json["description_en"] ?? "";
    rating = json["rating"] ?? 0;
    size = parseArrayString(json["size"], ["0"]);
    measurement_value = json["measurement_value"] ?? "unset";
    measurement_value_en = json["measurement_value_en"] ?? "unset";
    measurement_value_ua = json["measurement_value_ua"] ?? "unset";
    gallary = parseArrayString(json["gallary"], []);
    energy_and_nutritional_value =
        parseArrayMap<dynamic>(json["energy_and_nutritional_value"], []);
    energy_and_nutritional_value_en =
        parseArrayMap<dynamic>(json["energy_and_nutritional_value_en"], []);
    energy_and_nutritional_value_ua =
        parseArrayMap<dynamic>(json["energy_and_nutritional_value_ua"], []);
    isPublic = json["isPublic"] ?? true;
    composition = parseArrayString(json["composition"], []);
    composition_ua = parseArrayString(json["composition_ua"], []);
    composition_en = parseArrayString(json["composition_en"], []);
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
    data["name_ua"] = name_ua;
    data["name_en"] = name_en;
    data["description"] = description;
    data["description_ua"] = description_ua;
    data["description_en"] = description_en;
    data["composition_ua"] = composition_ua;
    data["composition_en"] = composition_en;
    data["composition"] = composition;
    data["isPublic"] = isPublic;
    data["energy_and_nutritional_value"] = energy_and_nutritional_value;
    data["energy_and_nutritional_value_ua"] = energy_and_nutritional_value_ua;
    data["energy_and_nutritional_value_en"] = energy_and_nutritional_value_en;
    data["gallary"] = gallary;
    data["measurement_value"] = measurement_value;
    data["measurement_value_ua"] = measurement_value_ua;
    data["measurement_value_en"] = measurement_value_en;
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
      description_ua,
      description_en,
      name,
      name_ua,
      name_en,
      preview,
      price,
      rating,
      id,
      composition,
      composition_ua,
      composition_en,
      size,
      energy_and_nutritional_value,
      energy_and_nutritional_value_ua,
      energy_and_nutritional_value_en,
      gallary,
      isPublic,
      measurement_value,
      measurement_value_ua,
      measurement_value_en,
      categorys,
      isSpecial,
      isTop,
      slug}) {
    return ProductModel(
        slug: slug ?? this.slug,
        id: id ?? this.id,
        code: code ?? this.code,
        description: description ?? this.description,
        description_en: description_en ?? this.description_en,
        description_ua: description_ua ?? this.description_ua,
        name: name ?? this.name,
        name_en: name_en ?? this.name_en,
        name_ua: name_ua ?? this.name_ua,
        preview: preview ?? this.preview,
        price: price ?? this.price,
        rating: rating ?? this.rating,
        composition: composition ?? this.composition,
        composition_en: composition_en ?? this.composition_en,
        composition_ua: composition_ua ?? this.composition_ua,
        size: size ?? this.size,
        energy_and_nutritional_value:
            energy_and_nutritional_value ?? this.energy_and_nutritional_value,
        energy_and_nutritional_value_ua: energy_and_nutritional_value_ua ??
            this.energy_and_nutritional_value_ua,
        energy_and_nutritional_value_en: energy_and_nutritional_value_en ??
            this.energy_and_nutritional_value_en,
        gallary: gallary ?? this.gallary,
        isPublic: isPublic ?? this.isPublic,
        measurement_value: measurement_value ?? this.measurement_value,
        measurement_value_ua: measurement_value_ua ?? this.measurement_value_ua,
        measurement_value_en: measurement_value_en ?? this.measurement_value_en,
        isSpecial: isSpecial ?? this.isSpecial,
        isTop: isTop ?? this.isTop,
        categorys: categorys ?? this.categorys);
  }

  @override
  List<Object> get props => [
        slug,
        id,
        description,
        description_en,
        description_ua,
        name,
        name_ua,
        name_en,
        preview,
        price,
        rating,
        composition,
        composition_ua,
        composition_en,
        energy_and_nutritional_value,
        energy_and_nutritional_value_ua,
        energy_and_nutritional_value_en,
        gallary,
        isPublic,
        measurement_value,
        measurement_value_ua,
        measurement_value_en,
        size,
        categorys,
      ];
}

final List<ProductModel> productsMock = [
  ProductModel(
      id: "1",
      slug: "bumble-coffee",
      name: "Бамбл кофе",
      name_en: "Bumble coffee",
      name_ua: "Бамбл кава",
      description:
          "Холодный веселый напиток: кофе с апельсиновым соком, уложенные полосками. Отсюда и сравнение со шмелем (bumblebee по-английски — шмель). Перед употреблением напиток лучше размешать. Этот рецепт — из «Кофемании».",
      description_en:
          "Cold cheerful drink: coffee with orange juice, laid in strips. Hence the comparison with bumblebee (bumblebee in English — bumblebee). It is better to place the drink before drinking. This recipe is from 'Coffee Mania'.",
      description_ua:
          "Холодний веселий напій: Кава з апельсиновим соком, укладені смужками. Звідси і порівняння зі джмелем (bumblebee по-англійськи — джміль). Перед вживанням напій краще розміщувати. Цей рецепт - з 'Кавоманії'.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fp_O.jpg?alt=media&token=24682faf-6aef-48c4-a86f-3a2b9792e971",
      rating: 4.2,
      code: "134445",
      price: {"280": 55.4},
      isPublic: true,
      gallary: [],
      composition: ["Эспрессо", "апельсиновый сок", "карамельный сироп", "лёд"],
      composition_en: ["Espresso", "orange juice", "caramel syrup", "ice"],
      composition_ua: [
        "Еспресо",
        "апельсиновий сік",
        "карамельний сироп",
        "лід"
      ],
      measurement_value: "мл",
      measurement_value_ua: "мл",
      measurement_value_en: "ml",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "0,7"},
        {"title": "Жиры, гр", "value": "3,83"},
        {"title": "Углеводы, гр", "value": "3,44"},
        {"title": "Энергетическая ценность, ккал", "value": "34,82"}
      ],
      energy_and_nutritional_value_ua: [
        {"title": "Білки, гр", "value": "0,7"},
        {"title": "Жири, гр", "value": "3,83"},
        {"title": "Вуглеводи, гр", "value": "3,44"},
        {"title": "Енергетична цінність, ккал", "value": "34,82"}
      ],
      energy_and_nutritional_value_en: [
        {"title": "Proteins, gr", "value": "0,7"},
        {"title": "Fats, g", "value": "3,83"},
        {"title": "Carbohydrates, g", "value": "3,44"},
        {"title": "Energy value, kcal", "value": "34,82"}
      ],
      size: ["280"],
      isSpecial: true,
      categorys: ["id-all", "id-coffee"]),
  ProductModel(
      id: "2",
      slug: "latte-halva",
      name: "Латте-халва",
      name_en: "Latte halva",
      name_ua: "Латте-халва",
      description:
          "Этот кофейный напиток можно назвать самым русским, ведь в нем неожиданное сочетание семечек и кофе. Но вы будете приятно удивлены, этот кофе получается нежным, сладким и ароматным.",
      description_en:
          "This coffee drink can be called the most Russian, because it has an unexpected combination of seeds and coffee. But you will be pleasantly surprised, this coffee turns out to be tender, sweet and fragrant.",
      description_ua:
          "Цей кавовий напій можна назвати самим російським, адже в ньому несподіване поєднання насіння і кави. Але ви будете приємно здивовані, ця кава виходить ніжною, солодкою і ароматною.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fdawd.jpg?alt=media&token=df9c8b64-6890-44ff-be97-deb523710b40",
      rating: 5.0,
      code: "134442",
      price: {"300": 100},
      isPublic: true,
      gallary: [],
      composition: ["Эспрессо", "молоко", "соус из халвы"],
      composition_ua: ["Еспресо", "молоко", "соус з халви"],
      composition_en: ["Espresso", "milk", "halva sauce"],
      measurement_value: "мл",
      measurement_value_ua: "мл",
      measurement_value_en: "ml",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "3,56"},
        {"title": "Жиры, гр", "value": "6,34"},
        {"title": "Углеводы, гр", "value": "14,63"},
        {"title": "Энергетическая ценность, ккал", "value": "127,91"}
      ],
      energy_and_nutritional_value_ua: [
        {"title": "Білки, гр", "value": "3,56"},
        {"title": "Жири, гр", "value": "6,34"},
        {"title": "Вуглеводи, гр", "value": "14,63"},
        {"title": "Енергетична цінність, ккал", "value": "127,91"}
      ],
      energy_and_nutritional_value_en: [
        {"title": "Proteins, gr", "value": "3,56"},
        {"title": "Fats, g", "value": "6,34"},
        {"title": "Carbohydrates, g", "value": "14,63"},
        {"title": "Energy value, kcal", "value": "127,91"}
      ],
      size: ["300"],
      categorys: ["id-all", "id-coffee"]),
  ProductModel(
      id: "3",
      name: "Раф",
      name_ua: "Раф",
      name_en: "Raf",
      slug: 'raf',
      description:
          "Раф кофе — это горячий кофейный напиток на основе эспрессо, ванильного сахара и жирных сливок, которые смешиваются в питчере и взбиваются паром с помощью кофемашины.",
      description_ua:
          "Раф кава-це гарячий кавовий напій на основі еспресо, ванільного цукру і жирних вершків, які змішуються в глечику і збиваються парою за допомогою кавомашини.",
      description_en:
          "Raf coffee is a hot coffee drink based on espresso, vanilla sugar and heavy cream, which are mixed in a pitcher and whipped with steam using a coffee machine.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Floj.jpg?alt=media&token=214c886e-352a-49f0-aca1-b1062fe2a3ba",
      price: {
        "250": 25,
        "350": 55.4,
      },
      isPublic: true,
      gallary: [],
      composition: ["эпрессо", "сливки", "ваниль"],
      composition_ua: ["Еспрессо", "вершки", "ваніль"],
      composition_en: ["espresso", "cream", "vanilla"],
      measurement_value: "мл",
      measurement_value_ua: "мл",
      measurement_value_en: "ml",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "2,37"},
        {"title": "Жиры, гр", "value": "7,99"},
        {"title": "Углеводы, гр", "value": "10,1"},
        {"title": "Энергетическая ценность, ккал", "value": "160,86"}
      ],
      energy_and_nutritional_value_ua: [
        {"title": "Білки, гр", "value": "2,37"},
        {"title": "Жири, гр", "value": "7,99"},
        {"title": "Вуглеводи, гр", "value": "10,1"},
        {"title": "Енергетична цінність, ккал", "value": "160,86"}
      ],
      energy_and_nutritional_value_en: [
        {"title": "Proteins, gr", "value": "2,37"},
        {"title": "Fats, g", "value": "7,99"},
        {"title": "Carbohydrates, g", "value": "10,1"},
        {"title": "Energy value, kcal", "value": "160,86"}
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
      name_ua: "Чай молочний улун",
      name_en: "Milk Oolong Tea",
      description:
          "Молочный улун (оолонг) – самый знаменитый светлый улун, особый вид полуферментированного китайского чая. Сливочный вкус, а также необыкновенно полезный состав — все это делает чай очень востребованным и популярным. Легенда и история открытия нового сорта чая начинается с 1982 году, в горной области Наньтоу на острове Тайвань. Настоящий молочный улун получил официальное название «Най Сян Цзинь Сюань» - что означает «золотой цветок», и в короткие сроки стал широко известен среди ценителей чая по всему миру.",
      description_en:
          "Milk oolong (oolong) is the most famous light oolong, a special kind of semi–fermented Chinese tea. Creamy taste, as well as an unusually healthy composition — all this makes tea very popular and in demand. The legend and history of the discovery of a new kind of tea begins in 1982, in the mountainous region of Nantou on the island of Taiwan. The real milk oolong received the official name 'Nai Xiang Jin Xuan' - which means 'golden flower', and in a short time became widely known among tea connoisseurs around the world.",
      description_ua:
          "Молочний улун (оолонг) - найзнаменитіший світлий улун, особливий вид напівферментованого китайського чаю. Вершковий смак, а також надзвичайно корисний склад — все це робить чай дуже затребуваним і популярним. Легенда та історія відкриття нового сорту чаю починається з 1982 році, в гірській області Наньтоу на острові Тайвань. Справжній молочний улун отримав офіційну назву 'Най Сян Цзінь Сюань « - що означає» Золота квітка', і в короткі терміни став широко відомий серед цінителів чаю по всьому світу.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2F008e015cd907da87f5f306f673337439b1c.jpeg?alt=media&token=bbe919da-ba86-49ce-adb5-aeb241dd94bb",
      price: {"400": 62},
      isPublic: true,
      gallary: [],
      composition: ["китайский чай" "сливки"],
      composition_ua: ["китайський чай " "вершки"],
      composition_en: ["chinese tea" "cream"],
      measurement_value: "мл",
      measurement_value_ua: "мл",
      measurement_value_en: "ml",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "0,22"},
        {"title": "Жиры, гр", "value": "0,06"},
        {"title": "Углеводы, гр", "value": "2,95"},
        {"title": "Энергетическая ценность, ккал", "value": "12,61"}
      ],
      energy_and_nutritional_value_ua: [
        {"title": "Білки, гр", "value": "0,22"},
        {"title": "Жири, гр", "value": "0,06"},
        {"title": "Вуглеводи, гр", "value": "2,95"},
        {"title": "Енергетична цінність, ккал", "value": "12,61"}
      ],
      energy_and_nutritional_value_en: [
        {"title": "Proteins, gr", "value": "0,22"},
        {"title": "Fats, g", "value": "0,06"},
        {"title": "Carbohydrates, g", "value": "2,95"},
        {"title": "Energy value, kcal", "value": "12,61"}
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
      name_ua: "Каркаде",
      name_en: "Karkade",
      description_ua:
          "Каркаде-квітковий чай родом зі Сходу. Першими висушені пелюстки гібіскуса і розели для приготування напою, що бадьорить почали використовувати жителі Стародавнього Єгипту. Звідси пішла і альтернативна назва каркаде - »напій фараонів'. Також цей чай поетично називають суданської трояндою, мальвою Венеції, трояндою Шарона. В Європі каркаде з'явився лише в XVIII столітті, і спочатку його кислуватий присмак припав консервативним обивателям Старого Світу не до душі. Ситуація змінилася лише до середини XX століття.",
      description_en:
          "Karkade is a flower tea native to the East. The inhabitants of Ancient Egypt were the first to use dried hibiscus and rosella petals to prepare an invigorating drink. Hence the alternative name of karkade — 'drink of the pharaohs'. Also, this tea is poetically called the Sudanese rose, the mallow of Venice, the rose of Sharon. In Europe, karkade appeared only in the XVIII century, and at first its sour taste was not to the liking of conservative inhabitants of the Old World. The situation changed only by the middle of the XX century.",
      description:
          "Каркаде — цветочный чай родом с Востока. Первыми высушенные лепестки гибискуса и розеллы для приготовления бодрящего напитка начали использовать жители Древнего Египта. Отсюда пошло и альтернативное название каркаде — «напиток фараонов». Также этот чай поэтично называют суданской розой, мальвой Венеции, розой Шарона. В Европе каркаде появился лишь в XVIII веке, и поначалу его кисловатый привкус пришелся консервативным обывателям Старого Света не по душе. Ситуация изменялась лишь к середине XX столетия.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2F148630-ed4_wide.jpg?alt=media&token=5bcb8960-cc36-445a-81e6-ee72a30e283e",
      price: {"250": 15},
      isPublic: true,
      gallary: [],
      composition: ["каркаде", "вода", "сахар", "мускатный орех"],
      composition_ua: ["каркаде", "вода", "цукор", "мускатний горіх"],
      composition_en: ["karkade", "water", "sugar", "nutmeg"],
      measurement_value: "мл",
      measurement_value_ua: "мл",
      measurement_value_en: "ml",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "0"},
        {"title": "Жиры, гр", "value": "0"},
        {"title": "Углеводы, гр", "value": "14"},
        {"title": "Энергетическая ценность, ккал", "value": "54"}
      ],
      energy_and_nutritional_value_ua: [
        {"title": "Білки, гр", "value": "0"},
        {"title": "Жири, гр", "value": "0"},
        {"title": "Вуглеводи, гр", "value": "14"},
        {"title": "Енергетична цінність, ккал", "value": "54"}
      ],
      energy_and_nutritional_value_en: [
        {"title": "Proteins, gr", "value": "0"},
        {"title": "Fats, g", "value": "0"},
        {"title": "Carbohydrates, g", "value": "14"},
        {"title": "Energy value, kcal", "value": "54"}
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
      name_ua: "Ірландська кава",
      name_en: "Irish coffee",
      description_ua:
          "Вам подобаються класичні гарячі коктейлі? Тоді спробуйте цей слабоалкогольний вершковий, кавовий і солодкий коктейль на основі віскі.",
      description_en:
          "Do you like classic hot cocktails? Then try this low-alcohol creamy, coffee and sweet whiskey-based cocktail.",
      description:
          "Вам нравятся классические горячие коктейли? Тогда попробуйте этот слабоалкогольный сливочный, кофейный и сладкий коктейль на основе виски. ",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Firlandskii-kofe-1024x683.jpg?alt=media&token=c0115d4c-56d4-47e7-91ce-9ca9bfb13003",
      price: {"250": 25},
      isPublic: true,
      gallary: [],
      composition: ["сливки", "вода", "сахар", "виски", "кофе молотый"],
      composition_ua: ["вершки", "вода", "цукор", "віскі", "Кава мелена"],
      composition_en: ["cream", "water", "sugar", "whiskey", "ground coffee"],
      measurement_value: "мл",
      measurement_value_ua: "мл",
      measurement_value_en: "ml",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "7"},
        {"title": "Жиры, гр", "value": "16"},
        {"title": "Углеводы, гр", "value": "16"},
        {"title": "Энергетическая ценность, ккал", "value": "304"}
      ],
      energy_and_nutritional_value_ua: [
        {"title": "Білки, гр", "value": "7"},
        {"title": "Жири, гр", "value": "16"},
        {"title": "Вуглеводи, гр", "value": "16"},
        {"title": "Енергетична цінність, ккал", "value": "304"}
      ],
      energy_and_nutritional_value_en: [
        {"title": "Proteins, gr", "value": "7"},
        {"title": "Fats, g", "value": "16"},
        {"title": "Carbohydrates, g", "value": "16"},
        {"title": "Energy value, kcal", "value": "304"}
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
      name_ua: "Холодний чай з перської трояндою і малиною",
      name_en: "Iced tea with Persian rose and raspberry",
      description_ua:
          "Солодкий, ягідний, красивий, освіжаючий — цей напій створений для теплих літніх днів.",
      description_en:
          "Sweet, berry, beautiful, refreshing — this drink is created for warm summer days.",
      description:
          "Сладкий, ягодный, красивый, освежающий — этот напиток создан для тёплых летних дней.",
      preview:
          "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fshutterstock_314532605_1625232057-736x368.jpeg?alt=media&token=e7d4fe59-1cc6-4e4e-aca9-df673c72bcf4",
      price: {"250": 25},
      isPublic: true,
      gallary: [],
      composition: ["малина", "вода", "сахар", "чёрный чай", "лимонный сок"],
      composition_ua: ["малина", "вода", "цукор", "чорний чай", "лимонний сік"],
      composition_en: [
        "raspberry",
        "water",
        "sugar",
        "black tea",
        "lemon juice"
      ],
      measurement_value: "мл",
      measurement_value_ua: "мл",
      measurement_value_en: "ml",
      energy_and_nutritional_value: [
        {"title": "Белки, гр", "value": "0"},
        {"title": "Жиры, гр", "value": "0"},
        {"title": "Углеводы, гр", "value": "14"},
        {"title": "Энергетическая ценность, ккал", "value": "55"}
      ],
      energy_and_nutritional_value_ua: [
        {"title": "Білки, гр", "value": "0"},
        {"title": "Жири, гр", "value": "0"},
        {"title": "Вуглеводи, гр", "value": "14"},
        {"title": "Енергетична цінність, ккал", "value": "55"}
      ],
      energy_and_nutritional_value_en: [
        {"title": "Proteins, gr", "value": "0"},
        {"title": "Fats, g", "value": "0"},
        {"title": "Carbohydrates, g", "value": "14"},
        {"title": "Energy value, kcal", "value": "55"}
      ],
      size: ["250"],
      rating: 4.8,
      code: "2345342368",
      categorys: ["id-all", "id-tea"],
      isTop: true),
  ProductModel(
    id: "8",
    name: "Холодный кофе с молоком",
    name_ua: "Холодна кава з молоком",
    name_en: "Cold coffee with milk",
    slug: "cold-coffee-with-milk",
    description_ua:
        "Літо в місті - на вулицях, в парках і в улюблених кав'ярнях. І поки заклади намагаються врятувати відвідувачів від спеки, нам слід дізнатися дещо про прохолодні напої для кавоманів. Ви вже пробували колдбрю в пляшках, газований кавовий лимонад, кава кислий або Еспресо-тонік? Якщо ні, ще є трохи часу в запасі. Ми ж хочемо розповісти вам, як зробити прості і смачні холодні коктейлі з кавою в домашніх умовах.",
    description_en:
        "Summer in the city — on the streets, in parks and in your favorite coffee shops. And while the establishments are trying to save visitors from the heat, we should learn something about soft drinks for coffee lovers. Have you tried bottled cold brew, carbonated coffee lemonade, sour coffee or espresso tonic? If not, there is still some time left. We want to tell you how to make simple and delicious cold cocktails with coffee at home.",
    description:
        "Лето в городе — на улицах, в парках и в любимых кофейнях. И пока заведения пытаются спасти посетителей от жары, нам следует узнать кое-что о прохладительных напитках для кофеманов. Вы уже пробовали колдбрю в бутылках, газированный кофейный лимонад, кофе сауэр или эспрессо-тоник? Если нет, еще есть немного времени в запасе. Мы же хотим рассказать вам, как сделать простые и вкусные холодные коктейли с кофе в домашних условиях.",
    preview:
        "https://firebasestorage.googleapis.com/v0/b/cofee-flutter.appspot.com/o/products%2Fshutterstock_1311397970-1_1589904357-e1654685691974-1280x640.jpg?alt=media&token=a8ba347e-7939-4465-a43b-97e9eb40b3c6",
    price: {"350": 25},
    isPublic: true,
    gallary: [],
    composition: ["колотый лед", "вода", "сахар", "корица", "молоко"],
    composition_en: ["crushed ice", "water", "sugar", "cinnamon", "milk"],
    composition_ua: ["подрібнений лід", "вода", "цукор", "кориця", "молоко"],
    measurement_value: "мл",
    measurement_value_ua: "мл",
    measurement_value_en: "ml",
    energy_and_nutritional_value: [
      {"title": "Белки, гр", "value": "20"},
      {"title": "Жиры, гр", "value": "34"},
      {"title": "Углеводы, гр", "value": "14"},
      {"title": "Энергетическая ценность, ккал", "value": "228"}
    ],
    energy_and_nutritional_value_ua: [
      {"title": "Білки, гр", "value": "20"},
      {"title": "Жири, гр", "value": "34"},
      {"title": "Вуглеводи, гр", "value": "14"},
      {"title": "Енергетична цінність, ккал", "value": "228"}
    ],
    energy_and_nutritional_value_en: [
      {"title": "Proteins, gr", "value": "20"},
      {"title": "Fats, g", "value": "34"},
      {"title": "Carbohydrates, g", "value": "14"},
      {"title": "Energy value, kcal", "value": "228"}
    ],
    size: ["350"],
    rating: 4.2,
    code: "82345342368",
    categorys: ["id-all", "id-coffee"],
  )
];
