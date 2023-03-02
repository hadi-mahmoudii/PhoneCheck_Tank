import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';
import 'package:get/get.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
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
      initVolume = await VolumeWatcher.getCurrentVolume;
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
      Get.find<TestController>().onEndTest(5, 'pass' , description: 'pass');
    });
  }

  // volumeUp() {
  //   VolumeWatcher.addListener((double volume) async {
  //     if (currentVolume != 0) {
  //       print('volume : $volume and currnet : $currentVolume');
  //       v(volume);
  //     } else {
  //       currentVolume = volume;
  //     }
  //   });
  // }

  // volumeDown() {
  //   volumeDownSt = VolumeWatcher.addListener((double volume) {
  //     if (currentVolume != 0) {
  //       if (volume < currentVolume) {
  //         Get.find<TestController>().onEndTest(4, 'pass');
  //         volumeDownSt.cancel();
  //       }
  //     }
  //     currentVolume = volume;
  //   }) as StreamSubscription;
  // }

  volumeButtonsTest(int testId) {
    VolumeWatcher.addListener((double volume) {
      print('volume : $volume currnet : $currentVolume');

      if (testId == 4) {
        if (volume < currentVolume) {
          print('volume down pass');
          Get.find<TestController>().onEndTest(4, 'pass' , description: "pass");
        }
        currentVolume = volume;
      } else if (testId == 3) {
        currentVolume = 0;
        if (volume > currentVolume) {
          
          print('volume : $volume currnet : $currentVolume');
          Get.find<TestController>().onEndTest(3, 'pass' , description: 'pass');
        }
      }
    });
  }
}
