import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
//https://www.youtube.com/watch?v=2aJZzRMziJc&ab_channel=Flutter
import '../../const/env.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.order,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  int order;
}

List<Item> _getItems() {
  return [
    Item(
        order: 0,
        expandedValue:
            "Мы очень внимательно следим за качеством нашей работы, поэтому, если у вас будут какие-либо замечания или предложения, то обязательно сообщайте их нам",
        headerValue: "Если появились замечания"),
    Item(
        order: 1,
        expandedValue: "Оплата Visa, MasterCard",
        headerValue: "Если появились замечания"),
    Item(
        order: 2,
        expandedValue:
            "Мы очень внимательно следим за качеством нашей работы, поэтому, если у вас будут какие-либо замечания или предложения, то обязательно сообщайте их нам",
        headerValue: "Не понравился продукт?"),
    Item(
        order: 3,
        expandedValue:
            "Мы очень внимательно следим за качеством нашей работы, поэтому, если у вас будут какие-либо замечания или предложения, то обязательно сообщайте их нам",
        headerValue: "Вам что-то не довезли?")
  ];
}

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  final double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  final List<Item> _data = _getItems();

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  void _toggleExpanded(int index, bool isExpanded) {
    setState(() {
      _data[index].isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AboutScreenContent(
          initFabHeight: _initFabHeight,
          fabHeight: _fabHeight,
          panelHeightOpen: _panelHeightOpen,
          panelHeightClosed: _panelHeightClosed,
          onPanelSlide: _onPanelSlide,
          expanded: _data,
          toggleExpanded: _toggleExpanded),
    );
  }

  void _onPanelSlide(double pos, double panelHeightOpen) => setState(() {
        _fabHeight =
            pos * (panelHeightOpen - _panelHeightClosed) + _initFabHeight;
      });
}

class AboutScreenContent extends StatelessWidget {
  double initFabHeight;
  double fabHeight;
  double panelHeightOpen;
  double panelHeightClosed;
  List<Item> expanded;
  Function(double value, double panelHeightOpen) onPanelSlide;
  Function(int index, bool isExpanded) toggleExpanded;
  AboutScreenContent({
    Key? key,
    required this.initFabHeight,
    required this.fabHeight,
    required this.panelHeightOpen,
    required this.panelHeightClosed,
    required this.onPanelSlide,
    required this.toggleExpanded,
    required this.expanded,
  }) : super(key: key);

  Widget _body() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.509364, -0.128928),
        zoom: 9.2,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
      children: [
        TileLayer(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/anton-soroka2023/clg7wa15r000901kpdn0i0s59/tiles/256/{z}/{x}/{y}@2x?access_token=${Env.MAPBOX_KEY}",
          additionalOptions: const {
            "access_token": Env.MAPBOX_KEY,
          },
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(51.509364, -0.128928),
              width: 80,
              height: 80,
              builder: (context) {
                return Image.asset(
                  "assets/img/marker.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _panel(ScrollController sc, BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: const BoxDecoration(
                      color: AppColors.subtext,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "О нас",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36.0,
            ),
            ExpansionPanelList(
              expansionCallback: toggleExpanded,
              children: expanded.map<ExpansionPanel>((
                Item item,
              ) {
                return ExpansionPanel(
                  backgroundColor: AppColors.backgraundLightBotto,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      tileColor: AppColors.backgraundLightBotto,
                      selectedColor: AppColors.background,
                      title: Text(item.headerValue),
                      onTap: () {
                        toggleExpanded(item.order, isExpanded);
                      },
                    );
                  },
                  body: ListTile(
                    tileColor: AppColors.background,
                    selectedColor: AppColors.background,
                    title: Text(item.expandedValue),
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
            const SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "График работы доставки:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text("с 10:00-21:00"),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text("График работы кафе:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text("с 08:00-21:00"),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text("Минимальный заказ:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                      "Бесплатная доставка пешим курьером при сумме заказа от 400 ₽ Доставка оператором такси от любой суммы заказа - по тарифам перевозчика."),
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * .80;
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
              maxHeight: panelHeightOpen,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: _body(),
              color: AppColors.background,
              panelBuilder: (sc) => _panel(sc, context),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
              onPanelSlide: (double pos) => onPanelSlide(pos, panelHeightOpen)),
        ],
      ),
    );
  }
}
