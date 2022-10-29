// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';
import 'package:phonecheck/modules/diagnostic/model/result.dart';
import 'package:phonecheck/modules/diagnostic/widegt/dialogs.dart';

class TestController extends GetxController {
  static TestController get to => Get.find();

  Timer checkTimer;
  Result result;
  var testResult;
  List<int> needAskTests = [11, 12, 24, 29, 28, 30 , 19 , 9];

  @override
  onInit() {
    super.onInit();
  }

  onStartTest(testId, int seconds) async {
    result = await Get.find<DiagnosticController>().onStartTest(testId);
    print("test is started");
    testResult = null;
    cancellTimer();
    if(needAskTests.contains(testId)){

    }else{
checkTimer = Timer(Duration(seconds: seconds), () {
          if (testResult == null) {
            onEndTest(testId, "fail");
          }
        });
    }
    
  }

  cancellTimer() {
    if (checkTimer != null) {
      checkTimer.cancel();
    }
  }

  checkResultTest(var test) {
    if (test != null) {
      Get.back(closeOverlays: true);
      Get.find<DiagnosticController>().goNextTest();

      testResult = null;
    } else {
      print('test is empty');
      checkResultTest(test);
    }
  }

  onEndTest(testId, type , {testOptions status}) async {
    cancellTimer();
    testResult = await Get.find<DiagnosticController>()
        .onDoneTest(testId, result.id, type);

    status == testOptions.unsuportted
        ? Get.defaultDialog(
            contentPadding: EdgeInsets.all(15),
            radius: 8,
            content: Column(
              children: [
                Center(
                  child: Text('unsuportted Test'),
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () => {
                    checkResultTest(testResult),
                  },
                  child: Text('Next test',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ))
        : type == 'pass'
            ? succesDialog(testId, checkResultTest(testResult))
            : failTestDialog('test', testId);
  }

  askWork(title, testId, seconds, BuildContext context) {
    cancellTimer();
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(15),
      radius: 8,
      title: "${title} is work?",
      titleStyle: TextStyle(
          color: appbarTitleColor, fontWeight: FontWeight.w700, fontSize: 22),
      content: SizedBox(
        child: Column(
          children: [
            Text(
              "Did the $title work properly?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.red,
                  onPressed: () => {Get.back(), onEndTest(testId, "fail")},
                  child: Text('No',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () => {Get.back(), onEndTest(testId, "pass")},
                  child: Text('Yes',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

enum testOptions {
  unsuportted,
  fail,
  pass,
}
