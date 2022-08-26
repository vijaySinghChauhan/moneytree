import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytree/data/preferences/preference_manager.dart';
import 'package:moneytree/routes/app_pages.dart';
import 'package:moneytree/utils/constants/videos_constants.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // common var
  ThemeData themeData;

  final asset = VideosConstants.SPLASH_VIDEO;
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((_) => controller.play());
    startTime();
  }

  startTime() async {
    var _duration = Duration(milliseconds: 5500);
    return new Timer(_duration, checkLogin);
  }

  void checkLogin() async {
    var isLogin = await PreferenceManager.instance.getIsLogin() ?? false;
    if (isLogin) {
      Get.offAndToNamed(Routes.MAIN_SCREEN);
    } else {
      Get.offAndToNamed(Routes.WELCOME);
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return controller != null && controller.value.initialized
        ? Container(alignment: Alignment.topCenter, child: buildVideo())
        : Container(color: Colors.white);
    // return splashBody();
  }

  Widget buildVideo() => Stack(
    fit: StackFit.expand,
    children: <Widget>[
      buildVideoPlayer()
    ],
  );

  Widget buildVideoPlayer() => AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: VideoPlayer(controller),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
