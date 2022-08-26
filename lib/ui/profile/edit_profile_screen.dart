import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/custom_widget/common_profile_widget.dart';
import 'package:moneytree/custom_widget/progress_view.dart';
import 'package:moneytree/data/preferences/preference_manager.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:moneytree/utils/common_utils.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/input_validator.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:moneytree/utils/strings.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfileScreen> {
  //Common Variables
  ThemeData themeData;
  bool showLoading = false;

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  //Login Data
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _mobile = '';

  UserModel profileData;
  File _selectedProfilePicFile;

  @override
  void initState() {
    super.initState();
    setProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _mobileFocusNode.dispose();

    _emailFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
  }

  /*
  * Setting profile data into form after reading data locally from pref
  * */

  void setProfile() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection(Strings.USERS)
        .doc(currentUser.uid)
        .get();

    profileData = UserModel.fromJson(data.data());
    print('data:: ${profileData.toJson()}');
    _email = profileData.email;
    _emailController.text = _email;

    _firstName = profileData.first_name;
    _firstNameController.text = _firstName;
    _lastName = profileData.last_name;
    _lastNameController.text = _lastName;
    _mobile = profileData.mobile;
    _mobileController.text = _mobile;

    var imagePath =
        await PreferenceManager.instance.getProfileImagePath() ?? '';
    if (imagePath != '') _selectedProfilePicFile = File(imagePath);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
        body: SafeArea(
      child:
          ProgressWidget(isShow: showLoading, child: editProfileBody(context)),
    ));
  }

  /*
  * One common widget CommonProfileWidget who having all background UI that includes BG image, back button, Profile pic and a edit icon on profile pic
  * And its accept one widget that is all scrollable items we need to develop
  * */
  Widget editProfileBody(BuildContext context) {
    return profileData != null
        ? CommonProfileWidget(
            backEnable: true,
            scrollItems: profileInfo(),
            onEditImageTap: () => selectImage(),
            file: _selectedProfilePicFile,
          )
        : Container();
  }

  Widget profileInfo() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.get(15)),
        child: Form(
          autovalidate: _autoValidate,
          key: _formKey,
          child: formColumn(),
        ),
      ),
    );
  }

  Column formColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: SizeUtils.get(10)),
        textFormFieldContainer(
            _firstNameFocusNode, _firstNameController, Strings.ENTER_FIRST_NAME,
            validator: (value) {
              return InputValidator.validateName(value);
            },
            keyboardType: TextInputType.text,
            onSave: (value) => _firstName = value,
            prefix: Icon(Icons.person)),
        SizedBox(height: SizeUtils.get(25)),
        textFormFieldContainer(
            _lastNameFocusNode, _lastNameController, Strings.ENTER_LAST_NAME,
            validator: (value) {
              return InputValidator.validateName(value);
            },
            keyboardType: TextInputType.text,
            onSave: (value) => _lastName = value,
            prefix: Icon(Icons.person)),
        SizedBox(height: SizeUtils.get(25)),
        textFormFieldContainer(
            _mobileFocusNode, _mobileController, Strings.ENTER_PHONE_NUMBER,
            validator: (value) {
              return InputValidator.validateMobile(value);
            },
            keyboardType: TextInputType.phone,
            onSave: (value) => _mobile = value,
            prefix: Icon(Icons.person)),
        SizedBox(height: SizeUtils.get(25)),
        textFormFieldContainer(
            _emailFocusNode, _emailController, Strings.ENTER_EMAIL,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => InputValidator.validateEmail(value),
            onSave: (value) => _email = value,
            enable: false,
            prefix: Icon(Icons.email)),
        SizedBox(height: SizeUtils.get(25)),
        saveButton(),
        SizedBox(height: SizeUtils.get(25)),
      ],
    );
  }

  Widget saveButton() {
    return RaisedButton(
      child: Text(Strings.SAVE, textAlign: TextAlign.center),
      onPressed: () {
        btnSaveClick();
      },
    );
  }

  void btnSaveClick() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setLoadingState(true);
      if (_selectedProfilePicFile != null)
        PreferenceManager.instance
            .setProfileImagePath(_selectedProfilePicFile.path);
      var updatedData = UserModel(
          first_name: _firstName,
          last_name: _lastName,
          email: _email,
          mobile: _mobile,
          id: profileData.id);
      await FirebaseFirestore.instance
          .collection(Strings.USERS)
          .doc(profileData.id)
          .update(updatedData.toJson());
      setLoadingState(false);

      Get.back(result: true);
      // WebServices(context, this).callUpdateProfileAPI(_username, _mobileNumber,
      //     _email, _country, _prefixDialing, _selectedProfilePicFile);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  /*
  * Bottom dialog for image selection option
  * */
  void selectImage() {
    final act = CupertinoActionSheet(
        title: Text(Strings.IMAGE_PICK_TEXT),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(Strings.OPTION_CAMERA),
            onPressed: () {
              Navigator.pop(context);
              checkCameraPermission();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(Strings.OPTION_GALLERY),
            onPressed: () {
              Navigator.pop(context);
              selectImageFromGallery();
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(Strings.CANCEL),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
    showCupertinoModalPopup(
        context: context, builder: (BuildContext context) => act);
  }

  void selectImageFromGallery() async {
    var selectedImage = await CommonUtils.selectImageFromGalleryWithCompress();
    setState(() {
      _selectedProfilePicFile = selectedImage;
    });
  }

  /*
  * Checking camera permission if it is granted then open the camera or else it will ask the permistion
  * */
  void checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      selectImageFromCamera();
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        selectImageFromCamera();
      }
    }
  }

  void selectImageFromCamera() async {
    var selectedImage =
        await CommonUtils.selectImageFromCameraWithCompress(context);
    setState(() {
      _selectedProfilePicFile = selectedImage;
    });
  }

  /*
  * Common textFormField with common decoration
  * */
  TextFormField textFormFieldContainer(FocusNode focusNode,
      TextEditingController textEditingController, String hint,
      {Function validator,
      Function onSave,
      prefix,
      keyboardType,
      enable = true,
      maxLength}) {
    return TextFormField(
      validator: validator,
      enabled: enable,
      cursorColor: ColorConstants.APP_THEME_COLOR,
      controller: textEditingController,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
          counter: SizedBox(), prefixIcon: prefix, hintText: hint),
      onSaved: onSave,
      style: themeData.textTheme.button,
    );
  }

  void setLoadingState(bool isShow) {
    setState(() {
      this.showLoading = isShow;
    });
  }
}
