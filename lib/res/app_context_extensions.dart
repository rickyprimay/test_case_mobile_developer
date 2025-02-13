import 'package:flutter/material.dart';
import 'package:game_list_app/res/resources.dart';

extension AppContextExtension on BuildContext {
  Resources get resources => Resources.of(this);
}