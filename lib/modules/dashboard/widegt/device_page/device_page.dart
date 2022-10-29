import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/dashboard/widegt/simple_list_item.dart';

import '../../../core/constants/const.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      
      builder: (controller) {
        return Container(
                                padding:const  EdgeInsets.symmetric(horizontal: 10),
                                child: ListView(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(cardRadius),
                                          border: Border.all(color: borderColor)),
                                      width: screenWidth,
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          simpleListItem("Device name",
                                              controller.deviceInfo['device']),
                                          simpleListItem("Model",
                                              controller.deviceInfo['model']),
                                          simpleListItem(
                                              "Manufacturer",
                                              controller
                                                  .deviceInfo['manufacturer']),
                                          simpleListItem("Device",
                                              controller.deviceInfo['product']),
                                          simpleListItem("Board",
                                              controller.deviceInfo['board']),
                                          simpleListItem("Hardware",
                                              controller.deviceInfo['hardware']),
                                          simpleListItem("Brand",
                                              controller.deviceInfo['brand']),
                                          simpleListItem("Android Device ID",
                                              controller.deviceInfo['id']),
                                          simpleListItem("Build Fingerprint",
                                              controller.deviceInfo['fingerprint']),
                                          simpleListItem("Display",
                                              controller.deviceInfo['display']),
                                          simpleListItem(
                                              "Host", controller.deviceInfo['host'],
                                              hasDivider: false),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              );
      }
    );
  }
}