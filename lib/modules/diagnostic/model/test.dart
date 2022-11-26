import 'package:phonecheck/modules/diagnostic/model/result.dart';

class Test {
  int id;
  String category;
  String title;
  String type;
  List<Result> results;
  String status;
  dynamic description ;
  bool hasDivider = true;


  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    type = json['type'];
    
    if (json['results'] != null) {
      results = <Result>[];
      for (var result in json['results']) {
        results.add(Result.fromJson(result));
      }
     
    }
  }
}
