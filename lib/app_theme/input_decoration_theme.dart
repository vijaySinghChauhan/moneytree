import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';

inputDecorationThemeLight() {
  return InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(40)
      ));
}

class InputTextFieldUtils {
  static TextFormField inputTextField(
      {label,
        FocusNode focusNode,
        onFieldSubmitted,
        validator,
        onSaved,
        keyboardType,
        bool isTextInputActionDone = false,
        bool isObscureText = false,
        controller,
        maxLength,
        capsText = false,
        enabled}) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      textCapitalization:
      capsText ? TextCapitalization.words : TextCapitalization.none,
      obscureText: isObscureText,
      validator: (value) => validator(value),
      focusNode: focusNode,
      maxLength: maxLength,
      keyboardType: keyboardType,
      cursorColor: ColorConstants.APP_THEME_COLOR,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction:
      isTextInputActionDone ? TextInputAction.done : TextInputAction.next,
      onSaved: (value) {
        onSaved(value);
      },
      decoration: InputDecoration(
          hintText: label,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          labelStyle: TextStyle(
              color: focusNode.hasFocus
                  ? ColorConstants.APP_THEME_COLOR
                  : ColorConstants.TEXT_GREY),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(40)
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(40)
          ),
          counterText: ''),
    );
  }
}