import 'package:flutter/material.dart';
import 'package:phonecheck/modules/core/constants/const.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    buttonColor: Colors.blue,
    primaryColor: Color(0xFF0072ba),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: FONTFAMILY,
        ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: FONTFAMILY,
        ),
    accentTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: FONTFAMILY,
        ),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black87,
    buttonColor: Colors.red,
    primaryColor: Colors.black,
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: FONTFAMILY,
        ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: FONTFAMILY,
        ),
    accentTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: FONTFAMILY,
        ),
  );
}
