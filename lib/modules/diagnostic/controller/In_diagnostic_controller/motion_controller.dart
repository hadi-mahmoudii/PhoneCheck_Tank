import 'dart:async';

import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../test_controller.dart';

class MotionController {
  StreamSubscription gyroscope;
  StreamSubscription accelerometer;
  StreamSubscription compass;
  double x;

  gyroscopeTest() {
    gyroscope = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (event != null) {
        gyroscope.cancel();
        Timer(const Duration(seconds: 2), () {
          Get.find<TestController>()
              .onEndTest(17, "pass",);
        });
      }
    });
  }

  accelerometerTest() {
    accelerometer =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      if ((event != null)) {
        accelerometer.cancel();
        Timer(const Duration(seconds: 2), () {
          Get.find<TestController>()
              .onEndTest(15, "pass",);
        });
      }
    });
  }

  compassTest() {
    compass = magnetometerEvents.listen((MagnetometerEvent event) {
      if ((event != null)) {
        compass.cancel();
        Timer(const Duration(seconds: 2), () {
          Get.find<TestController>()
              .onEndTest(16, "pass",);
        });
      }
    });
  }
}
