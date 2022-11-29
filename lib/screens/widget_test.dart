import 'package:flutter/material.dart';

class WidgetTest extends StatelessWidget {
  const WidgetTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
        'dasdasd2',
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
        Text(
          'dasdasd2',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
    ]);
  }
}
