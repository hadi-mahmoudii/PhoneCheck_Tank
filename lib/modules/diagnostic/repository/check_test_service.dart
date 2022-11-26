import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/const.dart';
import '../../dashboard/repository/device_service.dart';
import '../model/device.dart';
import '../model/test.dart';

class CheckTestResult {
  Device device;

  Future<Device> getDevices() async {
    Dio dio = Dio();
    final response =
        await dio.get("${apiUrl}diagnostic/get_devices_check_tests/",
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
    if (response.statusCode == 200) {
      var responseBody = response.data['device'];
      if (responseBody != null) {
        return Device.fromJson(responseBody);
      }
    }
    return null;
  }
}

class CheckTest extends GetxController {
  @override
  void onInit() {
    getDevices();
    super.onInit();
  }

  Device device;
  List testGroup;

  getDevices() async {
    device = await CheckTestResult().getDevices();
    if (device != null) {
      var groupByDate = groupBy(device.check.tests, (obj) => obj.category);
      testGroup = groupByDate.keys.toList();
    } else {
      testGroup = [];
    }

    update();
  }

  List<Test> getTests(category) {
    return device.check.tests.where((i) => i.category == category).toList();
  }
}

groupBy(List<Test> tests, Function(dynamic obj) param1) {}
