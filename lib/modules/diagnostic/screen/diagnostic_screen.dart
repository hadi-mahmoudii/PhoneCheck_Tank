// ignore_for_file: prefer_const_constructors

import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/dashboard/screen/qr_screen.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phonecheck/modules/diagnostic/model/test.dart';

class DiagnosticScreen extends StatelessWidget {
  const DiagnosticScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return GetBuilder<DiagnosticController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
            child: controller.check != null
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xFF262626),
                            borderRadius: BorderRadius.circular(cardRadius),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "${controller.testGroup[controller.categoryIndex]} Tests",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(cardRadius),
                                  border: Border.all(color: borderColor)),
                              width: screenWidth,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.categoryTests.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Test test = controller.categoryTests[index];
                                    return simpleListItem(test, index);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(vertical: 15),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Container(
                      //         alignment: Alignment.center,
                      //         width: screenWidth / 2 - 20,
                      //         height: 56,
                      //         decoration: BoxDecoration(
                      //             color: Color(0xFFDA1E28),
                      //             borderRadius:
                      //                 BorderRadius.circular(cardRadius)),
                      //         child: Text(
                      //           "Restart",
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.w500,
                      //               fontSize: 18),
                      //         ),
                      //       ),
                      //       GestureDetector(
                      //         onTap: () => {
                      //           controller.buildCurrentStatus(
                      //               controller.categoryIndex + 1)
                      //         },
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           width: screenWidth / 2 - 20,
                      //           height: 56,
                      //           decoration: BoxDecoration(
                      //               color: Color(0xFF0075FF),
                      //               borderRadius:
                      //                   BorderRadius.circular(cardRadius)),
                      //           child: Text(
                      //             "Next Test",
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 18),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Container(
                        height: 56,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(color: borderColor, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0;
                                i < controller.testGroup.length;
                                i++)
                              pendingCircle(i),
                            pendingCircle(controller.testGroup.length + 1),
                            // pendingCircle(testResult: "fail"),
                            // pendingCircle(testResult: "success"),
                            // pendingCircle(isActive: true),
                            // pendingCircle(),
                            // pendingCircle(),
                            // pendingCircle(),
                            // pendingCircle(),
                            // pendingCircle(),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: screenWidth / 2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/connect-device.png"))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Please Connect a device to PC using USB cable and scan QR code",
                              style: TextStyle(
                                  color: secondColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => {Get.to(QRScreen())},
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: secondColor,
                                borderRadius:
                                    BorderRadius.circular(cardRadius)),
                            alignment: Alignment.center,
                            child: Text(
                              "Scan Code And Start Test",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

pendingCircle(index, {testResult = null}) {
  bool isActive = false;
  if (index == Get.find<DiagnosticController>().categoryIndex) {
    isActive = true;
  }
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    width: 25,
    height: 25,
    decoration: BoxDecoration(
        border: Border.all(
            color: isActive ? secondColor : Colors.transparent, width: 2),
        borderRadius: BorderRadius.circular(28)),
    child: FractionallySizedBox(
      heightFactor: isActive ? 0.9 : 1,
      widthFactor: isActive ? 0.9 : 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 25,
          height: 25,
          decoration:((index > Get.find<DiagnosticController>().categoryIndex) || isActive)
              ? BoxDecoration(
                  color: Color(0xFFC6C6C6),
                  borderRadius: BorderRadius.circular(25))
              : BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/ok.png"))),
        ),
      ),
    ),
  );
}

simpleListItem(Test test, int index) {
  return GestureDetector(
    // onTap: ()=>{Get.find<DiagnosticController>().goNextTest()},
    onTap: () => {
      if (index > Get.find<DiagnosticController>().testIndex)
        toast("Do the previous test first")
      else
        Get.toNamed("/${test.title.replaceAll(' ', '')}")
    },
    child: SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    test.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: textColor),
                  ),
                  // Text(
                  //   test.description,
                  //   style: TextStyle(color: textColor),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                width: 25,
                height: 25,
                decoration: test.status == null || test.status == "in_progress"
                    ? BoxDecoration()
                    : BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(test.status == "pass"
                                ? "assets/images/ok.png"
                                : "assets/images/cancell.png"))),
                child: test.status == "in_progress"
                    ? SpinKitFadingCircle(
                        size: 25,
                        color: textGray,
                      )
                    : Container(),
              ),
            ],
          ),
          index < Get.find<DiagnosticController>().categoryTests.length - 1
              ? Container(
                  width: screenWidth,
                  height: 1,
                  color: borderColor,
                )
              : Container()
        ],
      ),
    ),
  );
}
