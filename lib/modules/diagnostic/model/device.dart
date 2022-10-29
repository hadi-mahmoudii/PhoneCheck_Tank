import 'package:phonecheck/modules/diagnostic/model/check.dart';

import 'device_android.dart';

class Device {
  int id;
  String serial;
  String brand;
  String model;
  String macId;
  int checkId;
  Check check;
  DeviceAndroid deviceAndroid;

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    brand = json['brand'];
    model = json['model'];
    macId = json['mac_id'];
    checkId = json['check_id'];
    check = json['check'] != null ? Check.fromJson(json['check']) : null;
    deviceAndroid = json['device_android'] != null
        ? DeviceAndroid.fromJson(json['device_android'])
        : null;
  }
}
