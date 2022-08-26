import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/custom_widget/common_profile_widget.dart';
import 'package:moneytree/custom_widget/progress_view.dart';
import 'package:moneytree/data/preferences/preference_manager.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:moneytree/routes/app_pages.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:moneytree/utils/strings.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Common Variables
  ThemeData themeData;
  UserModel profileData;

  File _selectedProfilePicFile;

  @override
  void initState() {
    super.initState();
    setProfile();
  }

  void setProfile() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection(Strings.USERS)
        .doc(currentUser.uid)
        .get();

    profileData = UserModel.fromJson(data.data());
    var imagePath =
        await PreferenceManager.instance.getProfileImagePath() ?? '';
    if (imagePath != '') _selectedProfilePicFile = File(imagePath);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(IconConstant.BACKGROUND_RESIZE),
              fit: BoxFit.cover,
            ),
          ),
          child: viewProfileBody(context)),
    );
  }

  /*
  * One common widget CommonProfileWidget who having all background UI that includes BG image, back button, Profile pic and one edit icon
  * And its accept one widget that is all scrollable (scrollItems) items we need to develop
  * */
  Widget viewProfileBody(BuildContext context) {
    return profileData != null
        ? CommonProfileWidget(
            scrollItems: profileInfo(),
            imageUrl: '',
            file: _selectedProfilePicFile,
            editProfileInfoTap: () async {
              var result = await Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
              if (result != null) setProfile();
            })
        : ProgressWidget(child: Container(), isShow: true);
  }

  Widget profileInfo() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.get(25)),
        child: Column(
          children: <Widget>[
            itemRow(
                Strings.FIRST_NAME,
                profileData.first_name,
                Icon(
                  Icons.person,
                  color: ColorConstants.APP_THEME_COLOR,
                  size: SizeUtils.get(18),
                )),
            SizedBox(height: SizeUtils.get(25)),
            itemRow(
                Strings.LAST_NAME,
                profileData.last_name,
                Icon(
                  Icons.person,
                  color: ColorConstants.APP_THEME_COLOR,
                  size: SizeUtils.get(18),
                )),
            SizedBox(height: SizeUtils.get(25)),
            itemRow(
                Strings.ENTER_PHONE_NUMBER,
                profileData.mobile,
                Icon(
                  Icons.phone,
                  color: ColorConstants.APP_THEME_COLOR,
                  size: SizeUtils.get(18),
                )),
            SizedBox(height: SizeUtils.get(25)),
            itemRow(
                Strings.EMAIL_ID,
                profileData.email,
                Icon(
                  Icons.email,
                  color: ColorConstants.APP_THEME_COLOR,
                  size: SizeUtils.get(18),
                )),
          ],
        ),
      ),
    );
  }

  /*
  * Common widget for info items
  * */
  Row itemRow(String heading, String info, icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(heading, style: themeData.textTheme.caption),
              SizedBox(height: SizeUtils.get(10)),
              Text(info,
                  style: themeData.textTheme.bodyText1
                      .copyWith(color: ColorConstants.APP_THEME_COLOR)),
            ],
          ),
        ),
        icon
      ],
    );
  }
}
