import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/custom_widget/dialogs.dart';
import 'package:moneytree/data/local/manager/chapters_table_manager.dart';
import 'package:moneytree/data/local/manager/que_table_manager.dart';
import 'package:moneytree/data/local/manager/users_table_manager.dart';
import 'package:moneytree/model/chapter_wise_que.dart';
import 'package:moneytree/model/que_model.dart';
import 'package:moneytree/model/result_model.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/strings.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ThemeData themeData;
  String chapterId;
  String chapterName = '';
  String userId;
  List<QueModel> qusEntList = [];
  List<String> taskList = [];
  int correctAnsCount = 0;
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
    chapterId = Get.arguments;
    chapterName = ChapterQueList.getChapterName(id: chapterId);
    getChapterIdEntries();
  }

  void showDialogFromButton() {
    var info = '';
    if (chapterId == '1') {
      info = Strings.INFO1;
    } else if (chapterId == '2') {
      info = Strings.INFO2;
    } else if (chapterId == '3') {
      info = Strings.INFO3;
    } else if (chapterId == '4') {
      info = Strings.INFO4;
    } else if (chapterId == '5') {
      info = Strings.INFO5;
    } else if (chapterId == '6') {
      info = Strings.INFO6;
    } else if (chapterId == '7') {
      info = Strings.INFO7;
    } else if (chapterId == '8') {
      info = Strings.INFO8;
    } else if (chapterId == '9') {
      info = Strings.INFO9;
    } else if (chapterId == '10') {
      info = Strings.INFO10;
    }
    Dialogs.showCustomDialog(context, info);
  }

  void getChapterIdEntries() async {
    userId = FirebaseAuth.instance.currentUser.uid;
    var users = await UsersTableManager.instance
        .fetchUser(FirebaseAuth.instance.currentUser.uid);
    users.first.completed_chapter_id = chapterId;
    users.first.completed_per =
        ((correctAnsCount * 100) / totalCount).toString();
    print('ResultScreen ===> User : $users');
    await UsersTableManager.instance.updateUser(users.first);
    qusEntList = await QueTableManger.instance.fetchQue(chapterId, userId);
    totalCount = qusEntList.length;
    correctAnsCount =
        qusEntList.where((element) => element.result == Strings.CORRECT).length;
    taskList = ChapterQueList.getTaskFromId(id: chapterId);
    ResultModel model = ResultModel(
        chapter_id: int.parse(chapterId),
        chapter_name: chapterName,
        userId: userId,
        result: correctAnsCount == 0
            ? '0'
            : '${((correctAnsCount * 100) / totalCount).ceil()}');
    await ChaptersTableManager.instance.addChapterResult(model);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: ColorConstants.APP_THEME_COLOR,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.LIGHT_WHITE,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    }),
              ),
              SizedBox(height: 15),
              Icon(Icons.wb_incandescent,
                  color: ColorConstants.APP_THEME_COLOR, size: 75),
              SizedBox(height: 15),
              Text(
                  correctAnsCount == 0
                      ? '0% score!'
                      : '${((correctAnsCount * 100) / totalCount).ceil()}% score!',
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.headline3.copyWith(
                      color: Colors.green, fontWeight: FontWeight.w700)),
              SizedBox(height: 15),
              Text('$chapterName Quiz Completed successfully',
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorConstants.APP_THEME_COLOR)),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                    // 'Your attempt $totalCount questions and from that $correctAnsCount is correct.',
                    'You got $correctAnsCount out of $totalCount questions right.',
                    textAlign: TextAlign.center,
                    style: themeData.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w900,
                        color: ColorConstants.APP_THEME_COLOR)),
              ),
              SizedBox(height: 15),
              Text('Quiz Tasks: ',
                  style: themeData.textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorConstants.APP_THEME_COLOR)),
              SizedBox(height: 5),
              taskList.length == 0
                  ? Container()
                  : ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(taskList[index],
                              textAlign: TextAlign.center,
                              style: themeData.textTheme.button.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.APP_THEME_COLOR)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: taskList.length,
                    ),
              SizedBox(height: 10),
              Text('Submitted Answers: ',
                  style: themeData.textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorConstants.APP_THEME_COLOR)),
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var res = qusEntList[index].toJson();
                    List<String> selectedAnsValue = [];
                    List<String> rightAnsValue = [];
                    var ansArray = qusEntList[index].ans.split(',');
                    var selectedAnsArray =
                        qusEntList[index].selected_ans.split(',');
                    print('ResultScreen ===> AnsList : ${ansArray.toList()}');
                    ansArray.forEach((element) {
                      if (qusEntList[index].que_type == '5' ||
                          qusEntList[index].que_type == '3') {
                        rightAnsValue.add(element);
                      } else {
                        if (qusEntList[index].que_type == '2') {
                          var opt;
                          if (element == '1') {
                            opt = Strings.OPTION_A;
                          } else if (element == '2') {
                            opt = Strings.OPTION_B;
                          } else if (element == '3') {
                            opt = Strings.OPTION_C;
                          } else if (element == '4') {
                            opt = Strings.OPTION_D;
                          }
                          rightAnsValue.add(res[opt]);
                        } else {
                          rightAnsValue.add(res[element]);
                        }
                      }
                    });

                    selectedAnsArray.forEach((element) {
                      if (qusEntList[index].que_type == '5' ||
                          qusEntList[index].que_type == '3') {
                        selectedAnsValue.add(element);
                      } else {
                        if (qusEntList[index].que_type == '2') {
                          var opt;
                          if (element == '1') {
                            opt = Strings.OPTION_A;
                          } else if (element == '2') {
                            opt = Strings.OPTION_B;
                          } else if (element == '3') {
                            opt = Strings.OPTION_C;
                          } else if (element == '4') {
                            opt = Strings.OPTION_D;
                          }
                          selectedAnsValue.add(res[opt]);
                        } else {
                          selectedAnsValue.add(res[element]);
                        }
                      }
                    });

                    return Container(
                      margin: EdgeInsets.only(left: 5, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}) ${qusEntList[index].que} :',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.APP_THEME_COLOR),
                          ),
                          Text(
                            'ANS : ${selectedAnsValue.join(',')}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    qusEntList[index].result == Strings.CORRECT
                                        ? ColorConstants.APP_THEME_COLOR
                                        : Colors.red),
                          ),
                          qusEntList[index].result == Strings.WRONG
                              ? Text(
                                  'Right Ans : ${rightAnsValue.join(',')}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.APP_THEME_COLOR),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                  itemCount: qusEntList.length,
                ),
              ),
              TextButton(
                  onPressed: () => showDialogFromButton(),
                  child: Text(
                    'Have A Second Look',
                    style: TextStyle(color: ColorConstants.DARK_GREEN),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
