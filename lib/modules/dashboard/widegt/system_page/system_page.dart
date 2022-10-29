import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/dashboard/widegt/simple_list_item.dart';

import '../../../core/constants/const.dart';

class SystemPage extends StatelessWidget {
  const SystemPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              width: screenWidth,
              height: screenWidth / 3,
              decoration: BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.circular(cardRadius)),
              child: Row(
                children: [
                  Container(
                    width: screenWidth / 3 - 20,
                    height: screenWidth / 3 - 20,
                    decoration: BoxDecoration(
                        color: const Color(0xFF3add85),
                        borderRadius: BorderRadius.circular(screenWidth / 4)),
                    child: Center(
                        child: AutoSizeText(
                      controller.deviceInfo['version.release'].toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 70),
                    )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Android ${controller.deviceInfo['version.release']}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "API Level  ${controller.deviceInfo['version.sdkInt']}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Released : ${controller.deviceInfo['version.securityPatch']}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(cardRadius),
                  border: Border.all(color: borderColor)),
              width: screenWidth,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  simpleListItem("Code name",
                      "${controller.deviceInfo['version.codename']}"),
                  simpleListItem("API Level",
                      "${controller.deviceInfo['version.sdkInt']}"),
                  simpleListItem("Security Patch Level",
                      "${controller.deviceInfo['version.securityPatch']}"),
                  simpleListItem(
                      "BootLoader", "${controller.deviceInfo['bootloader']}"),
                  simpleListItem("Build Number", "1"),
                  simpleListItem(
                      "Baseband", "${controller.deviceInfo['version.baseOS']}"),
                  simpleListItem("32 Bit",
                      "${controller.deviceInfo['supported32BitAbis']}"),
                  simpleListItem("64 Bit",
                      "${controller.deviceInfo['supported64BitAbis']}"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );
    });
  }
}
