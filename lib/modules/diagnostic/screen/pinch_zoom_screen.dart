import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class PinchZoomScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PinchZoomScreenState();
}

class PinchZoomScreenState extends State<PinchZoomScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Get.find<TestController>().onStartTest(10, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: Center(
        child: PinchZoom(
          child: Image.asset('assets/images/zoom.png'),
          resetDuration: const Duration(milliseconds: 100),
          maxScale: 2.5,
          onZoomStart: () {
            Get.find<TestController>()
                .onEndTest(10, "pass", );
          },
          onZoomEnd: () {
            print('Stop zooming');
          },
        ),
      )),
    );
  }
}
