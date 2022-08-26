import 'package:moneytree/app_theme/button_theme.dart';
import 'package:moneytree/app_theme/text_theme.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/font_constant.dart';
import 'package:flutter/material.dart';

import 'input_decoration_theme.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: FontConstants.BARLOW,
    primaryColor: ColorConstants.APP_THEME_COLOR,
    buttonColor: ColorConstants.APP_THEME_COLOR,
    accentColor: ColorConstants.APP_THEME_COLOR,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: buttonThemeLight(),
    textTheme: textThemeLight(),
    inputDecorationTheme: inputDecorationThemeLight(),
  );
}