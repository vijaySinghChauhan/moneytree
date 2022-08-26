import 'package:get/get.dart';
import 'package:moneytree/utils/constants/app_constant.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/input_validator.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:moneytree/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  /// Show info dialogs with OK button
  static showInfoDialog(BuildContext context, String message,
      {Function onPressed, bool isCancelable = true}) async {
    String btnText = Strings.OK;
    String title = AppConstants.APP_NAME;

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
            onPressed: onPressed ??
                () {
                  Navigator.pop(context);
                },
            child: Text(btnText)),
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: isCancelable,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Show dialogs with three option buttons
  static showDialogWithTwoOptions(
      BuildContext context, String message, String positiveButtonText,
      {VoidCallback positiveButtonCallBack, bool isCancelable = true}) async {
    String btnText = Strings.CANCEL;
    String title = AppConstants.APP_NAME;

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
            onPressed: positiveButtonCallBack, child: Text(positiveButtonText)),
        CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(btnText)),
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: isCancelable,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Show dialogs with two option buttons
  static showDialogWithTwoOptionsAndClicks(BuildContext context, String message,
      String positiveButtonText, String negativeButtonText,
      {VoidCallback positiveButtonCallBack,
      VoidCallback negativeButtonCallBack,
      bool isCancelable = true}) async {
    String title = AppConstants.APP_NAME;

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
            onPressed: positiveButtonCallBack, child: Text(positiveButtonText)),
        CupertinoDialogAction(
            onPressed: negativeButtonCallBack, child: Text(negativeButtonText)),
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: isCancelable,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showDialogWithInputField(BuildContext context, Function onDone,
      {bool isForgotPass = false}) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController textEditingController =
        TextEditingController(text: '');
    await showDialog<String>(
      context: context, builder: (BuildContext context) =>  AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: new TextFormField(
                validator: (value) => isForgotPass ? InputValidator.validateEmail(value) : null,
                autofocus: true,
                controller: textEditingController,
                decoration: new InputDecoration(
                    hintText: isForgotPass
                        ? 'Enter your email'
                        : 'Enter your answer'),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            }),
        new FlatButton(
            child: Text(isForgotPass ? 'SEND' : 'SAVE'),
            onPressed: () {
              if (isForgotPass) {
                if(_formKey.currentState.validate()) {
                  onDone(textEditingController.text);
                  Get.back(result: textEditingController.text);
                }
              } else {
                onDone(textEditingController.text);
                Get.back(result: textEditingController.text);
              }
            })
      ],
    ),
    );
  }

  static showCustomDialog(BuildContext context, String info) async {
    var myColor = ColorConstants.APP_THEME_COLOR;
    var themeData = Theme.of(context);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Material(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.all(SizeUtils.get(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(SizeUtils.get(10)),
                              child: Container(
                                  padding: EdgeInsets.all(SizeUtils.get(10)),
                                  child: Icon(Icons.info_outline,
                                      color: myColor, size: SizeUtils.get(60))),
                            ),
                            SizedBox(height: SizeUtils.get(5)),
                            Text(
                              info,
                              style: themeData.textTheme.button.copyWith(
                                  color: ColorConstants.APP_THEME_COLOR),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: SizeUtils.get(18)),
                      width: SizeUtils.screenWidth,
                      color: myColor,
                      child: Text(
                        "OK",
                        style: themeData.textTheme.button
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
