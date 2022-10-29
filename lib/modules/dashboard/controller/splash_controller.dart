import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/dashboard/repository/device_service.dart';
import 'package:phonecheck/modules/dashboard/screen/splash_screen.dart';
import 'dart:async';
import 'package:phonecheck/routes/app_pages.dart';
import 'package:device_information/device_information.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();
  var checkedLogin = false;

  @override
  void onInit() {
    super.onInit();
    checkNetConnect();
  }

  Future<String> getId() async {
    var status = await Permission.phone.status;
    print(status);
    if (await Permission.phone.request().isGranted) {
      return await DeviceInformation.deviceIMEINumber;
    } else {
      await Permission.phone.request();
      getId();
    }
  }

  Future<void> checkNetConnect() async {
    Dio dio = Dio();
    try {
      final response = await dio.get("https://google.com",
          onReceiveProgress: (int send, int total) {},
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      if (response.statusCode == 200) {
        goToHome();
      }
    } catch (e) {
      Get.defaultDialog(
          content: Center(
        child: Column(
          children: [
            const Text('please connect your phone to internet and try again'),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                  SplashController().checkNetConnect();
                },
                child: const Text("try again"))
          ],
        ),
      ));
    }
  }

  goToHome() async {
    await Get.find<HomeController>().setStaticInfo();
    String id = await getId();
    Map<String, dynamic> deviceInfo = Get.find<HomeController>().deviceInfo;
    int deviceId = await DeviceService.initDevice(
      id,
      Get.find<HomeController>().deviceMarketingNames.deviceNames,
      deviceInfo['model'],
      deviceInfo['brand'],
      deviceInfo['manufacturer'],
      deviceInfo['product'],
      deviceInfo['board'],
      deviceInfo['hardware'],
      deviceInfo['id'],
      deviceInfo['fingerprint'],
      deviceInfo['display'],
      deviceInfo['version.release'],
      deviceInfo['version.sdkInt'].toString(),
      deviceInfo['version.previewSdkInt'].toString(),
      deviceInfo['version.incremental'],
      deviceInfo['version.securityPatch'],
      deviceInfo['version.codename'],
      deviceInfo['bootloader'],
      deviceInfo['baseBand'],
      deviceInfo['version.baseOS'],
      deviceInfo['supportedAbis'].toString(),
      deviceInfo['tags'],
      deviceInfo['type'],
      deviceInfo['androidId'],
      deviceInfo['systemFeatures'].join("%"),
      Get.find<HomeController>().totalRam.toString(),
      Get.find<HomeController>().diskTotalSpace.toString(),
    );
    print(deviceId);

    if (deviceId != null) {
      Get.find<HomeController>().deviceId = deviceId;
      Get.offAndToNamed(Routes.HOME);
    } else {
      Get.defaultDialog(
         
          content: Center(
            child: Column(
              children: [
                const Text(
                  'look like we have problem please try again',
                  // maxLines: 1,
                  style: TextStyle(fontSize: 13),
                
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                      SplashController().checkNetConnect();
                    },
                    child: const Text("try again"))
              ],
            ),
          ));
    }
  }
}