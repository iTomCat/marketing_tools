import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
          child: Text('Elooooooo',

              style: TextStyle(fontSize: 20, color: Colors.blue)),
        ),
      ),

    );


  }
}
