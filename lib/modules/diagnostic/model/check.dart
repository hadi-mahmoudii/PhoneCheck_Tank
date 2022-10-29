import 'package:phonecheck/modules/diagnostic/model/test.dart';

class Check {
  int id;
  int deviceId;
  int owner;
  int checker;
  int appVersion;
  List<Test> tests;
  String status;

  Check(
      {this.id,
      this.deviceId,
      this.owner,
      this.checker,
      this.appVersion,
      this.tests,
      this.status});

  Check.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    owner = json['owner'];
    checker = json['checker'];
    appVersion = json['app_version'];
    if (json['tests'] != null) {
      tests = <Test>[];
      for (var test in json['tests']) {
        tests.add(Test.fromJson(test));
      }
      print(tests);
      // tests.forEach((v) {
      //   tests.add(Test.fromJson(v as Map));
      // });
    }
    status = json['status'];
  }
}
