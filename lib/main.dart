import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

import 'app_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await bootstrap();

  runApp(const MyApp());
  //runApp(const MainApp());
}

Future<void> bootstrap() async {

  WidgetsFlutterBinding.ensureInitialized(); //Trzeba dodać pomimo że w opisie FlutterFirebase nie piszą

  /*var navigatorKey = GlobalKey<NavigatorState>();

  var registry = JsonWidgetRegistry.instance;
  registry.navigatorKey = navigatorKey;


  registry.registerFunctions({

    'simplePrintMessage': ({args, required registry}) => () {
      var message = 'This is a simple print message OK';
      if (args?.isEmpty == false) {
        for (var arg in args!) {
          message += ' $arg';
        }
      }
      // ignore: avoid_print
      debugPrint(message);
    },


  });*/







  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainApp(),
    );
  }

}
