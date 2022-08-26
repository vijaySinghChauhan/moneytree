import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneytree/custom_widget/flutter_animation_progress_bar.dart';
import 'package:moneytree/data/preferences/preference_manager.dart';
import 'package:moneytree/model/task_model.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:moneytree/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeData themeData;
  UserModel userData;
  bool isFirstCompleted = false;
  bool isFirstLocked = false;
  bool isSecCompleted = false;
  bool isSecLocked = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    print('HomeScreen ===> onDispose');
    if (isFirstCompleted) {
      TaskModel model =
          TaskModel(isLocked: '1', taskId: '1', uId: "${userData.id}");
      String task = jsonEncode(model);
      PreferenceManager.instance
          .setTask(id: ("${userData.id}" + "1"), task: task);
    }

    if (isSecCompleted) {
      TaskModel model =
          TaskModel(isLocked: '1', taskId: '2', uId: "${userData.id}");
      String task = jsonEncode(model);
      PreferenceManager.instance
          .setTask(id: ("${userData.id}" + "2"), task: task);
    }
  }

  void loadData() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection(Strings.USERS)
        .doc(currentUser.uid)
        .get();
    userData = UserModel.fromJson(data.data());

    String task1 = await PreferenceManager.instance
        .getTask(id: ("${userData.id}" + "1"));

    String task2 = await PreferenceManager.instance
        .getTask(id: ("${userData.id}" + "2"));

    print('HomeScreen ===> UserID : ${jsonEncode(userData)}');

    if (task1 != "") {
      TaskModel taskModel = TaskModel.fromJson(jsonDecode(task1));

      if (taskModel.isLocked == "1") {
        isFirstCompleted = true;
        isFirstLocked = true;
      }
    }

    if (task2 != "") {
      TaskModel taskModel = TaskModel.fromJson(jsonDecode(task2));

      if (taskModel.isLocked == "1") {
        isSecCompleted = true;
        isSecLocked = true;
      }
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(IconConstant.BACKGROUND_RESIZE,
            width: SizeUtils.screenWidth, fit: BoxFit.cover),
        Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: Container(
                    width: SizeUtils.screenWidth,
                    padding: EdgeInsets.all(16),
                    child: buildWelcome(userData == null
                        ? ''
                        : userData.first_name + ' ' + userData.last_name),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text('Task for the day:',
                              style: themeData.textTheme.headline6.copyWith(
                                  color: ColorConstants.APP_THEME_COLOR,
                                  fontWeight: FontWeight.w900)),
                        ),
                        SizedBox(height: 15),
                        itemRow('Create a LinkedIn Account',
                            isCompleted: isFirstCompleted,
                            isLocked: isFirstLocked,
                            onTap: () => setState(
                                () => isFirstCompleted = !isFirstCompleted)),
                        SizedBox(height: 10),
                        itemRow(
                            'Apply for a debit and credit card use the credit card on small purchase to help build up your credit score.',
                            isCompleted: isSecCompleted,
                            isLocked: isSecLocked,
                            onTap: () => setState(
                                () => isSecCompleted = !isSecCompleted)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text('Progress:',
                      textAlign: TextAlign.start,
                      style: themeData.textTheme.headline6.copyWith(
                          color: ColorConstants.APP_THEME_COLOR,
                          fontWeight: FontWeight.w900)),
                ),
                SizedBox(height: 12),
                Container(
                  width: SizeUtils.screenWidth,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text('50% Daily practice completed',
                          style: themeData.textTheme.headline6
                              .copyWith(color: ColorConstants.APP_THEME_COLOR)),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FAProgressBar(
                            currentValue: getCurrentValue(),
                            progressColor: ColorConstants.DARK_GREEN,
                            displayText: '%',
                            size: SizeUtils.get(18),
                            backgroundColor: ColorConstants.LIGHT_GREEN),
                      ),
                      // Text('2.5 more minutes remain',
                      //     style: themeData.textTheme.headline6.copyWith(
                      //         color: ColorConstants.APP_THEME_COLOR,
                      //         fontSize: SizeUtils.getFontSize(16))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget itemRow(String taskText,
      {bool isCompleted = false, onTap, bool isLocked = false}) {
    return InkWell(
      onTap: isLocked ? null : onTap,
      child: Container(
        width: SizeUtils.screenWidth,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          isCompleted
              ? Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.APP_THEME_COLOR),
                  child: Icon(
                    Icons.done,
                    size: 15,
                    color: ColorConstants.WHITE,
                  ))
              : Container(
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: ColorConstants.APP_THEME_COLOR),
                      color: ColorConstants.WHITE),
                  width: 18,
                  height: 18,
                ),
          SizedBox(width: 8),
          Flexible(
            child: Text(taskText,
                style: themeData.textTheme.button
                    .copyWith(color: ColorConstants.APP_THEME_COLOR)),
          )
        ]),
      ),
    );
  }

  Widget buildWelcome(String username) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome back!!',
              style: TextStyle(
                  fontSize: 16, color: ColorConstants.APP_THEME_COLOR)),
          SizedBox(height: SizeUtils.get(6)),
          Text(
            username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorConstants.APP_THEME_COLOR,
            ),
          )
        ],
      );

  int getCurrentValue() {
    if (isFirstCompleted && isSecCompleted) {
      return 100;
    } else if (isFirstCompleted && !isSecCompleted) {
      return 50;
    } else if (!isFirstCompleted && isSecCompleted) {
      return 50;
    } else {
      return 0;
    }
  }
}
