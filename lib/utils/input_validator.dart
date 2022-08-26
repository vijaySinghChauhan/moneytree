import 'package:moneytree/utils/strings.dart';

mixin InputValidator {
  static String validateEmail(String value) {
    Pattern pattern = Strings.EMAIL_PATTERN;
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty) {
      return Strings.PLEASE_ENTER_EMAIL;
    } else if (!regex.hasMatch(value)) {
      return Strings.INVALID_EMAIL;
    }
    return null;
  }


  static String validateName(String value) {
    if (value.isEmpty)
      return Strings.PLEASE_ENTER_NAME;
    else if (value.length < 2) {
      return Strings.INVALID_NAME;
    }
    return null;
  }

  static String validateMobile(String value) {
    if (value.isEmpty)
      return Strings.PLEASE_ENTER_MOBILE;
    else if (value.length < 10) {
      return Strings.INVALID_MOBILE;
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return Strings.PLEASE_ENTER_PASSWORD;
    } else if (value.length < 8) {
      return Strings.INVALID_PASSWORD;
    }
    return null;
  }

  static String validateFirstName(value) {
    if (value.isEmpty) {
      return Strings.PLEASE_ENTER_FIRST_NAME;
    } else if (value.length < 2) {
      return Strings.INVALID_FIRST_NAME;
    }
    return null;
  }

  static String validateLastName(value) {
    if (value.isEmpty) {
      return Strings.PLEASE_ENTER_LAST_NAME;
    } else if (value.length < 2) {
      return Strings.INVALID_LAST_NAME;
    }
    return null;
  }

  static validateConfirmPassword(value, String password) {
    if (value.isEmpty) {
      return Strings.PLEASE_ENTER_CONFIRM_PASSWORD;
    } else if (value.length < 8) {
      return Strings.INVALID_CONFIRM_PASSWORD;
    } else if (value != password) {
      return Strings.PASSWORD_NOT_MATCH;
    }
  }
}
