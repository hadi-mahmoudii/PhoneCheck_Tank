import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/diagnostic/controller/In_diagnostic_controller/battery_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/In_diagnostic_controller/buttons_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/In_diagnostic_controller/wifi_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:phonecheck/modules/diagnostic/widegt/tests_commands.dart';
import 'In_diagnostic_controller/bluetooth_controller.dart';
import 'In_diagnostic_controller/cellular_controller.dart';
import 'In_diagnostic_controller/gps_controller.dart';
import 'In_diagnostic_controller/motion_controller.dart';

class InTestsController extends GetxController {
  InTestsController({this.startConnection});
  CellularController cellularCon;
  BluetoothController bluetoothcon;
  GpsController gpsController;
  WifiController wifiController;
  ButtonsController buttonsCon;
  var motionController;
  final ConnectivityResult startConnection;

  runInTests(int testId) {
    print('this is in test : $testId');
    Get.find<TestController>().onStartTest(testId, 20);
    switch (testId) {
      case 19:
        // startConnection == ConnectivityResult.mobile
        //     ? Timer(
        //         const Duration(seconds: 2), () => succesTest(testId, 'pass'))
        //     : Get.find<CellularController>().test(testId);
        // cellularCon.index++;
        Timer(Duration(seconds: 2), (() => succesTest(testId, 'pass')));

        break;
      case 21:
        bluetoothcon.isStarted = true;
        bluetoothcon.checkPermission();
        Get.find<BluetoothController>().test();
        break;
      case 20:
        Get.find<GpsController>().test();

        break;
      case 18:
        startConnection == ConnectivityResult.wifi
            ? Timer(
                const Duration(seconds: 2), () => succesTest(testId, 'pass'))
            : Get.find<WifiController>().test(testId);
        wifiController.index++;

        break;
      case 3:
        print('volume up test');

        Get.find<ButtonsController>().initPlatformState();
        Get.find<ButtonsController>().volumeButtonsTest(3);
        break;
      case 4:
        Timer(
            Duration(milliseconds: 10), (() => Get.back(closeOverlays: true)));

        Get.find<ButtonsController>().initPlatformState();
        Get.find<ButtonsController>().volumeButtonsTest(4);

        break;
      case 5:
        Get.find<ButtonsController>().power();
        break;
      case 17:
        MotionController().gyroscopeTest();
        break;

      case 15:
        MotionController().accelerometerTest();
        break;
      case 16:
        MotionController().compassTest();
        break;
      case 1:
        BatteryController().chargingTest();
        break;
      case 2:
        BatteryController().batteryHealth();
        break;
      default:
    }
  }

  @override
  void onInit() {
    cellularCon = Get.put(CellularController());
    bluetoothcon = Get.put(BluetoothController());
    gpsController = Get.put(GpsController());
    wifiController = Get.put(WifiController());
    buttonsCon = Get.put(ButtonsController());
    Get.find<ButtonsController>().initPlatformState();

    super.onInit();
  }
}

inTestDialog(
    String message, String test, String button, Function ontap, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SingleChildScrollView(
        child: RichText(
          text: TextSpan(
            text: message,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                  text: test, style: TextStyle(color: color, fontSize: 14)),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      OutlinedButton(
        onPressed: ontap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
        ),
        child: Text(
          button,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
      )
    ],
  );
}
