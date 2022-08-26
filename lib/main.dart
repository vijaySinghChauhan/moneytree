import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moneytree/app_theme/app_theme.dart';
import 'package:moneytree/routes/app_pages.dart';
import 'package:moneytree/utils/constants/app_constant.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/size_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstants.APP_THEME_COLOR
  ));
  await Firebase.initializeApp();
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.init(constraints, orientation);
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.APP_NAME,
            theme: MyAppTheme.lightTheme,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          ),
        );
      });
    });
  }
}
