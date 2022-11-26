import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/constants/const.dart';
import '../inTests_controller.dart';
import '../test_controller.dart';

class GpsController extends GetxController {
  StreamSubscription<ServiceStatus> serviceStatusStream;
  bool serviceStatus;
  var index = 0.obs;

  @override
  void onInit() {
    checkStatus();
    serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      serviceStatus = status == ServiceStatus.enabled ? true : false;
    print(status);
      test();
    });
    super.onInit();
  }

  checkStatus() async {
    var ss = await Geolocator.isLocationServiceEnabled();
    serviceStatus = ss;
  }

    @override
  void dispose() {
   
    serviceStatusStream.cancel();
    super.dispose();
  }

  test() {
    print(serviceStatus);
    if (serviceStatus) {
      startTest();
    } else {
      Get.dialog(WillPopScope(
          onWillPop: onWillPop,
          child: SizedBox(
              height: screenHeight / 8,
              child: AlertDialog(
                  content: inTestDialog(
                      'Turn On',
                      ' Gps',
                      'Gps Setting',
                      () => AppSettings.openLocationSettings(),
                      Colors.green)))));
    }
  }

  startTest() async {
    Position position = await _determinePosition();
    if (position != null) {
      Timer(Duration(seconds: 2),
          () => Get.find<TestController>().onEndTest(20, "pass"));
    }
    print(position.toString());
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
