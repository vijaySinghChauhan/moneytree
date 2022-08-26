import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

textThemeLight() {
  return TextTheme(
      headline4: TextStyle(color: ColorConstants.WHITE),
      headline6: TextStyle(color: ColorConstants.WHITE),
      bodyText1: TextStyle(
          color: ColorConstants.WHITE,
          fontSize: SizeUtils.getFontSize(18),
          fontWeight: FontWeight.w400),
      bodyText2: TextStyle(
          color: ColorConstants.WHITE,
          fontSize: SizeUtils.getFontSize(16),
          fontWeight: FontWeight.w400),
      headline5: TextStyle(
          color: ColorConstants.WHITE,
          fontWeight: FontWeight.w900,
          fontSize: SizeUtils.getFontSize(22)),
      button: new TextStyle(
          color: ColorConstants.APP_THEME_COLOR,
          fontSize: SizeUtils.getFontSize(16)));
}

class TextStyleUtils {
  static TextSpan textBoldAndUnderline(title, onTap) {
    return TextSpan(
      text: title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  static TextStyle authTitleStyle(themeData) {
    return themeData.textTheme.headline
        .copyWith(fontSize: SizeUtils.getFontSize(26), color:ColorConstants.APP_THEME_COLOR);
  }

  static TextStyle authSubTitleStyle(themeData) {
    return themeData.textTheme.subhead;
  }
}
