import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:volume_watcher/volume_watcher.dart';
import 'package:is_lock_screen/is_lock_screen.dart';

import '../controller/test_controller.dart';

class HardWareScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HardWareScreenState();
}

class HardWareScreenState extends State<HardWareScreen>
    with WidgetsBindingObserver {
  String _platformVersion = 'Unknown';
  double currentVolume = 0;
  double initVolume = 0;
  double maxVolume = 0;
  bool minVolumeButton;
  bool maxVolumeButton;
  bool lockButton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<TestController>().onStartTest(25,15  );
    initPlatformState();
    WidgetsBinding.instance?.addObserver(this);
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
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
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      this.initVolume = initVolume;
      this.maxVolume = maxVolume;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      setState(() {
        lockButton = true;
        checkDoneTest();
      });
      print('app inactive, is lock screen: ${await isLockScreen()}');
    } else if (state == AppLifecycleState.resumed) {
      print('app resumed');
    }
  }

  checkDoneTest() {
    if (maxVolumeButton & minVolumeButton & lockButton) {
      Get.find<TestController>().onEndTest(25,"pass");
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
              children: <Widget>[
                VolumeWatcher(
                  onVolumeChangeListener: (double volume) {
                    print(currentVolume);
                    setState(() {
                      if (currentVolume != 0) {
                        if (volume > currentVolume) {
                          maxVolumeButton = true;
                        }
                        if (volume < currentVolume) {
                          minVolumeButton = true;
                        }
                      }
    
                      currentVolume = volume;
                    });
                  },
                ),
                // Text("platformVersion=${_platformVersion}"),
                Text(
                    "maxVolume=${maxVolumeButton != null ? maxVolumeButton ? "pass" : "fail" : "pending"}"),
                Text(
                    "minVolume=${minVolumeButton != null ? minVolumeButton ? "pass" : "fail" : "pending"}"),
                Text(
                    "lockScreenButton=${lockButton != null ? lockButton ? "pass" : "fail" : "pending"}"),
                // Text("initVolume=${initVolume}"),
                Text("currentVolume=${currentVolume}"),
                // RaisedButton(
                //   onPressed: () {
                //     VolumeWatcher.setVolume(maxVolume * 0.5);
                //   },
                //   child: Text("setVolume:${maxVolume * 0.5}"),
                // ),
                // RaisedButton(
                //   onPressed: () {
                //     VolumeWatcher.setVolume(maxVolume * 0.0);
                //   },
                //   child: Text("setVolume:${maxVolume * 0.0}"),
                // )
              ]),
        ),
      ),
    );
  }
}
