import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String msg;

  const ErrorWidget(this.msg, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      msg,
    ));
  }
}