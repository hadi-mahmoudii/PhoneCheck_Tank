// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import '../controller/test_controller.dart';

class GPSScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GPSScreenState();
}

class GPSScreenState extends State<GPSScreen> {
  StreamSubscription<ServiceStatus> serviceStatusStream;
  bool serviceStatus=false;

  @override
  void initState() {
    Get.find<TestController>().onStartTest(20,10);
    super.initState();
    checkStatus();
    serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      setState(() {
        serviceStatus = status == ServiceStatus.enabled ? true : false;
      });
      print(status);
    });
  }

  checkStatus() async {
    var ss = await Geolocator.isLocationServiceEnabled();
    setState(() {
      serviceStatus=ss;
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    serviceStatusStream.cancel();
    super.dispose();
  }

  startTest() async {
    Position position = await _determinePosition();
    if(position!=null){
      Get.find<TestController>().onEndTest(20, "pass");
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !serviceStatus
                  ? ElevatedButton(onPressed: () async => AppSettings.openLocationSettings(), child: Text('Turn on Gps'))
                  : MaterialButton(
                       color: secondColor,
                      onPressed: () => {startTest()},
                       child: Text(
                        "start test",
                        style: TextStyle(color: Colors.white),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
