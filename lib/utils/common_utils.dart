import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'constants/color_constant.dart';

class CommonUtils {
  static final _picker = ImagePicker();
  static void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static closeKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Gradient commonGradient() {
    return LinearGradient(
      colors: [Colors.green[200], ColorConstants.APP_THEME_COLOR],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );
  }

  static Future<File> selectImageFromCameraWithCompress(context) async {
    closeKeyboard(context);
    var selectedImage = await _picker.getImage(source: ImageSource.camera);

    File compressedFile = File(selectedImage.path);
    return compressedFile;
  }

  static Future<File> selectImageFromGalleryWithCompress() async {
    var selectedImage =
    await _picker.getImage(source: ImageSource.gallery);

    File compressedFile = File(selectedImage.path);
    return compressedFile;
  }
}