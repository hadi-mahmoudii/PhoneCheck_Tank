import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/model/check.dart';
import 'package:phonecheck/modules/diagnostic/model/device.dart';
import 'package:dio/dio.dart';
import 'package:phonecheck/modules/diagnostic/model/result.dart';

class DiagnosticService {
  static Future<Check> initCheck(checkerId, deviceId) async {
    Dio dio = Dio();
    try {
      final response = await dio.post("${apiUrl}diagnostic/init_check/",
          data: {'checker_id': checkerId, "device_id": deviceId},
          onReceiveProgress: (int send, int total) {
        // print((send / total) * 100);
      },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      Check check;
      if (response.statusCode == 200) {
        var responseBody = response.data['check'];
        print(responseBody);
        return Check.fromJson(responseBody);
      }

      return check;
    } catch (e) {
      print('daigonist service init check error');
      print(e);
    }
  }

  static Future<Result> initResult(int checkId, int testId, status,
      {resultId}) async {
    Dio dio = Dio();
    final response = await dio.post("${apiUrl}diagnostic/init_result/",
        data: {'check_id': checkId, "test_id": testId, "status": status},
        onReceiveProgress: (int send, int total) {
      // print((send / total) * 100);
    },
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    Result check;
    print('init resuelt part');
    print(response);
    if (response.statusCode == 200) {
      var responseBody = response.data['result'];

      return Result.fromJson(responseBody);
    }

    return check;
  }

  static Future<bool> checkNetConnect() async {
    Dio dio = Dio();
    final response = await dio.get("https://google.com",
        onReceiveProgress: (int send, int total) {},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
