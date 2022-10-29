// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

class WifiScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WifiScreenState();
}

class WifiScreenState extends State<WifiScreen> {
  var subscription;
  ConnectivityResult conn = ConnectivityResult.mobile;
  bool canDone = false;

  @override
  void initState() {
    Get.find<TestController>().onStartTest(18, 15 );
    Timer(Duration(seconds: 2), () => checkTest(isDone: true));
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        conn = result;
      });
      checkTest();
    });
    super.initState();
  }

  checkTest({isDone}) async {
    conn = await (Connectivity().checkConnectivity());
    if (isDone!=null) {
      canDone = true;
    }
    
    if (conn == ConnectivityResult.wifi && canDone) {
      Get.find<TestController>().onEndTest(18, "pass");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: Center(
        child: conn != ConnectivityResult.wifi
            ? Column(
              children: [
                Text("Turn on wifi to test"),
                SizedBox(height: 10,),
                TextButton(onPressed:()=> AppSettings.openWIFISettings(), child: Text('Turn On Wifi'))
              ],
            )
            : Text("Testing wifi ..."),
      )),
    );
  }
}
