import 'dart:io';

import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/widegt/error_handler.dart';
import 'package:phonecheck/modules/diagnostic/model/check.dart';
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
      print(response);
      if (response.statusCode == 200) {
        var responseBody = response.data['check'];

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
    try {
      final response = await dio.post("${apiUrl}diagnostic/init_result/",
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
      }
    } on DioError catch (e) {
      ErrorHandler(e, checkId, testId, status);
      return null;
    } catch (e) {
      print(e);
    }

   

    Result check;

    return check;
  }

  // var res= await MyRequest.get("hfjykl",data:{asd})
// static get(url,{data,asghar}) async{
//      Dio dio = Dio();
//     try {
//       final response = await dio.post("${apiUrl}${url}",
//           data:data,
//           onReceiveProgress: (int send, int total) {
//         // print((send / total) * 100);
//       },
//           options: Options(headers: {
//             HttpHeaders.contentTypeHeader: "application/json",

//           }));
//      if (response.statusCode >= 500) {
//      Get.dialog()
//      }

//       if (response.statusCode == 200) {
//         var responseBody = response.data['result'];
//         print(response);
//         return Result.fromJson(responseBody);
//       }
//     } on DioError catch (e) {
//       ErrorHandler(e, checkId, testId, status);
//       return null;
//     } catch (e) {
//       print(e);
//     }
// }
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
