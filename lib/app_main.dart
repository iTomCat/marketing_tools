import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marketing_tools/splash_screen.dart';
import 'package:marketing_tools/tabs_menu.dart';



final navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl', 'PL'),
      ],
      title: 'CoduCode',

      theme: //FogeesTheme.light,
      // Dodać plik z Theme
      ThemeData(
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
      //darkTheme: FogeesTheme.dark,
      //home: const SplashScreen(),
      home: const TabsMenu(),
      //home: const TabsMenu(),
      routes: {
        //TabsMenu.route: (ctx) =>  const TabsMenu(),
      },
    );
  }

}
