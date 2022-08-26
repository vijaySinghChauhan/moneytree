import 'package:moneytree/ui/authentication/login_screen.dart';
import 'package:moneytree/ui/authentication/signup_screen.dart';
import 'package:moneytree/ui/authentication/welcome_screen.dart';
import 'package:moneytree/ui/dashboard/dashboard_screen.dart';
import 'package:moneytree/ui/mainscreen/main_screen.dart';
import 'package:moneytree/ui/profile/edit_profile_screen.dart';
import 'package:moneytree/ui/profile/profile_screen.dart';
import 'package:moneytree/ui/quiz/quiz_screen.dart';
import 'package:moneytree/ui/quiz/result_screen.dart';
import 'package:moneytree/ui/splash_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.SIGNUP_PAGE,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: Routes.QUIZ_PAGE,
      page: () => QuizScreen(),
    ),
    GetPage(
      name: Routes.RESULT_PAGE,
      page: () => ResultScreen(),
    ),
    GetPage(
      name: Routes.DASHBOARD_SCREEN,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: Routes.MAIN_SCREEN,
      page: () => MainScreen(),
    ),
    GetPage(
      name: Routes.PROFILE_SCREEN,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE_SCREEN,
      page: () => EditProfileScreen(),
    ),
  ];
}
