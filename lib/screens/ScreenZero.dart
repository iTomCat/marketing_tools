import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class ScreenZero extends StatefulWidget {
  const ScreenZero({Key? key}) : super(key: key);

  @override
  State<ScreenZero> createState() => _ScreenZeroState();
}

class _ScreenZeroState extends State<ScreenZero> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWidget(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {

          var widgetJson = json.decode(snapshot.data!);

          var widget = JsonWidgetData.fromDynamic(
            widgetJson,
          );
          return widget!.build(context: context);

          //return  Text('dadada ${snapshot.data}');

        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> getWidget() async {
    //var jsonStr = await rootBundle.loadString('assets/pages/${args![0]}.json');
    String jsonStr = await rootBundle.loadString('assets/jsons/column_button.json');

    return jsonStr;
  }

}
