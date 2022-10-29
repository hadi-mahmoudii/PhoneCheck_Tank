import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/diagnostic/model/check.dart';
import 'package:phonecheck/modules/diagnostic/model/device.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:phonecheck/modules/diagnostic/model/result.dart';
import 'package:phonecheck/modules/diagnostic/model/test.dart';
import 'package:phonecheck/modules/diagnostic/repository/diagnostic_service.dart';
import "package:collection/collection.dart";

class DiagnosticController extends GetxController {
  static DiagnosticController get to => Get.find();
  var number = "";
  Timer timer;
  Check check;
  List testGroup;
  int categoryIndex;
  int testIndex;
  List<Test> categoryTests;

  @override
  onInit() {
    super.onInit();
  }

  startTest(checkerId) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
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
    } else {
      categoryIndex = index;
      testIndex = 0;
      categoryTests = check.tests
          .where((i) => i.category == testGroup[categoryIndex])
          .toList();
      categoryTests[testIndex].status = "in_progress";
      update();
      Get.back();
      Get.back();
      Timer(
          Duration(seconds: 2),
              () => Get.toNamed(
              "/${categoryTests[testIndex].title.replaceAll(' ', '')}"));
      // print(categoryTests[testIndex].title.replaceAll(' ', ''));
      // Get.toNamed("/${categoryTests[testIndex].title.replaceAll(' ', '')}");
    }
  }

  goNextTest() {
    if (testIndex + 1 == categoryTests.length) {
      buildCurrentStatus(categoryIndex + 1);
    } else {
      // categoryTests[testIndex].status = testIndex.isEven ? "success" : "danger";
      testIndex += 1;
      categoryTests[testIndex].status = "in_progress";
      print(categoryTests[testIndex].title.replaceAll(' ', ''));
      Get.back();
      Get.back();
      Timer(
          Duration(seconds: 2),
          () => Get.toNamed(
              "/${categoryTests[testIndex].title.replaceAll(' ', '')}"));
    }
  }

  onStartTest(int testId) async {
    Result result =
        await DiagnosticService.initResult(check.id, testId, "in_progress");
    print(result.id);
    return result;
  }

  onDoneTest(int testId, int resultId, status) async {
    Result result = await DiagnosticService.initResult(check.id, testId, status,
        resultId: resultId);
    int index = categoryTests.indexWhere((element) => element.id == testId);
    print("index++++++++++++++");
    print(index);
    print("index______________");
    categoryTests[index].status = status;
    update();
    return result;
  }
}
