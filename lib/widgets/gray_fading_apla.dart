import 'package:flutter/material.dart';

class GrayFadingApla extends StatefulWidget {
  const GrayFadingApla({super.key});

  @override
  _GrayFadingAplaState createState() => _GrayFadingAplaState();
}

class _GrayFadingAplaState extends State<GrayFadingApla> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..repeat(reverse: true);

    _color = ColorTween(begin: Colors.grey[400], end: Colors.grey[500]).animate(_controller);
    //_color = ColorTween(begin: Colors.blue, end: Colors.amber).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
          animation: _color,
          builder: (BuildContext _, Widget? __) {
            return Container(
              color: _color.value,
            );
          },
        );
  }
}