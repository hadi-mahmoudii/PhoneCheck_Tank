// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BluetoothScreenState();
}

class BluetoothScreenState extends State<BluetoothScreen> {
  final flutterReactiveBle = FlutterReactiveBle();
  var discover;
  BleStatus statusBle;
  var listen;

  @override
  void initState() {
    Get.find<TestController>().onStartTest(21, 10);
    
    checkPermission();
    super.initState();
  }

  checkPermission() async {
    Permission.bluetoothConnect.request();
    if (await Permission.location.request().isGranted) {
      if (await Permission.bluetoothScan.isGranted &&
          await Permission.bluetoothConnect.isGranted) {
        listen = flutterReactiveBle.statusStream.listen((status) {
          setState(() {
            statusBle = status;
            print(status);
          });
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

  @override
  void dispose() {
    // TODO: implement dispose
    discover.cancel();
    listen.cancel();
    super.dispose();
  }

  searchDeviceBlue() async {
    discover = flutterReactiveBle.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      discover.cancel();
      Get.find<TestController>().onEndTest(21, "pass");

      //code for handling results
    }, onError: (e) {
      //code for handling error
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                statusBle != BleStatus.ready
                    ? TextButton(
                        onPressed: () => AppSettings.openBluetoothSettings(),
                        child: Text('Turn on Bluetooth'))
                    : TextButton(
                        child: Text(
                          "start test",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () => {searchDeviceBlue()}),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: _isScaning ? Colors.red : Colors.blue,
        //   onPressed:  searchDevice,
        //   tooltip: 'scan',
        //   child: Icon(_isScaning ? Icons.stop : Icons.find_replace),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
