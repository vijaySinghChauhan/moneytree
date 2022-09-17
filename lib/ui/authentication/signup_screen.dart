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

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ThemeData themeData;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  //SignUp Data
  String _email = "";
  String _firstName = "";
  String _lastName = "";
  String _mobile = "";
  String _password = "";

  bool showLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return ProgressWidget(
      isShow: showLoading,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(IconConstant.BACKGROUND_RESIZE,
                  width: SizeUtils.screenWidth, fit: BoxFit.cover),
              Container(child: signUpBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeUtils.get(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils.get(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                              height: 27,
                              width: 27,
                              color: ColorConstants.LIGHT_BLACK)),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: SizeUtils.get(40)),
                  Text('Create account',
                      style: themeData.textTheme.headline6
                          .copyWith(color: ColorConstants.LIGHT_BLACK)),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldFirstName(),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldLastName(),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldMobile(),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldEmail(),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldPassword(),
                  SizedBox(height: SizeUtils.get(30)),
                  textFieldConfirmPassword(),
                  SizedBox(height: SizeUtils.get(30)),
                  signUpButton(),
                  SizedBox(height: SizeUtils.get(30)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField textFieldFirstName() {
    return InputTextFieldUtils.inputTextField(
        label: Strings.ENTER_FIRST_NAME,
        focusNode: _firstNameFocusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_lastNameFocusNode);
        },
        capsText: true,
        maxLength: 25,
        validator: (value) => InputValidator.validateFirstName(value),
        onSaved: (value) => _firstName = value,
        keyboardType: TextInputType.text);
  }

  TextFormField textFieldLastName() {
    return InputTextFieldUtils.inputTextField(
        label: Strings.ENTER_LAST_NAME,
        focusNode: _lastNameFocusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_mobileFocusNode);
        },
        capsText: true,
        maxLength: 25,
        validator: (value) => InputValidator.validateLastName(value),
        onSaved: (value) => _lastName = value,
        keyboardType: TextInputType.text);
  }

  TextFormField textFieldMobile() {
    return InputTextFieldUtils.inputTextField(
        label: Strings.ENTER_PHONE_NUMBER,
        focusNode: _mobileFocusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        capsText: true,
        maxLength: 10,
        validator: (value) => InputValidator.validateMobile(value),
        onSaved: (value) => _mobile = value,
        keyboardType: TextInputType.phone);
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
          FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
        },
        validator: (value) => InputValidator.validatePassword(value),
        onSaved: (String value) {
          _password = value;
        },
        isObscureText: true,
        keyboardType: TextInputType.text);
  }

  TextFormField textFieldConfirmPassword() {
    return InputTextFieldUtils.inputTextField(
        label: Strings.ENTER_CONFIRM_PASSWORD,
        focusNode: _confirmPasswordFocusNode,
        onFieldSubmitted: (value) {
          btnSignUpClick();
        },
        validator: (value) {
          _formKey.currentState.save();
          return InputValidator.validateConfirmPassword(value, _password);
        },
        onSaved: (String value) {},
        isTextInputActionDone: true,
        isObscureText: true,
        keyboardType: TextInputType.text);
  }

  Widget signUpButton() {
    return InkWell(
      onTap: () {
        btnSignUpClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: ColorConstants.GREEN_NEW),
        child: Text(
          Strings.SUBMIT.toUpperCase(),
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

  void btnSignUpClick() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
        setLoadingState(true);
      print('$_email, $_firstName, $_lastName, $_password');
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        if (userCredential.user != null) storeData(userCredential.user.uid);
      } on FirebaseAuthException catch (e) {
        setLoadingState(false);
        print("test-- "+e.message + ' ' + e.code);
        if (e.code == 'user-not-found') {
          Dialogs.showInfoDialog(
              context, 'The account already exists for that email.');
        } else if (e.code == 'email-already-in-use') {
          Dialogs.showInfoDialog(
              context, 'The account already exists for that email.');
        } else if (e.code == 'wrong-password') {
          Dialogs.showInfoDialog(context, 'The password provided is too weak');
        } else {
          Dialogs.showInfoDialog(context, e.message);
        }
      }
    } else {
      if (!_autoValidate) setState(() => _autoValidate = true);
    }
  }

  Future storeData(String uid) async {
    var user = UserModel(
        email: _email,
        first_name: _firstName,
        last_name: _lastName,
        mobile: _mobile,
        id: uid,
        completed_chapter_id: '0',
        completed_per: '0');

    print(user.toJson().toString() + 'ddd');
    navigationPageToDashboard();
    await FirebaseFirestore.instance
        .collection(Strings.USERS)
        .doc(uid)
        .set(user.toJson());

    PreferenceManager.instance.setIsLogin(true);
    await UsersTableManager.instance.addUser(user);

  }

  void navigationPageToDashboard() {
    setLoadingState(false);
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }

  void setLoadingState(bool isShow) {
    showLoading = isShow;
    if (mounted) setState(() {});
  }
}
