import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/app_theme/button_theme.dart';
import 'package:moneytree/custom_widget/dialogs.dart';
import 'package:moneytree/custom_widget/flutter_animation_progress_bar.dart';
import 'package:moneytree/data/local/manager/que_table_manager.dart';
import 'package:moneytree/model/chapter_wise_que.dart';
import 'package:moneytree/model/que_model.dart';
import 'package:moneytree/routes/app_pages.dart';
import 'package:moneytree/utils/common_utils.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/size_utils.dart';
import 'package:moneytree/utils/strings.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  ThemeData themeData;
  int queCount = 0;
  int currentQue = 1;
  int progress = 0;
  bool dialogShown = false;

  List<QueModel> chapterQueList = [];
  int correctAnswersCount = 0;
  bool disableClick = false;
  String clickedOption = '';
  var title = '';
  final _scrollController = ScrollController();

  String _groupValue = '';
  String selectedOption = '';
  List<String> multipleSelectedOption = [];
  int seriesValue = 0;
  List<String> seriesValueList = [];
  String blankValue = '';

  String chapterId = '';

  String blank1Ans;
  String blank2Ans;
  String blank3Ans;

  TextEditingController blank1 = new TextEditingController();
  TextEditingController blank2 = new TextEditingController();
  TextEditingController blank3 = new TextEditingController();

  @override
  void initState() {
    super.initState();
    chapterId = Get.arguments;
    print(chapterId + 'ssss');
    chapterQueList = ChapterQueList.getQuestions(id: chapterId);
    chapterQueList.shuffle();
    // queList.forEach((que) {
    //   var random = Random();
    //   var n1 = random.nextInt(queList.length);
    //   var n2 = random.nextInt(queList.length - 1);
    //   if (n2 >= n1) n2 += 1;
    //   var element = queList[n2];
    //   chapterQueList.add(element);
    // });
    // chapterQueList = ChapterQueList.getQuestions(id: chapterId);
    title = ChapterQueList.getChapterName(id: chapterId);
    init();
  }

  void init() {
    queCount = chapterQueList.length;
    setState(() {});
    Timer(Duration(milliseconds: 500), showDialog);
  }

  void showDialog() {
    if (!dialogShown) {
      dialogShown = true;
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // void init(String file) async {
  //   String data =
  //       await DefaultAssetBundle.of(context).loadString(file, cache: false);
  //   var chapterData = jsonDecode(data);
  //
  //   queList = chapterData[0];
  //   optList = chapterData[1];
  //   ansList = chapterData[2];
  //
  //   queCount = queList.length;
  //   print(optList);
  //   setState(() {});
  //   Dialogs.showCustomDialog(context, info1);
  // }

  void previousQue() {
    currentQue -= 1;
    setState(() {});
  }

  void nextQue(String option, bool isTrue) {
    if (isTrue) correctAnswersCount++;
    disableClick = true;
    clickedOption = option;
    setState(() {});
    enableClick();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: CommonUtils.commonGradient(),
          ),
        ),
        actions: [
          InkWell(
            onTap: () => showDialogFromButton(),
            child: Container(
                padding: EdgeInsets.all(4),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.green,
                )),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(IconConstant.BACKGROUND_RESIZE,
                width: SizeUtils.screenWidth, fit: BoxFit.cover),
            chapterQueList.isEmpty
                ? Container()
                : chapterQueList.length == progress
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: SizeUtils.get(15)),
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
                                Text('Question: $currentQue/$queCount',
                                    style: themeData.textTheme.button.copyWith(
                                        color: ColorConstants.APP_THEME_COLOR)),
                                SizedBox(height: 10),
                                FAProgressBar(
                                    currentValue:
                                        (((progress / queCount) * 100).floor()),
                                    progressColor: ColorConstants.DARK_GREEN,
                                    displayText: '%',
                                    size: SizeUtils.get(18),
                                    backgroundColor:
                                        ColorConstants.LIGHT_GREEN),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeUtils.get(15)),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(SizeUtils.get(15)),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(chapterQueList[progress].que,
                                      style: themeData.textTheme.bodyText1
                                          .copyWith(
                                              color: ColorConstants
                                                  .APP_THEME_COLOR,
                                              fontWeight: FontWeight.w600)),
                                  SizedBox(height: SizeUtils.get(35)),
                                  Expanded(
                                    child: Scrollbar(
                                      controller: _scrollController,
                                      isAlwaysShown: true,
                                      child: SingleChildScrollView(
                                        controller: _scrollController,
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            optionContainer(
                                                'A',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_a,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_A,
                                                optionValue: Strings.OPTION_A,
                                                rank: chapterQueList[progress]
                                                    .rank_a, seriesRankTap: () {
                                              if (chapterQueList[progress]
                                                      .rank_a ==
                                                  '') {
                                                seriesValueList.add(
                                                    (seriesValueList.length + 1)
                                                        .toString());
                                                chapterQueList[progress]
                                                        .rank_a =
                                                    seriesValueList[
                                                        seriesValueList.length -
                                                            1];
                                              } else {
                                                checkRemove(
                                                    chapterQueList[progress]
                                                        .rank_a);
                                              }
                                              setState(() {});
                                            }),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'B',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_b,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_B,
                                                optionValue: Strings.OPTION_B,
                                                rank: chapterQueList[progress]
                                                    .rank_b, seriesRankTap: () {
                                              if (chapterQueList[progress]
                                                      .rank_b ==
                                                  '') {
                                                seriesValueList.add(
                                                    (seriesValueList.length + 1)
                                                        .toString());
                                                chapterQueList[progress]
                                                        .rank_b =
                                                    seriesValueList[
                                                        seriesValueList.length -
                                                            1];
                                              } else {
                                                checkRemove(
                                                    chapterQueList[progress]
                                                        .rank_b);
                                              }
                                              setState(() {});
                                            }),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'C',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_c,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_C,
                                                optionValue: Strings.OPTION_C,
                                                rank: chapterQueList[progress]
                                                    .rank_c, seriesRankTap: () {
                                              if (chapterQueList[progress]
                                                      .rank_c ==
                                                  '') {
                                                seriesValueList.add(
                                                    (seriesValueList.length + 1)
                                                        .toString());
                                                chapterQueList[progress]
                                                        .rank_c =
                                                    seriesValueList[
                                                        seriesValueList.length -
                                                            1];
                                              } else {
                                                checkRemove(
                                                    chapterQueList[progress]
                                                        .rank_c);
                                              }
                                              setState(() {});
                                            }),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'D',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_d,
                                                rank: chapterQueList[progress]
                                                    .rank_d,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_D,
                                                optionValue: Strings.OPTION_D,
                                                seriesRankTap: () {
                                              if (chapterQueList[progress]
                                                      .rank_d ==
                                                  '') {
                                                seriesValueList.add(
                                                    (seriesValueList.length + 1)
                                                        .toString());
                                                chapterQueList[progress]
                                                        .rank_d =
                                                    seriesValueList[
                                                        seriesValueList.length -
                                                            1];
                                              } else {
                                                checkRemove(
                                                    chapterQueList[progress]
                                                        .rank_d);
                                              }
                                              setState(() {});
                                            }),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'E',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_e,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_E,
                                                optionValue: Strings.OPTION_E),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'F',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_f,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_F,
                                                optionValue: Strings.OPTION_F),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'G',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_g,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_G,
                                                optionValue: Strings.OPTION_G),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'H',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_h,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_H,
                                                optionValue: Strings.OPTION_H),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'I',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_i,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_I,
                                                optionValue: Strings.OPTION_I),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'J',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_j,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_J,
                                                optionValue: Strings.OPTION_J),
                                            SizedBox(height: SizeUtils.get(15)),
                                            optionContainer(
                                                'K',
                                                chapterQueList[progress],
                                                chapterQueList[progress]
                                                    .option_k,
                                                ans: chapterQueList[progress]
                                                        .ans ==
                                                    Strings.OPTION_K,
                                                optionValue: Strings.OPTION_K),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(15),
                              child: submitButton())
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  void checkRemove(String rank) {
    if (rank == '1') {
      chapterQueList[progress].rank_a = '';
      chapterQueList[progress].rank_b = '';
      chapterQueList[progress].rank_c = '';
      chapterQueList[progress].rank_d = '';
      seriesValueList.clear();
    } else if (rank == '2') {
      seriesValueList.remove('2');
      seriesValueList.remove('3');
      seriesValueList.remove('4');
      var rankA = chapterQueList[progress].rank_a;
      if (rankA == '2' || rankA == '3' || rankA == '4') {
        chapterQueList[progress].rank_a = '';
      }

      var rankB = chapterQueList[progress].rank_b;
      if (rankB == '2' || rankB == '3' || rankB == '4') {
        chapterQueList[progress].rank_b = '';
      }

      var rankC = chapterQueList[progress].rank_c;
      if (rankC == '2' || rankC == '3' || rankC == '4') {
        chapterQueList[progress].rank_c = '';
      }

      var rankD = chapterQueList[progress].rank_d;
      if (rankD == '2' || rankD == '3' || rankD == '4') {
        chapterQueList[progress].rank_d = '';
      }
    } else if (rank == '3') {
      seriesValueList.remove('3');
      seriesValueList.remove('4');
      var rankA = chapterQueList[progress].rank_a;
      if (rankA == '3' || rankA == '4') {
        chapterQueList[progress].rank_a = '';
      }

      var rankB = chapterQueList[progress].rank_b;
      if (rankB == '3' || rankB == '4') {
        chapterQueList[progress].rank_b = '';
      }

      var rankC = chapterQueList[progress].rank_c;
      if (rankC == '3' || rankC == '4') {
        chapterQueList[progress].rank_c = '';
      }

      var rankD = chapterQueList[progress].rank_d;
      if (rankD == '3' || rankD == '4') {
        chapterQueList[progress].rank_d = '';
      }
    } else if (rank == '4') {
      seriesValueList.remove('4');
      var rankA = chapterQueList[progress].rank_a;
      if (rankA == '4') {
        chapterQueList[progress].rank_a = '';
      }

      var rankB = chapterQueList[progress].rank_b;
      if (rankB == '4') {
        chapterQueList[progress].rank_b = '';
      }

      var rankC = chapterQueList[progress].rank_c;
      if (rankC == '4') {
        chapterQueList[progress].rank_c = '';
      }

      var rankD = chapterQueList[progress].rank_d;
      if (rankD == '4') {
        chapterQueList[progress].rank_d = '';
      }
    }
  }

  Widget optionContainer(String option, QueModel question, String optionText,
      {bool ans = false, rank, String optionValue, Function seriesRankTap}) {
    if (optionText == null) {
      return Container();
    } else if (question.que_type == '1') {
      return singleAnswerOption(option, ans, question, optionText, optionValue);
    } else if (question.que_type == '2') {
      return seriesTypeOption(
          rank, ans, question, optionText, optionValue, seriesRankTap);
    } else if (question.que_type == '3') {
      return multipleAnsOption(option, ans, question, optionText, optionValue);
    } else if (question.que_type == '4') {
      return fillBlankOption(option, ans, question, optionText, optionValue);
    } else if (question.que_type == '5') {
      return fillBlankOption1(question);
    } else {
      return Container();
    }
  }

  InkWell singleAnswerOption(String option, bool ans, QueModel que,
      String optionText, String optionValue) {
    return InkWell(
      onTap: () {
        print('RadioSelect ===> Selected : $optionText');
        setState(() {
          selectedOption = optionValue;
          _groupValue = optionValue;
        });
      },
      child: Container(
        padding: EdgeInsets.all(SizeUtils.get(3)),
        decoration: BoxDecoration(
            gradient: CommonUtils.commonGradient(),
            borderRadius: BorderRadius.circular(SizeUtils.get(35))),
        width: SizeUtils.screenWidth,
        child: Row(
          children: [
            SizedBox(width: SizeUtils.get(5)),
            Radio(
              value: optionValue,
              groupValue: _groupValue,
              onChanged: (newValue) {
                selectedOption = optionValue;
                setState(() => _groupValue = optionValue);
              },
              activeColor: ColorConstants.DARK_GREEN,
            ),
            SizedBox(width: SizeUtils.get(15)),
            Expanded(
                child: Text(optionText,
                    style: themeData.textTheme.button.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.WHITE))),
            clickedOption == option
                ? Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ans
                            ? Colors.green
                            : ColorConstants.APP_THEME_COLOR),
                    child: Icon(
                        ans ? Icons.assignment_turned_in_outlined : Icons.close,
                        size: 24,
                        color: ColorConstants.WHITE),
                  )
                : Container(),
            SizedBox(width: SizeUtils.get(5)),
          ],
        ),
      ),
    );
  }

  Widget seriesTypeOption(String option, bool ans, QueModel question,
      String optionText, String optionValue, Function seriesRankTap) {
    return InkWell(
      onTap: seriesRankTap,
      child: Container(
        padding: EdgeInsets.all(SizeUtils.get(3)),
        decoration: BoxDecoration(
            gradient: CommonUtils.commonGradient(),
            borderRadius: BorderRadius.circular(SizeUtils.get(35))),
        width: SizeUtils.screenWidth,
        child: Row(
          children: [
            SizedBox(width: SizeUtils.get(5)),
            Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(4),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(6),
              //   border: Border.all(width: 1)
              // ),
              child: Text(option,
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.headline5
                      .copyWith(fontSize: SizeUtils.getFontSize(16))),
            ),
            SizedBox(width: SizeUtils.get(15)),
            Expanded(
                child: Text(optionText,
                    style: themeData.textTheme.button.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.WHITE))),
            // clickedOption == option
            //     ? Container(
            //         padding: EdgeInsets.all(6),
            //         margin: EdgeInsets.all(2),
            //         decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: ans
            //                 ? Colors.green
            //                 : ColorConstants.APP_THEME_COLOR),
            //         child: Icon(
            //             ans ? Icons.assignment_turned_in_outlined : Icons.close,
            //             size: 24,
            //             color: ColorConstants.WHITE),
            //       )
            //     : Container(),
            SizedBox(width: SizeUtils.get(5)),
          ],
        ),
      ),
    );
    ;
  }

  Widget multipleAnsOption(String option, bool ans, QueModel question,
      String optionText, String optionValue) {
    bool isChecked = false;
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          multipleSelectedOption.contains(optionValue);
        });
      },
      child: Container(
        padding: EdgeInsets.all(SizeUtils.get(3)),
        decoration: BoxDecoration(
            gradient: CommonUtils.commonGradient(),
            borderRadius: BorderRadius.circular(SizeUtils.get(35))),
        width: SizeUtils.screenWidth,
        child: Row(
          children: [
            SizedBox(width: SizeUtils.get(5)),
            // CheckboxListTile(
            //   value: multipleSelectedOption.contains(optionValue),
            //   onChanged: (isSelected) {
            //     if (isSelected) {
            //       multipleSelectedOption.add(optionValue);
            //     } else {
            //       if (multipleSelectedOption.contains(optionValue)) {
            //         multipleSelectedOption.remove(optionValue);
            //       }
            //     }
            //     setState(() {});
            //   },
            //   title: Text(optionText,
            //       style: themeData.textTheme.button.copyWith(
            //           fontWeight: FontWeight.w700,
            //           color: ColorConstants.WHITE)),
            //   activeColor: ColorConstants.DARK_GREEN,
            // ),
            Expanded(
              child: CheckboxListTile(
                value: multipleSelectedOption.contains(optionValue),
                onChanged: (isSelected) {
                  if (isSelected) {
                    multipleSelectedOption.add(optionValue);
                  } else {
                    if (multipleSelectedOption.contains(optionValue)) {
                      multipleSelectedOption.remove(optionValue);
                    }
                  }
                  setState(() {});
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(optionText,
                    style: themeData.textTheme.button.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.WHITE)),
                activeColor: ColorConstants.DARK_GREEN,
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   decoration:
            //       BoxDecoration(shape: BoxShape.circle, color: Colors.black12),
            //   child: Text(option,
            //       textAlign: TextAlign.center,
            //       style: themeData.textTheme.headline5
            //           .copyWith(fontSize: SizeUtils.getFontSize(16))),
            // ),
            // SizedBox(width: SizeUtils.get(15)),
            // Expanded(
            //     child: Text(optionText,
            //         style: themeData.textTheme.button.copyWith(
            //             fontWeight: FontWeight.w700,
            //             color: ColorConstants.WHITE))),
            clickedOption == option
                ? Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ans
                            ? Colors.green
                            : ColorConstants.APP_THEME_COLOR),
                    child: Icon(
                        ans ? Icons.assignment_turned_in_outlined : Icons.close,
                        size: 24,
                        color: ColorConstants.WHITE),
                  )
                : Container(),
            SizedBox(width: SizeUtils.get(5)),
          ],
        ),
      ),
    );
  }

  Widget fillBlankOption(String option, bool ans, QueModel question,
      String optionText, String optionValue,
      {String optionText2}) {
    print(
        'Option : $option Ans : $ans Question : ${question.toJson()} OptionText : $optionText OptionValue : $optionValue');
    return InkWell(
      onTap: () {
        showDialogWithInputField(question);
      },
      child: Container(
        padding: EdgeInsets.all(SizeUtils.get(3)),
        decoration: BoxDecoration(
            gradient: CommonUtils.commonGradient(),
            borderRadius: BorderRadius.circular(SizeUtils.get(35))),
        width: SizeUtils.screenWidth,
        child: Row(
          children: [
            SizedBox(width: SizeUtils.get(5)),
            Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black12),
              child: Text(option,
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.headline5
                      .copyWith(fontSize: SizeUtils.getFontSize(16))),
            ),
            SizedBox(width: SizeUtils.get(15)),
            Expanded(
                child: Text(optionText + ' : ' + blankValue,
                    style: themeData.textTheme.button.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.WHITE))),
            SizedBox(width: SizeUtils.get(5)),
          ],
        ),
      ),
    );
  }

  Widget fillBlankOption1([QueModel question]) {
    return Container(
      padding: EdgeInsets.all(SizeUtils.get(5)),
      decoration: BoxDecoration(
          gradient: CommonUtils.commonGradient(),
          borderRadius: BorderRadius.circular(SizeUtils.get(30))),
      width: SizeUtils.screenWidth,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(width: SizeUtils.get(10)),
          question.blank1 != null && question.blank1 == '1'
              ? Container(
                  width: 60,
                  child: TextField(
                    controller: blank1,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ))
              : Container(),
          question.part1 != null ? Text(question.part1) : Container(),
          question.blank2 != null && question.blank2 == '1'
              ? Container(
                  width: 60,
                  child: TextField(
                    controller: blank2,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ))
              : Container(),
          question.part2 != null ? Text(question.part2) : Container(),
          question.blank3 != null && question.blank3 == '1'
              ? Container(
                  width: 60,
                  child: TextField(
                    controller: blank3,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ))
              : Container(),
          question.part3 != null ? Text(question.part3) : Container(),
          SizedBox(width: SizeUtils.get(10)),
        ],
      ),
    );
  }

  void showDialogWithInputField(QueModel que) async {
    Dialogs.showDialogWithInputField(context, (value) {
      print(value);
      if (value != null) {
        blankValue = value;
        setState(() {});
      }
    });
  }

  /*
* 1 -> Single option answer
* 2 -> Series of answer
* 3 -> Multiple answer
* 4 -> Fill in the blank answer
* */

  Widget submitButton() {
    return ButtonUtils.btnFillGreen(
        title: Strings.SUBMIT,
        color: ColorConstants.APP_THEME_COLOR,
        onTap: () {
          storeQue();
        });
  }

  void storeQue() async {
    if (chapterQueList[progress].que_type == '1') {
      if (selectedOption == '') {
        Dialogs.showInfoDialog(context, 'Please select any option');
        return;
      }
      print('$selectedOption  ${chapterQueList[progress].ans}');
      if (selectedOption == chapterQueList[progress].ans) {
        chapterQueList[progress].result = Strings.CORRECT;
      } else {
        chapterQueList[progress].result = Strings.WRONG;
      }
      chapterQueList[progress].selected_ans = selectedOption;
    } else if (chapterQueList[progress].que_type == '2') {
      if (seriesValueList.isEmpty) {
        Dialogs.showInfoDialog(context, 'Please order the series of option');
        return;
      }
      List<String> correctAnswer = chapterQueList[progress].ans.split(',');
      print('$correctAnswer , $seriesValueList');
      List<String> tempList = [];
      if (chapterQueList[progress].rank_a != '') {
        tempList.add(chapterQueList[progress].rank_a);
      }
      if (chapterQueList[progress].rank_b != '') {
        tempList.add(chapterQueList[progress].rank_b);
      }
      if (chapterQueList[progress].rank_c != '') {
        tempList.add(chapterQueList[progress].rank_c);
      }
      if (chapterQueList[progress].rank_d != '') {
        tempList.add(chapterQueList[progress].rank_d);
      }
      print(
          'QuizScreen ===> Correct : ${correctAnswer.toList()} Temp : ${tempList.toList()}');
      if (correctAnswer.join(',') == tempList.join(',')) {
        chapterQueList[progress].result = Strings.CORRECT;
      } else {
        chapterQueList[progress].result = Strings.WRONG;
      }
      chapterQueList[progress].selected_ans = tempList.join(',');
    } else if (chapterQueList[progress].que_type == '3') {
      if (multipleSelectedOption.isEmpty) {
        Dialogs.showInfoDialog(context, 'Please select any option');
        return;
      }
      bool isCorrect = true;
      List<String> correctAnswer = chapterQueList[progress].ans.split(',');
      chapterQueList[progress].selected_ans = multipleSelectedOption.join(',');
      if (correctAnswer.length == multipleSelectedOption.length) {
        correctAnswer.forEach((element) {
          if (!multipleSelectedOption.contains(element)) {
            isCorrect = false;
          }
        });
      } else {
        isCorrect = false;
      }
      if (chapterQueList[progress].que_id == '8') {
        isCorrect = true;
      }

      if (isCorrect) {
        chapterQueList[progress].result = Strings.CORRECT;
      } else {
        chapterQueList[progress].result = Strings.WRONG;
      }
    } else if (chapterQueList[progress].que_type == '4') {
      if (blankValue == '') {
        Dialogs.showInfoDialog(
            context, 'Please enter your answer by clicking the option');
        return;
      }
      chapterQueList[progress].selected_ans = blankValue;
      if (blankValue == chapterQueList[progress].ans) {
        chapterQueList[progress].result = Strings.CORRECT;
      } else {
        chapterQueList[progress].result = Strings.WRONG;
      }
    } else if (chapterQueList[progress].que_type == '5') {
      multipleSelectedOption.clear();
      if (chapterQueList[progress].blank1 == '1') {
        blank1Ans = blank1.text;
        if (blank1Ans.isBlank)
          Dialogs.showInfoDialog(context, 'Please enter your answer');
        else
          multipleSelectedOption.add(blank1Ans);
      }
      if (chapterQueList[progress].blank2 == '1') {
        blank2Ans = blank2.text;
        if (blank2Ans.isBlank)
          Dialogs.showInfoDialog(context, 'Please enter your answer');
        else
          multipleSelectedOption.add(blank2Ans);
      }
      if (chapterQueList[progress].blank3 == '1') {
        blank3Ans = blank3.text;
        if (blank3Ans.isBlank)
          Dialogs.showInfoDialog(context, 'Please enter your answer');
        else
          multipleSelectedOption.add(blank3Ans);
      }
      bool isCorrect = true;
      List<String> correctAnswer = chapterQueList[progress].ans.split(',');
      chapterQueList[progress].selected_ans = multipleSelectedOption.join(',');
      if (correctAnswer.length == multipleSelectedOption.length) {
        correctAnswer.forEach((element) {
          if (!multipleSelectedOption.contains(element)) {
            isCorrect = false;
          }
        });
      } else {
        isCorrect = false;
      }

      if (isCorrect) {
        chapterQueList[progress].result = Strings.CORRECT;
      } else {
        chapterQueList[progress].result = Strings.WRONG;
      }
      print('QuizScreen ===> Output : ${chapterQueList[progress].toJson()}');
    }
    chapterQueList[progress].userId = FirebaseAuth.instance.currentUser.uid;
    await QueTableManger.instance.addQueWithResult(chapterQueList[progress]);
    clearValues();
  }

  void clearValues() {
    selectedOption = '';
    seriesValueList.clear();
    multipleSelectedOption.clear();
    blankValue = '';
    _groupValue = '';
    goToNextQue();
  }

  void goToNextQue() {
    progress += 1;
    currentQue += 1;
    if (progress == queCount) {
      navigateToResult();
    } else {
      setState(() {});
    }
  }

  void navigateToResult() async {
    await Get.toNamed(Routes.RESULT_PAGE, arguments: chapterId);
    Get.back();
  }

  void enableClick() {
    if (currentQue == queCount) {
      progress += 1;
      setState(() {});
      navigateToResult();
    } else {
      Timer(Duration(seconds: 1), () {
        disableClick = false;
        clickedOption = '';
        currentQue += 1;
        progress += 1;
        setState(() {});
      });
    }
  }
}
