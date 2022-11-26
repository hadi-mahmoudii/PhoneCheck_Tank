// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/dashboard/widegt/loading_widget.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:wifi_iot/wifi_iot.dart';

class CellularScreen extends StatefulWidget {
  @override
  _CellularScreenState createState() => _CellularScreenState();
}

class _CellularScreenState extends State<CellularScreen> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    Timer(Duration(seconds: 2),
        () => Get.find<TestController>().onEndTest(19, 'pass'));
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String string;

    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Cellular is On'),
              ),
              TextButton(
                  onPressed: () =>
                      Get.find<TestController>().onEndTest(19, 'pass'),
                  child: Text(
                    'start test',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        );

        break;
      case ConnectivityResult.wifi:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please Turn Off Wifi and Try Again'),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Get.find<TestController>().onEndTest(19, 'pass');
                    },
                    child: Text('Try Again')),
              ],
            ),
          ),
        );
        break;
      case ConnectivityResult.none:
      default:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Please Turn On Cellular'),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(
                      "Try Again",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ))
              ],
            ),
          ),
        );
    }
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
