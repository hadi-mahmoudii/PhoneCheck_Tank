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
    // Get.back(closeOverlays: true);
    onEnd;
  });

  double height = screenHeight / 16;
  double width = screenWidth * 0.8;

  return Get.dialog(
    AlertDialog(
        content: Container(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text('$text was succesfull')),
          SizedBox(
            width: 5,
          ),
          Image.asset(
            'assets/images/check.png',
            height: 50,
            width: width / 5,
          ),
        ],
      ),
    )),
  );
}

Future<void> askResultDialog(String test, int testId, {String desc}) async {
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
                  askButton(
                    'no',
                    'No',
                    testId,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  askButton(
                    'yes',
                    'Yes',
                    testId,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  ));
}

Future<void> failTestDialog(int testId) async {
  String text = testsID[0][testId];
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
                ' $text test was failed!',
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
                  askButton(
                    'fail',
                    'Next test',
                    testId,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  ));
}

Widget askButton(String kind, String title, int testId, {String desc}) {
  var testController = Get.find<TestController>();
  bool greenBut = kind == 'yes' || kind == 'restart';

  return GestureDetector(
    onTap: () {
      switch (kind) {
        case 'yes':
          testController.onEndTest(
            testId,
            'pass',
            description: 'pass',
          );

          break;
        case 'no':
          Get.back();
          testController.onEndTest(testId, 'fail', description: 'fail');
          break;
        case 'restart':
          {
            testController.doneTests.remove(testId);
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
