import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/custom_widget/dialogs.dart';
import 'package:moneytree/custom_widget/progress_view.dart';
import 'package:moneytree/data/preferences/preference_manager.dart';
import 'package:moneytree/routes/app_pages.dart';
import 'package:moneytree/ui/dashboard/dashboard_screen.dart';
import 'package:moneytree/ui/home/home_screen.dart';
import 'package:moneytree/ui/profile/profile_screen.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/size_utils.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Common Variables
  ThemeData themeData;

  PageController _myPage = PageController(initialPage: 1);
  Offset offset = Offset.zero;

  HomeScreen homeScreen;
  DashboardScreen dashboardScreen;
  ProfileScreen profileScreen;
  int selectedIndex = 0;
  bool showLoading = false;
  final List<Widget> _childrenTabs = [
    DashboardScreen(),
    HomeScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar(),
      body: Container(
        color: ColorConstants.APP_THEME_COLOR,
        child: SafeArea(
          child: ProgressWidget(
              isShow: showLoading,
              child: Stack(
                children: [
                  Image.asset(IconConstant.BACKGROUND_RESIZE,
                      width: SizeUtils.screenWidth, fit: BoxFit.cover),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: SizeUtils.screenWidth,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset(IconConstant.D_LOGO,
                                  height: 50, width: 50),
                            ),
                            Flexible(child: Container()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: InkWell(
                                  onTap: () => showLogOut(),
                                  child: Image.asset(IconConstant.LOGOUT,
                                      height: 32, width: 32)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: _childrenTabs[selectedIndex]),
                    ],
                  ),
                  // Positioned(
                  //     left: 10,
                  //     top: 10,
                  //     child:
                  //         Image.asset(IconConstant.D_LOGO, height: 40, width: 40)),
                  // Positioned(
                  //     right: 10,
                  //     top: 10,
                  //     child: InkWell(
                  //         onTap: () => showLogOut(),
                  //         child: Image.asset(IconConstant.LOGOUT,
                  //             height: 32, width: 32))),
                ],
              )),
        ),
      ),
    );
  }

  void navigateToHomeScreen() {
    onTapTab(1);
  }

  void showLogOut() {
    Dialogs.showDialogWithTwoOptions(
        context, 'Are you sure you want to logout?', 'Yes',
        positiveButtonCallBack: () async {
      setLoadingState(true);
      await FirebaseAuth.instance.signOut();
      PreferenceManager.instance.clearAll();
      setLoadingState(false);
      Get.offAllNamed(Routes.WELCOME);
    });
  }

  Widget bottomAppBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(3.0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          bottomTabOption(
              IconConstant.DASHBOARD, () => onTapTab(0), selectedIndex == 0),
          //to leave space in between the bottom app bar items and below the FAB
          // SizedBox(width: 50.0),
          bottomTabOption(
              IconConstant.HOME, () => onTapTab(1), selectedIndex == 1),
          bottomTabOption(
              IconConstant.PROFILE, () => onTapTab(2), selectedIndex == 2)
        ],
      ),
    );
  }

  InkWell bottomTabOption(icon, Function onTap, bool isSelected) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.get(22), vertical: SizeUtils.get(15)),
        child: Image.asset(icon,
            height: SizeUtils.get(22),
            width: SizeUtils.get(22),
            color:
                isSelected ? ColorConstants.APP_THEME_COLOR : Colors.black38),
      ),
    );
  }

  void onTapTab(int index) {
    selectedIndex = index;
    if (mounted) setState(() {});
  }

  void setLoadingState(bool isShow) {
    showLoading = isShow;
    if (mounted) setState(() {});
  }
}
