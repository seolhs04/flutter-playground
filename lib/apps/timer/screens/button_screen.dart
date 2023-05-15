import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/baloon_model.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  final List<Balloon> _balloons = [];
  late Timer _timer;
  double wind = 0.1;
  double speed = 0.1;

  _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        for (final balloon in _balloons) {
          balloon.x += wind * balloon.windDirection;
          balloon.y += wind * balloon.windDirection;
        }
      });
    });
  }

  @override
  void initState() {
    _startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomPaint(
        painter: BalloonPainter(_balloons),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () {
                Balloon newBalloon = Balloon(
                  x: Random().nextDouble() * width,
                  y: Random().nextDouble() * height,
                  color: Colors
                      .primaries[_balloons.length % Colors.primaries.length],
                  windDirection: Random().nextBool() ? -1 : 1,
                );

                setState(() {
                  _balloons.add(newBalloon);
                });
              },
              icon: const Icon(Icons.add_box_outlined),
            )
          ],
        ),
      ),
    );
  }
}

class BalloonPainter extends CustomPainter {
  final List<Balloon> _balloons;
  BalloonPainter(this._balloons);

  @override
  void paint(Canvas canvas, Size size) {
    for (final balloon in _balloons) {
      final paint = Paint()..color = balloon.color;

      final threadPaint = Paint()..color = Colors.grey;

      canvas.drawLine(
        Offset(balloon.x, balloon.y),
        Offset(balloon.x, balloon.y + 100),
        threadPaint,
      );

      canvas.drawCircle(
        Offset(balloon.x, balloon.y),
        50,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
