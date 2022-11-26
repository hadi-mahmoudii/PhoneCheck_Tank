import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';
import 'package:phonecheck/modules/diagnostic/repository/diagnostic_service.dart';

class ErrorHandler {
  var error;

  ErrorHandler(this.error, int checkId, int testId, status, {resultId}) {
    print('error handler');
    if (error.type == DioErrorType.response) {
      print('catched');
      return;
    }
    if (error.type == DioErrorType.connectTimeout) {
      SnackBar(
        content: Container(
          height: screenHeight / 10,
          width: screenWidth,
          child: TextButton(
              onPressed: () => DiagnosticService.initResult(
                  checkId, testId, status,
                  resultId: resultId),
              child: Text('Try Again')),
        ),
      );
      print('check your connection');
      return;
    }

    if (error.type == DioErrorType.receiveTimeout) {
      SnackBar(
          content: Container(
        height: screenHeight / 10,
        width: screenWidth,
        child: TextButton(
            onPressed: () => DiagnosticService.initResult(
                checkId, testId, status,
                resultId: resultId),
            child: Text('Try Again')),
      ));
      print('unable to connect to the server');
      return;
    }

    if (error.type == DioErrorType.other) {
      SnackBar(
          content: Container(
        height: screenHeight / 10,
        width: screenWidth,
        child: TextButton(
            onPressed: () => DiagnosticService.initResult(
                checkId, testId, status,
                resultId: resultId),
            child: Text('Try Again')),
      ));
      print('Something went wrong');
      return;
    }
    print(error);
  }
}
