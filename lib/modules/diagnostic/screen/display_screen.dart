// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

import '../widegt/dialogs.dart';

class DisplayScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DisplayScreenState();
}

class DisplayScreenState extends State<DisplayScreen> {
  bool testInProgress = false;
  List colors = [Colors.blue, Colors.red, Colors.white, Colors.green];
  int index = 0;
  Color statusColor = Colors.white;

  startTest() {
    setState(() {
      index = 0;
      testInProgress = true;
    });
  }

  @override
  void initState() {
    Get.find<TestController>().onStartTest(9, 10);
    super.initState();
  }

  nextTest() {
    setState(() {
      if (index + 1 == colors.length) {
        testInProgress = false;
        statusColor = Colors.white;
        askResultDialog(
          "display",
          9,
        );
      } else {
        index += 1;
        statusColor = colors[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusColor,
    ));
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: testInProgress
              ? GestureDetector(
                  onTap: () => {nextTest()},
                  child: Container(
                    width: screenWidth,
                    height: screenHeight,
                    color: colors[index],
                  ))
              : Container(
                  width: screenWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Display Test",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 0.5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () => {startTest()},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Start Test",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.screenshot_outlined)
                          ],
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
