import 'dart:io';
import 'package:phonecheck/modules/diagnostic/model/check.dart';
import 'package:dio/dio.dart';
import 'package:phonecheck/modules/diagnostic/model/result.dart';
import 'service_handler.dart';

class DiagnosticService {
  static Future<Check> initCheck(checkerId, deviceId) async {
    Check check;
    check = await ServiceHandler()
        .initCheckHandler('diagnostic/init_check/', checkerId, deviceId);
    return check;
  }

  static Future<Result> initResult(int checkId, int testId, status,
      {resultId}) async {
    Result result;
    result =await ServiceHandler().initResultHandler("diagnostic/init_result/",
        checkId: checkId, testId: testId, status: status, resultId: resultId);
    return result;
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
