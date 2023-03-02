import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:phonecheck/modules/core/constants/const.dart';

import '../../screen/cellular_screen.dart';
import '../../widegt/tests_commands.dart';
import '../inTests_controller.dart';

class WifiController extends GetxController {
  var _source = {ConnectivityResult.none: false};

  final MyConnectivity _connectivity = MyConnectivity.instance;
  var index = 0.obs;

  @override
  void onInit() {
    initialCellular();
    super.onInit();
  }

  initialCellular() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      _source = source;
      index++;
      print(_source);
      update();
    });
  }

  test(int testId) {
    print(_source.keys.toList()[0]);

    ever(index, (Value) {
      print(index);
      if (_source.keys.toList()[0] == ConnectivityResult.wifi) {
        Timer(Duration(seconds: 2), () {
succesTest(testId, 'pass' , desc: "pass");
        });
        
      } else if (_source.keys.toList()[0] == ConnectivityResult.mobile) {
        Get.dialog(WillPopScope(
          onWillPop: onWillPop,
          child: AlertDialog(
            content: Container(
                height: screenHeight / 9,
                width: screenWidth * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inTestDialog('Turn on', ' Wifi', 'wifi setting',
                        () => AppSettings.openWIFISettings(), Colors.green),
                    //  inTestDialog('Turn on',  'Data', 'Data setting', ()=> AppSettings.openWirelessSettings() , Colors.green),
                  ],
                )),
          ),
        ));
      }
    });
  }
}
