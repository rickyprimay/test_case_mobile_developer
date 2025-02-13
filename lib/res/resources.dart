
import 'package:flutter/material.dart';
import 'package:game_list_app/res/colors/app_colors.dart';
import 'package:game_list_app/res/dimentions/app_dimensions.dart';

class Resources {

  // ignore: unused_field
  final BuildContext _context;

  Resources(this._context);

  AppColors get color {
    return AppColors();
  }

  AppDimensions get dimension {
    return AppDimensions();
  }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}