// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccelerometerScreenState();
}

class AccelerometerScreenState extends State<AccelerometerScreen> {
  var gyroscope;
   double x;
   UserAccelerometerEvent p;
  bool canDone = false;

  @override
  void initState() {
    Get.find<TestController>().onStartTest(15, 15 );
    Timer(Duration(seconds: 2), () => canDone = true);
    gyroscope = userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        p = event;
      });
      if (canDone & (event != null)) {
        gyroscope.cancel();
        Get.find<TestController>().onEndTest(15, "pass" );
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    gyroscope.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
onWillPop: onWillPop,
      child: Scaffold(
          body: Center(
            child: p != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("x :${p.x}"),
                Text("y :${p.y}"),
                Text("z :${p.z}"),
                Text("Accelerometer Test"),
              ],
            )
                : Text("Accelerometer Test"),
          )),
    );
  }
}
