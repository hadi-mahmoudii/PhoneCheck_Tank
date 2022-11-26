import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/diagnostic/controller/inTests_controller.dart';
import '../../../core/constants/const.dart';
import '../../screen/cellular_screen.dart';
import '../../widegt/tests_commands.dart';

class CellularController extends GetxController {
  var _source = {ConnectivityResult.none: false};

  final MyConnectivity _connectivity = MyConnectivity.instance;
  var index = 0.obs;
  bool isDone = false;

  @override
  void onInit() {
    initialCellular();
    super.onInit();
  }

  initialCellular() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      _source = source;
      isDone ? null : index++;
      print(_source);
      update();
    });
  }

  test(int testId) {
    print(_source.keys.toList()[0]);

    ever(index, (Value) {
      print(index);
      if (_source.keys.toList()[0] == ConnectivityResult.mobile) {
        isDone = true;
        succesTest(testId, 'pass');
      } else if (_source.keys.toList()[0] == ConnectivityResult.wifi) {
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
                    Flexible(
                      fit: FlexFit.loose,
                      child: inTestDialog('Turn off', ' Wifi', 'wifi setting',
                          () => AppSettings.openWIFISettings(), Colors.red),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: inTestDialog(
                          'Turn on',
                          ' Data',
                          'Data setting',
                          () => AppSettings.openWirelessSettings(),
                          Colors.green),
                    ),
                  ],
                )),
          ),
        ));
      }
    });
  }
}
