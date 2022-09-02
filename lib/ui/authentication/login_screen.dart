import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/app_theme/button_theme.dart';
import 'package:moneytree/app_theme/input_decoration_theme.dart';
import 'package:moneytree/app_theme/text_theme.dart';
import 'package:moneytree/custom_widget/dialogs.dart';
import 'package:moneytree/custom_widget/progress_view.dart';
import 'package:moneytree/data/local/manager/users_table_manager.dart';
import 'package:moneytree/data/preferences/preference_manager.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:moneytree/routes/app_pages.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/input_validator.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:moneytree/utils/strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ThemeData themeData;
  bool showLoading = false;

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  //Login Data
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return ProgressWidget(
      isShow: showLoading,
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(IconConstant.LOGIN_SCREEN_RESIZE,
                width: SizeUtils.screenWidth, fit: BoxFit.cover),
            Container(
              child: loginBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode:  AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: SizeUtils.get(50)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils.get(10)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeUtils.get(20)),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Image.asset(IconConstant.D_LOGO, height: 40, width: 40),
                      Flexible(child: Container()),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(IconConstant.BACK,
                              height: 27, width: 27, color: ColorConstants.LIGHT_BLACK)),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: SizeUtils.get(40)),
                  Text('Login',
                      style: themeData.textTheme.headline6
                          .copyWith(color: ColorConstants.LIGHT_BLACK)),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldEmail(),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldPassword(),
                  SizedBox(height: SizeUtils.get(30)),
                  loginButton(),
                  SizedBox(height: SizeUtils.get(10)),
                  forgotPass()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField textFieldEmail() {
    return InputTextFieldUtils.inputTextField(
        label: Strings.ENTER_EMAIL,
        focusNode: _emailFocusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        validator: (value) => InputValidator.validateEmail(value),
        onSaved: (value) => _email = value,
        keyboardType: TextInputType.emailAddress);
  }

  TextFormField textFieldPassword() {
    return InputTextFieldUtils.inputTextField(
        label: Strings.ENTER_PASSWORD,
        focusNode: _passwordFocusNode,
        onFieldSubmitted: (value) {
          btnLoginClick();
        },
        validator: (value) => InputValidator.validatePassword(value),
        onSaved: (String value) {
          _password = value;
        },
        isTextInputActionDone: true,
        isObscureText: true,
        keyboardType: TextInputType.text);
  }

  Widget loginButton() {
    return InkWell(
      onTap: () {
        btnLoginClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: ColorConstants.GREEN_NEW),
        child: Text(
          Strings.SIGN_IN,
          style: themeData.textTheme.button
              .copyWith(color: ColorConstants.GREY_TEXT),
        ),
      ),
    );
    // return ButtonUtils.btnFillGreen(
    //     title: Strings.SIGN_IN,
    //     onTap: () {
    //       btnLoginClick();
    //     });
  }

  Widget forgotPass() {
    return InkWell(
      onTap: () {
        Dialogs.showDialogWithInputField(context, (value) {
          print(value);
          FirebaseAuth.instance.sendPasswordResetEmail(email: value);
        }, isForgotPass: true);
      },
      child: Text(
        Strings.FORGOT_PASSWORD,
        style: themeData.textTheme.button
            .copyWith(color: ColorConstants.LIGHT_BLACK),
      ),
    );
    // return ButtonUtils.btnFillGreen(
    //     title: Strings.SIGN_IN,
    //     onTap: () {
    //       btnLoginClick();
    //     });
  }

  void btnLoginClick() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_email, $_password');
      try {
        setLoadingState(true);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        if (userCredential.user != null) {
          storeData(userCredential.user.uid);

          navigationPageToDashboard();

        }

      } on FirebaseAuthException catch (e) {
        setLoadingState(false);
        print('vijayE---,$e');
        if (e.code == 'user-not-found') {
          Dialogs.showInfoDialog(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Dialogs.showInfoDialog(
              context, 'Wrong password provided for that user.');
        } else {
          Dialogs.showInfoDialog(context, e.message);
        }
      }
    } else {
      if (!_autoValidate) setState(() => _autoValidate = true);
    }
  }

  Future<void> storeData(String uid) async {

    print( 'test--uid,$uid');
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection(Strings.USERS)
        .doc(uid)
        .get();
    print( 'test--data,$data');
    UserModel userData = UserModel.fromJson(data.data());
    PreferenceManager.instance.setIsLogin(true);

    await UsersTableManager.instance.addUser(userData);

  }

  Future<void> getUserNameFromUID(String uid) async {
    print( 'test--data,$uid');
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    print( 'test--data,$snapshot.docs.first');
  }

  void navigationPageToDashboard() {
    setLoadingState(false);
    Get.offAllNamed(Routes.MAIN_SCREEN);
  }

  void setLoadingState(bool isShow) {
    showLoading = isShow;
    if (mounted) setState(() {});
  }
}
