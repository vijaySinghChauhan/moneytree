import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:moneytree/utils/size_utils.dart';

buttonThemeLight() {
  return ButtonThemeData(
      padding: const EdgeInsets.all(15.0),
      textTheme: ButtonTextTheme.primary,
      buttonColor: ColorConstants.APP_THEME_COLOR,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)));
}

class ButtonUtils {
  static Widget btnFillWhite(String title, onTap) {
    return RaisedButton(
      child: Text(title.toUpperCase()),
      onPressed: onTap,
      textColor: ColorConstants.APP_THEME_COLOR,
      color: Colors.white,
    );
  }

  static Widget borderButtons(String title, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: SizeUtils.screenWidth,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black38, width: 1),
          color: Colors.white,
        ),
        child: Text(title, style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
      ),
    );
  }

  /*static Widget btnBorderWhite(String title, onTap) {
    return OutlineButton(
      child: Text(title.toUpperCase()),
      onPressed: onTap,
      textColor: Colors.white,
      borderSide: BorderSide(color: Colors.white),
      highlightedBorderColor: Colors.white30,
    );
  }*/

  static Widget btnFillGreen({String title, onTap, bool removeRadius = false, color = ColorConstants.APP_THEME_COLOR}) {
    return RaisedButton(
      child: Text(title.toUpperCase(), textAlign: TextAlign.center),
      onPressed: onTap,
      textColor: Colors.white,
      color: color,
      shape: removeRadius
          ? RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0))
          : RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0)),
    );
  }
}