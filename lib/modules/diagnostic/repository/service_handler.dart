import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/constants/const.dart';
import '../model/check.dart';
import '../model/result.dart';

class ServiceHandler {
  Dio dio = Dio();

  initResultHandler(String url,
      {int checkId, int testId, String status, resultId}) async {
    try {
      final response = await dio.post(apiUrl + url,
          data: {'check_id': checkId, "test_id": testId, "status": status},
          onReceiveProgress: (int send, int total) {
        // print((send / total) * 100);
      },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      if (response.statusCode == 200) {
        var responseBody = response.data['result'];
        print(response);
        return Result.fromJson(responseBody);
      } else if (response.statusCode >= 500) {
        SnackBarWidget(
            () => initResultHandler(url,
                checkId: checkId,
                testId: testId,
                status: status,
                resultId: resultId),
            1);
      }
    } catch (e) {
      print(e);
    }

    Result check;

    return check;
  }

  initCheckHandler(String url, checkerId, deviceId) async {
    try {
      final response = await dio.post(apiUrl + url,
          data: {'checker_id': checkerId, "device_id": deviceId},
          onReceiveProgress: (int send, int total) {
        // print((send / total) * 100);
      },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      Check check;
      print(response);
      if (response.statusCode == 200) {
        print('its Ok ');
        var responseBody = response.data['check'];
        print(responseBody);

        return Check.fromJson(responseBody);
      } else if (response.statusCode >= 500) {
        SnackBarWidget(() => initCheckHandler(url, checkerId, deviceId), 1);
      }

      return check;
    } catch (e) {
      print('daigonist service init check error');
      print(e);
    }
  }
}

class SnackBarWidget extends StatefulWidget {
  SnackBarWidget(this.function, this.duration);
  Function function;
  int duration;

  @override
  State<SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: Duration(days: widget.duration),
      content: const Text('we have a Problem Try again'),
      action: SnackBarAction(
        label: 'Try Again',
        onPressed: () {
          widget.function;
          setState(() {
            widget.duration = 0;
          });
        },
      ),
    );
  }
}
