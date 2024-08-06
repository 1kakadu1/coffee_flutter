import 'package:coffe_flutter/const/env.dart';
import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

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

List<Item> _getItems(BuildContext context) {
  return [
    Item(
        order: 0,
        expandedValue: S.of(context).aboutItemBody1,
        headerValue: S.of(context).aboutItemHeader1),
    Item(
        order: 1,
        expandedValue: S.of(context).aboutItemBody2,
        headerValue: S.of(context).aboutItemHeader2),
    Item(
        order: 2,
        expandedValue: S.of(context).aboutItemBody3,
        headerValue: S.of(context).aboutItemHeader3),
    Item(
        order: 3,
        expandedValue: S.of(context).aboutItemHeader4,
        headerValue: S.of(context).aboutItemBody4)
  ];
}

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  final double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  List<Item> _data = [];
  late final ScrollController _scrollController;
  late final PanelController _panelController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _panelController = PanelController();
    Future.delayed(Duration.zero, () {
      setState(() {
        _data = _getItems(context);
      });
    });

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
      key: _scaffoldKey,
      body: AboutScreenContent(
          initFabHeight: _initFabHeight,
          fabHeight: _fabHeight,
          panelHeightOpen: _panelHeightOpen,
          panelHeightClosed: _panelHeightClosed,
          onPanelSlide: _onPanelSlide,
          expanded: _data,
          scrollController: _scrollController,
          panelController: _panelController,
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
  ScrollController scrollController;
  PanelController panelController;
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
    required this.panelController,
    required this.scrollController,
  }) : super(key: key);

  Widget _body() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.509364, -0.128928),
        zoom: 9.2,
      ),
      nonRotatedChildren: const [
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: null,
            ),
          ],
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
              child: Image.asset(
                  "assets/img/marker.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _panel(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          physics: PanelScrollPhysics(controller: panelController),
          controller: scrollController,
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
              children: <Widget>[
                Text(
                  S.of(context).screenAbout,
                  style: const TextStyle(
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
                children: <Widget>[
                  Text(
                    S.of(context).titleTimeWork,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(S.of(context).timeWorkAbout),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(S.of(context).timeWorkShop,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(S.of(context).timeShop),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(S.of(context).titleMinOrder,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(S.of(context).minOrderInfo),
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
            snapPoint: .5,
            color: AppColors.background,
            disableDraggableOnScrolling: false,
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            controller: panelController,
            scrollController: scrollController,
            panelBuilder: () => _panel(context),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => onPanelSlide(pos, panelHeightOpen),
          ),
        ],
      ),
    );
  }
}
