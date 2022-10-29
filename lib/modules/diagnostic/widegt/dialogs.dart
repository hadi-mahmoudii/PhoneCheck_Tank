import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:phonecheck/modules/diagnostic/widegt/testID.dart';

import '../../core/constants/const.dart';

Future<void> succesDialog(
  int testId,
  Function onEnd,
) async {
  String text = testsID[0][testId];
  Future.delayed(const Duration(seconds: 2), () {
    onEnd;
  });

  return Get.dialog(
    AlertDialog(
      content: SingleChildScrollView(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: screenWidth / 1.8,
              child: Text(
                '$text test was Done Succesfully',
                style: const TextStyle(fontSize: 15, wordSpacing: 0.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const SizedBox(
            //   width: 5,
            // ),
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                'assets/images/check.png',
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> askResultDialog(String test, int testId) async {
  return Get.dialog(WillPopScope(
    onWillPop: () async => false,
    child: SizedBox(
      height: screenHeight / 2,
      width: screenWidth / 3,
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Did $test Work Correctly?',
                style: const TextStyle(
                    fontSize: 17, wordSpacing: 1, letterSpacing: 0.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  askButton('no', 'No', testId),
                  const SizedBox(
                    width: 20,
                  ),
                  askButton('yes', 'Yes', testId),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  ));
}

Future<void> failTestDialog(String test, int testId) async {
  return Get.dialog(SizedBox(
    height: screenHeight / 2,
    width: screenWidth / 3,
    child: WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                ' $test test was failed!',
                style: const TextStyle(
                    fontSize: 19, wordSpacing: 1, letterSpacing: 0.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  askButton('restart', 'Restart', testId),
                  const SizedBox(
                    width: 20,
                  ),
                  askButton('fail', 'Next test', testId),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  ));
}

Widget askButton(String kind, String title, int testId) {
  var testController = Get.find<TestController>();
  bool greenBut = kind == 'yes' || kind == 'restart';

  return GestureDetector(
    onTap: () {
      switch (kind) {
        case 'yes':
          testController.onEndTest(
            testId,
            'pass',
          );

          break;
        case 'no':
          Get.back();
          testController.onEndTest(testId, 'fail');
          break;
        case 'restart':
          {
            testController.onStartTest(
              testId,
              10,
            );
            Get.back();
          }
          break;
        case 'fail':
          {
            Get.find<DiagnosticController>().goNextTest();
            Get.back();
          }
          break;

        default:
      }
    },
    child: Container(
      padding: const EdgeInsets.only(right: 7, left: 2),
      height: preHeight * 4.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: greenBut ? Colors.green : Colors.redAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            greenBut
                ? Icons.check_circle_outlined
                : Typicons.cancel_circled_outline,
            color: Colors.white,
            size: 27,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
