import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';
import 'package:flutter_hardware_button_nullsafety/hardware_button_nullsafety.dart';
import 'package:get/get.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:phonecheck/modules/diagnostic/widegt/tests_commands.dart';
import 'package:volume_watcher/volume_watcher.dart';

class ButtonsController extends GetxController {
  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }

  String _platformVersion = 'Unknown';
  double currentVolume = 0;
  double initVolume = 0;
  double maxVolume = 0;
  bool minVolumeButton;
  bool maxVolumeButton;
  bool lockButton;
  var index = 0.obs;

  StreamSubscription volumeUpSt;
  StreamSubscription volumeDownSt;

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      VolumeWatcher.hideVolumeView = true;
      platformVersion = await VolumeWatcher.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    double initVolume;
    double maxVolume;
    try {
      currentVolume = await VolumeWatcher.getCurrentVolume;
      maxVolume = await VolumeWatcher.getMaxVolume;
    } on PlatformException {
      platformVersion = 'Failed to get volume.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    _platformVersion = platformVersion;
    this.initVolume = initVolume;
    this.maxVolume = maxVolume;
  }

  power() {
    ever(index, (Value) {
      Get.find<TestController>().onEndTest(5, 'pass', description: 'pass');
    });
  }

  volumeTest(int testId) {
    VolumeWatcher.addListener((volume) {
      print("volume : $volume current : ${currentVolume}");
      if (volume < currentVolume || testId == 4) {
      
        succesTest(4, "pass");
      } else if (volume > currentVolume || testId == 3) {
        succesTest(3, "pass");
      }
      currentVolume = volume;
    });
  }

  // volumeUpTest() {
  //   print('volume upp');

  //   VolumeWatcher.addListener((volume) {
  //     print("volume : $volume current : ${currentVolume}");
  //     if (volume > currentVolume) {
  //       print("doneeeeeeeeeeeeeeeeee");
  //       succesTest(3, "pass");
  //     } else {
  //       currentVolume = volume;
  //     }
  //   });
  // }
}
