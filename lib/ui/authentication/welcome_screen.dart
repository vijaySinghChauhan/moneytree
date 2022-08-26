import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/app_theme/button_theme.dart';
import 'package:moneytree/routes/app_pages.dart';

import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:moneytree/utils/strings.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: welcomeBody());
  }

  Widget welcomeBody() {
    return Stack(
      children: [
        Image.asset(IconConstant.BACKGROUND_RESIZE, width: SizeUtils.screenWidth, fit: BoxFit.cover),
        Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(IconConstant.BACKGROUND_MIN),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(65),
                          padding: EdgeInsets.all(25),
                          child: Image.asset(IconConstant.DUPPY_FULLLOGO)),
                    ],
                  )),
              Expanded(flex: 3, child: buttons())
            ],
          ),
        ),
      ],
    );
  }

  Widget buttons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils.get(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ButtonUtils.borderButtons(
              Strings.CREATE_ACCOUNT, () => this.navigationPageToSignup()),
          SizedBox(height: SizeUtils.get(20)),
          ButtonUtils.borderButtons(
              Strings.LOG_IN, () => this.navigationPageToLogin()),
        ],
      ),
    );
  }

  void navigationPageToSignup() {
    Get.toNamed(Routes.SIGNUP_PAGE);
  }

  void navigationPageToLogin() {
    Get.toNamed(Routes.LOGIN_PAGE);
  }
}
