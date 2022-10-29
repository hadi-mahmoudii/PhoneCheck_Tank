import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:light/light.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

class LightSensorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LightSensorScreenState();
}

class LightSensorScreenState extends State<LightSensorScreen> {
  String _luxString = 'Unknown';
  Light _light;
  StreamSubscription _subscription;
  Timer _timer;
  int _start = 3;

  bool isFinished = false;

  void onData(int luxValue) async {
    print("Lux : $luxValue");
    setState(() {
      if (luxValue > 500) {
        if (!isFinished) {
          Get.find<TestController>().onEndTest(22, "pass");
        }
        isFinished = true;
        // checkFinished();
      }
      _luxString = "$luxValue";
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  @override
  void initState() {
    Get.find<TestController>().onStartTest(22, 10 );
    _light = Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lux value: $_luxString\n',
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: const Text(
                    "To test, hold the phone against strong light for three seconds"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
