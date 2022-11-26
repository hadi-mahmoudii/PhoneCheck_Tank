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
    switch (testId) {
      case 19:
        // startConnection == ConnectivityResult.mobile
        //     ? Timer(
        //         const Duration(seconds: 2), () => succesTest(testId, 'pass'))
        //     : Get.find<CellularController>().test(testId);
        // cellularCon.index++;
        succesTest(testId, 'pass');
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
      case 4:
        print('testId for');
        Get.back(closeOverlays: true);
        Get.find<ButtonsController>().initPlatformState();
        Get.find<ButtonsController>().test1();
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
        print('battery is charging?');
        BatteryController().chargingTest();
        break;
      case 2:
        BatteryController().batteryHealth();
        break;
      default:
        Timer(Duration(seconds: 2),
            () => Get.find<TestController>().onEndTest(testId, 'pass'));
    }
  }

  @override
  void onInit() {
    cellularCon = Get.put(CellularController());
    bluetoothcon = Get.put(BluetoothController());
    gpsController = Get.put(GpsController());
    wifiController = Get.put(WifiController());
    buttonsCon = Get.put(ButtonsController());

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
            style: const TextStyle(color: Colors.black, fontSize: 15),
            children: <TextSpan>[
              TextSpan(
                  text: test, style: TextStyle(color: color, fontSize: 17)),
            ],
          ),
        ),
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
