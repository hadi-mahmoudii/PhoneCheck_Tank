import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/inTests_controller.dart';
import 'package:phonecheck/modules/diagnostic/model/check.dart';
import 'package:phonecheck/modules/diagnostic/model/device.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:phonecheck/modules/diagnostic/model/result.dart';
import 'package:phonecheck/modules/diagnostic/model/test.dart';
import 'package:phonecheck/modules/diagnostic/repository/diagnostic_service.dart';
import "package:collection/collection.dart";
import 'package:phonecheck/modules/diagnostic/screen/result_screen.dart';

class DiagnosticController extends GetxController {
  static DiagnosticController get to => Get.find();
  var number = "";
  Timer timer;
  Check check;
  List testGroup;
  int categoryIndex;
  int testIndex;
  List<Test> categoryTests;
  List<int> inTests = [18, 19, 20, 21, 3, 4, 5, 17, 15, 16, 1, 2];

  @override
  onInit() {
    super.onInit();
  }

  startTest(checkerId) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Get.back();
      check = await DiagnosticService.initCheck(
          checkerId, Get.find<HomeController>().deviceId);

      var groupByDate = groupBy(check.tests, (obj) => obj.category);
      testGroup = groupByDate.keys.toList();
      buildCurrentStatus(0);
      update();
    });
  }

  buildCurrentStatus(index) {
    if (index + 1 > testGroup.length) {
      Get.snackbar("پایان تست", "تمام تست ها پایان یافت");
      Get.to(ResultScreen());
    } else {
      categoryIndex = index;
      testIndex = 0;
      categoryTests =
          check.tests.where((i) => i.category == testGroup[categoryIndex]).toList();
   testsStatus();
      update();
      Get.back();
      Get.back();
      runTest(categoryTests[testIndex].id);
    }
  }

  goNextTest() {
    if (testIndex + 1 == categoryTests.length) {
      buildCurrentStatus(categoryIndex + 1);
    } else {
      testIndex += 1;
      testsStatus();

      Get.back();
      Get.back();
      runTest(categoryTests[testIndex].id);
    }
  }

  runTest(int testId) {
    if (inTests.contains(testId)) {
      Get.find<InTestsController>().runInTests(testId);
    } else {
      Timer(
          Duration(seconds: 2),
          () => Get.toNamed(
              "/${categoryTests[testIndex].title.replaceAll(' ', '')}"));
    }
  }

  testsStatus() {
    if (categoryTests[testIndex].category == 'buttons') {
      categoryTests.forEach((element) {
        print(element.id);
        element.status = 'in_progress';
      });
    } else {
      categoryTests[testIndex].status = "in_progress";
    }
  }

  onStartTest(int testId) async {
    Result result =
        await DiagnosticService.initResult(check.id, testId, "in_progress");
    print(result.id);
    return result;
  }

  onDoneTest(int testId, int resultId, status,{ dynamic description}) async {
    Result result = await DiagnosticService.initResult(check.id, testId, status,
        resultId: resultId);
    int index = categoryTests.indexWhere((element) => element.id == testId);
    print("index++++++++++++++");
    print(index);
    print("index______________");
    categoryTests[index].status = status;
    categoryTests[index].description = description;

    update();
    return result;
  }
}
