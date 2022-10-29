class DeviceAndroid {
  int id;
  String serial;
  String model;
  String manufacturer;
  String product;
  String board;
  String hardware;
  String brand;
  String androidDeviceId;
  String fingerprint;
  String display;
  String release;
  String sdkInt;
  String previewSdkInt;
  String incremental;
  String securityPatch;
  String codename;
  String bootloader;
  String baseOs;
  String supportedAbis;
  String tags;
  String type;
  String androidId;
  String systemFeatures;

  DeviceAndroid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    model = json['model'];
    manufacturer = json['manufacturer'];
    product = json['product'];
    board = json['board'];
    hardware = json['hardware'];
    brand = json['brand'];
    androidDeviceId = json['android_device_id'];
    fingerprint = json['fingerprint'];
    display = json['display'];
    release = json['release'];
    sdkInt = json['sdk_int'];
    previewSdkInt = json['preview_sdk_int'];
    incremental = json['incremental'];
    securityPatch = json['security_patch'];
    codename = json['codename'];
    bootloader = json['bootloader'];
    baseOs = json['base_os'];
    supportedAbis = json['supported_abis'];
    tags = json['tags'];
    type = json['type'];
    androidId = json['android_id'];
    systemFeatures = json['system_features'];
  }
}
