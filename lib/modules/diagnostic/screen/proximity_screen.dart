// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:phonecheck/modules/diagnostic/model/result.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProximityScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProximityScreenState();
}

class ProximityScreenState extends State<ProximityScreen> {
  bool _isNear = false;
  StreamSubscription<dynamic> _streamSubscription;
  

  // int _start = 2;
  Result result;
  int testId = 26;
  bool isFinished = false;



  @override
  void initState() {
    Get.find<TestController>().onStartTest(26,10  );
    // onStartTest();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        print(_isNear);
        if (_isNear) {
          Get.find<TestController>().onEndTest(26,"pass");
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
   
    super.dispose();
    _streamSubscription.cancel();
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
              Container(
                child: Text(
                    "To test, hold the phone next to your ear for three second"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
