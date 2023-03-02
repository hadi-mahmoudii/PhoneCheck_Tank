import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phonecheck/modules/diagnostic/controller/inTests_controller.dart';
import 'package:phonecheck/modules/diagnostic/widegt/tests_commands.dart';

import '../../../core/constants/const.dart';
import '../test_controller.dart';

class BluetoothController extends GetxController {
  final flutterReactiveBle = FlutterReactiveBle();

  var statusBle = BleStatus.unknown;
  var index = 0.obs;
  bool isStarted = false;
  StreamSubscription<BleStatus> listen;

  @override
  void dispose() {
    listen.cancel();
    super.dispose();
  }

  @override
  void onInit() {
    checkPermission();
    super.onInit();
  }

  checkPermission() async {
    Permission.bluetoothConnect.request();
    if (await Permission.location.request().isGranted) {
      if (await Permission.bluetoothScan.isGranted &&
          await Permission.bluetoothConnect.isGranted) {
        listen = flutterReactiveBle.statusStream.listen((status) {
          statusBle = status;
          print(statusBle);
          isStarted ? test() : null;
        });
      } else {
        await Permission.bluetoothConnect.request();
        await Permission.bluetoothScan.request();
        checkPermission();
      }
    } else {
      await Permission.location.request();
      checkPermission();
    }
  }

  test() {
    print('status bluetooth is $statusBle');
    if (statusBle == BleStatus.ready ||
        statusBle == BleStatus.locationServicesDisabled) {
      Timer(const Duration(seconds: 2),
          () => Get.find<TestController>().onEndTest(21, 'pass' , description: 'pass'));
      isStarted = false;
    } else {
      Get.dialog(WillPopScope(
        onWillPop: onWillPop,
        child: SizedBox(
            height: screenHeight / 8,
            width: screenWidth * 0.9,
            child: AlertDialog(
              content: inTestDialog(
                  'Turn On',
                  ' Bluetooth',
                  'Bluetooth Setting',
                  () => AppSettings.openBluetoothSettings(),
                  Colors.green),
            )),
      ));
    }
  }
}
