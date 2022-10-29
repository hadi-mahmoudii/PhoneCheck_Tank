import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/const.dart';
import '../../../controller/home_controller.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = screenHeight / 5;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor, width: 1))),
      height: height,
      child: Column(
        children: [
          Container(
            padding:const EdgeInsets.all(10),
            alignment: Alignment.center,
            height: height / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cardRadius),
                color: const Color(0xFFD6E9FF)),
            child: const AutoSizeText(
              "All sensors are tested automatically, Please enable GPS and Bluetooth in order to pass these tests",
              maxLines: 2,
              style: TextStyle(fontSize: 15, height: 1.5, color: textColor),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () => {Get.find<HomeController>().goToTab(3)},
            child: Container(
              height: height / 2 - 27,
              decoration: BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.circular(cardRadius)),
              alignment: Alignment.center,
              child: const Text(
                "Start Test",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
