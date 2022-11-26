// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const apiUrl = "https://api.tank.ir/api/v-1.0/";
const baseUrl = "https://api.tank.ir/api/v-1.0/";
const prefixImages = "https://api.tank.ir/api/v-1.0/";
const prefixToken = 'Bearer ';

bool netState = true;

const String USERBOX = "userbox";
const String FONTFAMILY = 'iranSans';

const MaterialColor primaryColors =
    MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
  50: Color(0xFFEBF1FD),
  100: Color(0xFFCEDDFA),
  200: Color(0xFFADC6F7),
  300: Color(0xFF8CAFF3),
  400: Color(0xFF739EF1),
  500: Color(_mcgpalette0PrimaryValue),
  600: Color(0xFF5285EC),
  700: Color(0xFF487AE9),
  800: Color(0xFF3F70E7),
  900: Color(0xFF2E5DE2),
});
const int _mcgpalette0PrimaryValue = 0xFF5A8DEE;

const MaterialColor mcgpalette0Accent =
    MaterialColor(_mcgpalette0AccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_mcgpalette0AccentValue),
  400: Color(0xFFBECDFF),
  700: Color(0xFFA4BAFF),
});

const int _mcgpalette0AccentValue = 0xFFF1F4FF;

int homeCurrentIndex = 0;
// const primaryColor = Color(0xFF1b8f58);
// const primaryColor = Color(0xFF0072ba);
// const statusColor = Color(0xFF0072ba);
const statusColor = Colors.white;
const primaryColor = Colors.white;
const darkColor = Color(0xFF08202c);
const appbarTitleColor = Color(0xFF08202c);
// const appbarIconColor = Color(0xFFfc8207);
const appbarIconColor = Colors.grey;
const borderColor = Color(0xFFe0e0e0);
const backgroundColor = Color(0xFFf4f4f4);
const textColor = Color(0xFF525252);
const secondColor = Color(0xFF0075ff);
const secondColorLight = Color(0xFFD6E9FF);
const tabColor = Color(0xFF2053d2);
const tabUnselectedColor = Colors.grey;
const greyColor = Colors.grey;
const greyTextColor = Color(0xFF6F6F6F);
const stepColor = Color(0xFFb5101e);
const defaultPadding = 12;
// const secondColor = Color(0xFFfc8207);
const backgroundDarkColor = Color(0xFFf4f6fa);
const backgroundImageColor = Color(0xffe6e6e6);
const IconImageColor = Color(0xff9f9f9f);
// const myGrey = Color(0xFFf4f6fa);
const myGrey = Color(0xFFe9ebf0);
const lightGrey = Color(0xFFdddddd);
Color buttonColor = primaryColors[400];

Color shimmerBaseColor = Colors.grey[300];
Color shimmerHighlightColor = Colors.grey[100];
Color textGray = Colors.black87;

final GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey<ScaffoldState>();

const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
  // statusBarColor: Colors.white,
  statusBarColor: statusColor,
  statusBarBrightness: Brightness.light,
  // statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.light,
);

const cardRadius = 7.0;
double formSpace = 6;
double miniButtonSize = 35;
EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 8);

double screenWidth = 0;
double screenHeight = 0;
double preHeight = 0;
double preWidth = 0;
double toolBar = 0;
double tabBar = 0;

BoxShadow cardShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.1), //3
  spreadRadius: 2,
  blurRadius: 3,
  offset: Offset(0, 1), // changes position of shadow
);
BoxShadow cardShadowList = BoxShadow(
  color: Colors.black12.withOpacity(0.1),
  spreadRadius: 2,
  blurRadius: 3,
  offset: Offset(0, 1), // changes position of shadow
);
BoxShadow defaultShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.1),
  spreadRadius: 2,
  blurRadius: 3,
  offset: Offset(0, 3), // changes position of shadow
);

var appBarTitleStyle = TextStyle(
    color: appbarTitleColor, fontWeight: FontWeight.w700, fontSize: 16);

String errorRequired = "این فیلد اجباری است";
String errorMaxLength = "متن طولانی است";
String needLoginMsg = "نیاز به ورود به حساب کاربری";

BoxShadow minShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.1),
  spreadRadius: 2,
  blurRadius: 4,
  offset:
      Offset(0, 3), // changes position of shadow// changes position of shadow
);

getInputDecoration(String label, {help}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
    border: OutlineInputBorder(),
    labelText: label,
    alignLabelWithHint: true,
    // helperText: help != null ? help : ""
  );
}

Future<bool> onWillPop() async {
    return false; 
  }

toast(String messgae) {
  Get.snackbar("", messgae,
      titleText: Container(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: secondColor,
      colorText: Colors.white,
      padding: EdgeInsets.only(bottom: 12, top: 4, left: 12, right: 12),
      margin: EdgeInsets.only(bottom: 70, left: 60, right: 60),
      shouldIconPulse: true,
      duration: Duration(seconds: 2));
}
//helpers ================================================

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String humanNumberGenerator ( num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)}k";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)}k";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)}m";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)}b";
  } else {
    return num.toString();
  }
}
