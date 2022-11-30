import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:yaon/yaon.dart' as yaon;

import 'blank_pages/full_widget_page.dart';
import 'blank_pages/untestable_full_widget_page.dart';

class ScreenZero extends StatefulWidget {
  const ScreenZero({Key? key}) : super(key: key);

  @override
  State<ScreenZero> createState() => _ScreenZeroState();
}

class _ScreenZeroState extends State<ScreenZero> {


  /// Init JsonWidgetRegistry można zrobić tutaj lub w main()
  final  navigatorKey = GlobalKey<NavigatorState>();
  final registry = JsonWidgetRegistry.instance;




  @override
  void initState() {
    super.initState();


    registry.navigatorKey = navigatorKey;

    registry.setValue('moja_zmienna', 'ALALALA');

    registry.registerFunctions({

      'simplePrintMessage': ({args, required registry}) => () {

        var message = 'This is a simple print message OK';

        if (args?.isEmpty == false) {
          for (var arg in args!) {
            message += ' $arg';
          }
        }
        // ignore: avoid_print
        debugPrint('CLICK ${args![1]}'); // czytanie tylko drugiego argumentu
        debugPrint(message);

        _onUntestablePageSelected(context, 'align');
      },
    });




    registry.registerFunctions({
    'sayHello2': ({args, required registry}) => () {

      String? aa = args?[0] ?? 'traaa';

      debugPrint('Zmiennna: ${registry.getValue('moja_zmienna')}');

/*    if (args?.isEmpty == false) {
    for (var arg in args!) {
    message += ' $arg';
    }
    }*/
    // ignore: avoid_print
    if(aa != null) debugPrint('CLICK3 $aa}'); // czytanie tylko drugiego argumentu
    },
  });









  }



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

         /* return  TextButton(
            onPressed: () {
              //_onJsonPageSelected(context, 'align');
              _onUntestablePageSelected(context, 'align');
          }, child: const Text('Elo goooo'),
          );*/

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
    String jsonStr = await rootBundle.loadString('assets/pages/column_button.json');

    return jsonStr;
  }


  // --------------------------------------------------------------------------- Pages routes
  static Future<void> _onJsonPageSelected(
      BuildContext context,
      String pageId,
      ) =>
      _onPageSelected(context, pageId, '.json');

  static Future<void> _onPageSelected(
      BuildContext context,
      String pageId,
      String extension,
      ) async {

    debugPrint('File: $pageId  $extension');

    var registry = JsonWidgetRegistry.instance.copyWith();
    var pageStr = await rootBundle.loadString(
      'assets/pages/${pageId}$extension',
    );
    var dataJson = yaon.parse(pageStr);

    // This is put in to give credit for when designs from online were used in
    // example files.  It's not actually a valid attribute to exist in the JSON
    // so it needs to be removed before we create the widget.
    dataJson.remove('_designCredit');

    var data = JsonWidgetData.fromDynamic(
      dataJson,
      registry: registry,
    );

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => FullWidgetPage(
          data: data!,
        ),
      ),
    );
  }

  // Wersja powyżej  _onJsonPageSelected używa dodatki do testów
  static Future<void> _onUntestablePageSelected(
      BuildContext context,
      String themeId,
      ) async {
    var registry = JsonWidgetRegistry.instance.copyWith();
    var pageStr = await rootBundle.loadString('assets/pages/$themeId.json');
    var dataJson = json.decode(pageStr);

    // This is put in to give credit for when designs from online were used in
    // example files.  It's not actually a valid attribute to exist in the JSON
    // so it needs to be removed before we create the widget.
    dataJson.remove('_designCredit');

    var data = JsonWidgetData.fromDynamic(
      dataJson,
      registry: registry,
    );

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UntestableFullWidgetPage(
          data: data!,
        ),
      ),
    );
  }

}
