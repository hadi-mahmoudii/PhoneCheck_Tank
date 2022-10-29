import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:dio/adapter.dart';

class DeviceService {
  static Future<int> initDevice(
    String id,
    String name,
    String model,
    String brand,
    String manufacturer,
    String product,
    String board,
    String hardware,
    String androidDeviceId,
    String fingerprint,
    String display,
    String release,
    String sdkInt,
    String previewSdkInt,
    String incremental,
    String securityPatch,
    String codename,
    String bootloader,
    String baseBand,
    String baseOS,
    String supportedAbis,
    String tags,
    String type,
    String androidId,
    String systemFeatures,
    String ram,
    String storage,
  ) async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      final response =
          await dio.post("${apiUrl}account/android_device/", data: {
        "serial": id,
        "name": name,
        "model": model,
        "brand": brand,
        "manufacturer": manufacturer,
        "product": product,
        "board": board,
        "hardware": hardware,
        "android_device_id": androidDeviceId,
        "fingerprint": fingerprint,
        "display": display,
        "release": release,
        "sdkInt": sdkInt,
        "preview_sdk_int": previewSdkInt,
        "incremental": incremental,
        "security_patch": securityPatch,
        "codename": codename,
        "bootloader": bootloader,
        "baseBand": baseBand,
        "baseOS": baseOS,
        "supported_abis": supportedAbis,
        "tags": tags,
        "type": type,
        "android_id": androidId,
        "system_features": systemFeatures,
        "ram": ram,
        "storage": storage,
      }, onReceiveProgress: (int send, int total) {
        // print((send / total) * 100);
      },
              options: Options(headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }));
      int deviceId;
      if (response.statusCode == 200) {
        deviceId = response.data['device_id'];
      }
      return deviceId;
    } catch (e) {
      print(e);
    }
  }
}
