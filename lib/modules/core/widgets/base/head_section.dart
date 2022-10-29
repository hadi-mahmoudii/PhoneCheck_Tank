import 'package:flutter/material.dart';
import 'package:phonecheck/modules/core/constants/const.dart';

Widget headSection(title) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    alignment: Alignment.center,
    width: screenWidth,
    height: 25,
    decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 14,
      ),
    ),
  );
}

Widget iconBtn(icon) {
  double btnSize = screenWidth / 7;
  double btnMargin = 3;
  return Container(
    margin: EdgeInsets.all(btnMargin),
    height: btnSize,
    width: btnSize,
    decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: borderColor),
        boxShadow: [defaultShadow]),
    child: Icon(
      icon,
      size: 24,
      color: Colors.white,
    ),
  );
}