import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phonecheck/modules/core/constants/const.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: SizedBox(
        width: 80,
        child: SpinKitThreeBounce (
          color: secondColor,
          size: 25.0,
        ),
      ),
    );
  }
}
