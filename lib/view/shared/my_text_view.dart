

import 'package:flutter/material.dart';
import 'package:game_list_app/res/app_context_extensions.dart';

class MyTextView extends StatelessWidget {
  final String label;
  final Color color;
  final double fontSize;

  const MyTextView({super.key, this.label = "", this.color = Colors.black54, this.fontSize = 0});

  @override
  Widget build(BuildContext context) {
    double fSize = fontSize;
    if (fSize == 0) {
      fSize = context.resources.dimension.bigText;
    }
    return Text(
      label,
      style: TextStyle(color: color, fontSize: fSize),
    );
  }
}