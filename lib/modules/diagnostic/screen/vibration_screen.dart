// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:vibration/vibration.dart';

import '../widegt/dialogs.dart';

class VibrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VibrationScreenState();
}

class VibrationScreenState extends State<VibrationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<TestController>().onStartTest(24, 10);
  }

  doVibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
    askResultDialog("Vibration", 24);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Vibration Test",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => doVibrate(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("start test",
                      style: TextStyle(fontSize: 20, color: Colors.blue)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.vibration)
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
