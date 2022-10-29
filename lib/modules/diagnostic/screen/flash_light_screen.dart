// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/widegt/dialogs.dart';
import 'package:torch_light/torch_light.dart';

import '../controller/test_controller.dart';

class FlashLightScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FlashLightScreenState();
}

class FlashLightScreenState extends State<FlashLightScreen> {
  bool isOn = false;

  @override
  void initState() {
    Get.find<TestController>().onStartTest(30, 15);
    super.initState();
  }

  @override
  void dispose() {
    off();
    super.dispose();
  }

  off() async {
    await TorchLight.disableTorch();
    setState(() {
      isOn = false;
    });
  }

  startTest() async {
    final isTorchAvailable = await TorchLight.isTorchAvailable();
    if (isTorchAvailable) {
      if (isOn) {
        await TorchLight.disableTorch();
        setState(() {
          isOn = false;
        });
      } else {
        await TorchLight.enableTorch();
        
            askResultDialog("flash light", 30,);
        Timer(Duration(seconds: 2), () => off());
        setState(() {
          isOn = true;
        });
      }
    }
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
            Text("Flash Light Screen"),
            MaterialButton(
              color: isOn ? Colors.red : Colors.blue,
              onPressed: () => {startTest()},
              child: Text('Start Test',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            )
          ],
        ),
      )),
    );
  }
}
