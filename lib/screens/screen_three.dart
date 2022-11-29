import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  /// Obsługa widgetu json_dynamic_widget 5.1.3+5
  /// https://pub.dev/packages/json_dynamic_widget



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.hasData) {
          var widgetJson = json.decode(snapshot.data!.body);

          var widget = JsonWidgetData.fromDynamic(
            widgetJson,
          );
          return widget!.build(context: context);
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: _getWidget(),
    );
  }
  }

Future<http.Response> _getWidget() async {

  const url = 'https://medium-json-dynamic-widget.herokuapp.com/mainpage';
  return http.get(Uri.parse(url));
}


