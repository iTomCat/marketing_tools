import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

import '../jejsony.dart';

class ScreenFour extends StatefulWidget {
   const ScreenFour({Key? key}) : super(key: key);


  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {


  final  navigatorKey = GlobalKey<NavigatorState>();
  final registry = JsonWidgetRegistry.instance;


  JsonWidgetData? _data;

  @override
  void initState() {
    super.initState();
    registry.navigatorKey = navigatorKey;

    /// Tu init jest w initState w ScreenZero init jest w FutureBuild
    /// czytanie jest z json bezpośrednio nie z pliku *.json

    //var widgetJson = json.decode(dynamicContainerJson);
    //var widgetJson = json.decode(text2Json);
    var widgetJson = json.decode(buttonWithColumn);

    _data = JsonWidgetData.fromDynamic(widgetJson);

  }

  @override
  Widget build(BuildContext context) => _data!.build(
    context: context,
    //registry: JsonWidgetRegistry.instance,
  );
}
