import 'package:phonecheck/modules/diagnostic/model/result.dart';

class Test {
  int id;
  String category;
  String title;
  String type;
  List<Result> results;
  String status;
  String description = "";
  bool hasDivider = true;

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    type = json['type'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results.add(Result.fromJson(v));
      });
    }
  }
}
