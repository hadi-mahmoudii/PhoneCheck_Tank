import 'dart:async';
import 'dart:html' as battertManger;

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

class BatteryController {
  final Battery _battery = Battery();
  StreamSubscription charging;
  String batHealth;

  chargingTest() {
    charging = BatteryInfoPlugin().androidBatteryInfoStream.listen((event) {
      if (event.pluggedStatus == "AC" || event.pluggedStatus == "USB") {
        Timer(const Duration(seconds: 2), () {
          Get.find<TestController>()
              .onEndTest(1, 'pass', description: 'charging');
          charging.cancel();
        });
        batHealth = event.health;
      }
    });
  }

  batteryHealth() {
    battertManger.BatteryManager batteryManager ;
    // Timer(Duration(), callback)

    print("battery :::::  ${batteryManager.level}");

    Get.find<TestController>().onEndTest(2, 'pass', description: batHealth);
  }
}
