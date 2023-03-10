import 'package:dante/Presentation/AllScreen/Home/HomeScreen.dart';
import 'package:dante/Presentation/AllScreen/Profile/LoginScreen.dart';
import 'package:dante/Presentation/AllScreen/Profile/OtpScreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Presentation/AllScreen/MainScreen.dart';
class AppRoutes {
  static const String INITAL = "/";
  static const String MAINSCREEN = "/mainscreen";
  static const String HOMESCREEN = "/homescreen";
  static const String LOGINSCREEN = "/loginscreen";
  static const String OTPSCREEN = "/otpscreen";

  static List<GetPage> routes = [
    GetPage(
        name: MAINSCREEN,
        page: () => MainScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: HOMESCREEN,
        page: () => HomeScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: LOGINSCREEN,
        page: () => LoginScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),
    GetPage(
        name: OTPSCREEN,
        page: () => OtpScreen(),
        transitionDuration: Duration(milliseconds: 100),
        transition: Transition.cupertino),

  ];
}