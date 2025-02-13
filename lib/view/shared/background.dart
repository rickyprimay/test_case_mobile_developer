import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.blueGrey[800],
          ),
        ),
        Align(
          alignment: const Alignment(1.2, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey[400],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(-1.2, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey[500],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, -1.2),
          child: Container(
            height: 300,
            width: 600,
            decoration: BoxDecoration(color: Colors.blueGrey[600]),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}