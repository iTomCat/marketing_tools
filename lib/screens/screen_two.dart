import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  /// Tego nie używamy
  /// Obsługa Widgetu dynamic_widget dynamic_widget: ^4.0.5
  /// https://pub.dev/packages/dynamic_widget

  var containerJson = '''
{
  "type": "Container",
  "color": "#F2545B",
  "alignment": "center",
  "child": {
    "type": "Text",
    "data": "Waiting..",
    "maxLines": 3,
    "overflow": "ellipsis",
    "style": {
      "color": "#000000",
      "fontSize": 25.0
    }
  }
}
''';


  @override
  void initState() {
    super.initState();


    //var response=await http.Client().get(Uri.parse(widget.url));

    http.get(Uri.parse('http://musthave.agency/files/pancakes/elo.json')).then(
            (doc) {



          setState(() {
            containerJson = doc.body;

            debugPrint('eeeeee ${doc.body}');

          });

        });



  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _buildWidget(context),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        return snapshot.hasData
            ? SizedBox.expand(
          child: snapshot.data,
        )
            : const Center(child: Text("Loading..."));
      },
    );



    /*Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 300,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffffffff)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Text('elllo'),

          ),
        ),
      );*/
  }


/*  Future<Widget> _buildWidget(BuildContext context) async {
    return DynamicWidgetBuilder.build(containerJson, context, new DefaultClickListener())!;
  }*/

  Future<Widget> _buildWidget(BuildContext context) async {
    return DynamicWidgetBuilder.build(containerJson, context, DefaultClickListener())!;
    //return DynamicWidgetBuilder.build(containerJson, null)!;
  }
}

class DefaultClickListener implements ClickListener{
  @override
  void onClicked(String? event) {
    debugPrint("Receive click event: $event" );
  }

}
