import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/custom_widget/dialogs.dart';
import 'package:moneytree/custom_widget/flutter_animation_progress_bar.dart';
import 'package:moneytree/data/local/manager/chapters_table_manager.dart';
import 'package:moneytree/data/local/manager/que_table_manager.dart';
import 'package:moneytree/data/local/manager/users_table_manager.dart';
import 'package:moneytree/model/chapter_model.dart';
import 'package:moneytree/model/chapter_wise_que.dart';
import 'package:moneytree/model/que_model.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:moneytree/routes/app_pages.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/size_utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  ThemeData themeData;
  UserModel userData;
  String chapterId = '';
  int completedChapter = 0;

  @override
  void initState() {
    super.initState();
    printLoginData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('resumed');
      if (mounted) setState(() {});
    }
  }

  void printLoginData() async {
    var users = await UsersTableManager.instance
        .fetchUser(FirebaseAuth.instance.currentUser.uid);
    var result = await ChaptersTableManager.instance.fetchAllChapterResult();
    completedChapter = 0;
    if (result != null && result.isNotEmpty) {
      result.forEach((element) {
        if (element.result == '100') {
          completedChapter++;
        }
      });
    } else {
      completedChapter = 0;
    }
    userData = users.first;
    chapterId = userData.completed_chapter_id;
    print(chapterId + ' chapterId');
    ChapterQueList.resetQue();
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
            child: Column(
              children: [
                SizedBox(height: 20),
                buildCategories(),
                Container(
                  width: SizeUtils.screenWidth,
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chapters progress:',
                          style: themeData.textTheme.button
                              .copyWith(color: ColorConstants.APP_THEME_COLOR)),
                      SizedBox(height: 10),
                      FAProgressBar(
                          currentValue: completedChapter == 0
                              ? 0
                              : (((completedChapter / 10) * 100).ceil()),
                          progressColor: ColorConstants.DARK_GREEN,
                          displayText: '%',
                          size: SizeUtils.get(18),
                          backgroundColor: ColorConstants.LIGHT_GREEN),
                    ],
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategories() => Expanded(
        child: Container(
          // padding: EdgeInsets.all(5),
          // child: Column(
          //   children: [
          //     Image.asset(IconConstant.MARKETING, height: 50, width: 50),
          //     Text('Making decision', style: themeData.textTheme.caption)
          //   ],
          // ),
          child: GridView(
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            children: ChapterQueList.questionsList
                .map((que) => itemWidget(que))
                .toList(),
          ),
        ),
      );

  Widget itemWidget(ChapterModel que) {
    return InkWell(
      onTap: () {
        navigateToQuizPage(que);
      },
      child: Container(
          padding: EdgeInsets.all(3),
          child: Column(
            children: [
              Image.asset(que.icon, height: 55, width: 55),
              SizedBox(height: 6),
              Text(
                que.chapter_name,
                style:
                    themeData.textTheme.button.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }

  void navigateToQuizPage(ChapterModel que) async {
    print('Pressed data ' + que.toJson().toString());
    var userId = FirebaseAuth.instance.currentUser.uid;
    List<QueModel> qusEntList =
        await QueTableManger.instance.fetchQue(que.chapter_id, userId);
    await QueTableManger.instance.deleteQue(que.chapter_id, userId);
    await ChaptersTableManager.instance.removeChapterResult(que.chapter_id);
    if (qusEntList != null) {
      qusEntList.forEach((element) {
        print('Dashboard ===> QuestionList : ${element.toJson()}');
      });
    }
    int pressedChapterId = int.parse(que.chapter_id);
    int completedChapterId = int.parse(chapterId);
    print('$pressedChapterId , $completedChapterId');

    if (pressedChapterId == 1) {
      await Get.toNamed(Routes.QUIZ_PAGE,
          arguments: (pressedChapterId).toString());
      printLoginData();
    } else {
      var result = await ChaptersTableManager.instance.fetchChapterResult(
          (pressedChapterId - 1).toString(), userId.toString());
      print('Result ===> IsNull : ${result != null}');
      if (result != null && result.length != 0 && result[0].result == '100') {
        print(
            'Result ===> Length : ${result.length} Per : ${result[0].result}');
        await Get.toNamed(Routes.QUIZ_PAGE,
            arguments: (pressedChapterId).toString());
        printLoginData();
      } else {
        // var chapterName =
        //     ChapterQueList.getChapterName(id: (pressedChapterId).toString());
        Dialogs.showInfoDialog(
            context, 'Please complete previous chapter 100% first.');
      }
    }

    if (pressedChapterId == completedChapterId + 1) {
      await Get.toNamed(Routes.QUIZ_PAGE,
          arguments: (completedChapterId + 1).toString());
      printLoginData();
    } else {
      if (pressedChapterId > completedChapterId) {
        var chapterName = ChapterQueList.getChapterName(
            id: (completedChapterId + 1).toString());
        Dialogs.showInfoDialog(
            context, 'Please complete the $chapterName questions first.');
      } else {
        var chapterName = ChapterQueList.getChapterName(
            id: (pressedChapterId).toString());
        Dialogs.showInfoDialog(context, '$chapterName completed');
        // await Get.toNamed(Routes.QUIZ_PAGE,
        //     arguments: (9).toString());
      }
    }
  }
}
