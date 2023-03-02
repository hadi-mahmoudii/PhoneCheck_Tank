import 'dart:async';
import 'dart:math';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:device_apps/device_apps.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:system_info2/system_info2.dart';

import 'package:phonecheck/modules/core/class/chart_sample_data.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeController get to => Get.find();
  int deviceId;
  DateTime currentBackToExitPressTime;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final deviceMarketingNames = DeviceMarketingNames();
  TabController tabController;
  int freeRam = 0;
  int usedRam = 0;
  int usedRamPercent = 0;
  int totalRam = 0;
  int sensorCount = 0;
  Timer timer;
  int megaByte = 1024 * 1024;
  Map<String, dynamic> deviceInfo;
  Random random = Random();
  int batteryLevel = 0;
  int batteryVoltage = 0;
  int batteryTemperature = 0;
  bool isInCharge = false;
  List<Application> apps;
  CpuInfo cpuInfo;

  bool isTestInProgress = false;
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(
        x: "1", y: (SysInfo.getTotalVirtualMemory() ~/ (1024 * 1024))),
  ];
  List cpuCores = [];
  double diskFreeSpace = 0;
  double diskTotalSpace = 0;
  int max = 1000;
  int min = 0;

  @override
  onInit() async {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    // await setStaticInfo();
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => getResource());
  }

  goToTab(index) {
    tabController.animateTo(index);
  }

  List<SplineSeries<ChartSampleData, String>> getDefaultSplineSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        animationDuration: 0.1,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        markerSettings: const MarkerSettings(isVisible: false),
        color: Colors.white,
        width: 2,
        name: 'High',
      ),
    ];
  }

  setStaticInfo() async {
    totalRam = SysInfo.getTotalVirtualMemory() ~/ megaByte;
    deviceInfo = getDeviceInfo(await deviceInfoPlugin.androidInfo);
    sensorCount = (deviceInfo['systemFeatures']).length;
    batteryVoltage = (await BatteryInfoPlugin().androidBatteryInfo).voltage;
    apps = await DeviceApps.getInstalledApplications();
    cpuInfo = await CpuReader.cpuInfo;
    diskFreeSpace = await DiskSpace.getFreeDiskSpace;
    diskTotalSpace = await DiskSpace.getTotalDiskSpace;
    final singleDeviceName = await deviceMarketingNames.getSingleName();
    update();
  }

  getResource() async {
    List tempCores = [];
    int numberOfCores =  cpuCores.length;
    for (var i = 1; i <= numberOfCores; i++) {
      int freq = await CpuReader.getCurrentFrequency(i);
      tempCores.add({"core": i, "freq": freq});
    }
    cpuCores = tempCores;
    // totalRam = SysInfo.getTotalPhysicalMemory() ~/ megaByte;
    // freeRam = (SysInfo.getFreePhysicalMemory() ~/ megaByte);
    batteryLevel = (await BatteryInfoPlugin().androidBatteryInfo).batteryLevel;

    batteryTemperature =
        (await BatteryInfoPlugin().androidBatteryInfo).temperature;

    freeRam = (SysInfo.getFreeVirtualMemory() ~/ megaByte);
    usedRam = totalRam - freeRam;
    usedRamPercent = ((usedRam / totalRam) * 100).round();
    ChartSampleData last = chartData.last;
    chartData.add(
        ChartSampleData(x: (int.parse(last.x) + 1).toString(), y: usedRam));
    if (chartData.length > 30) {
      chartData =
          chartData.getRange(chartData.length - 30, chartData.length).toList();
    }
    min = max;
    max = 0;
    for (var data in chartData) {
      if ((data.y * 1.1).toInt() > max) {
        max = data.y;
      }
      if (data.y ~/ 1.1 < min) {
        min = data.y;
      }
    }
    max = (max * 1.1).toInt();
    min = min ~/ 1.1;
    if ((await BatteryInfoPlugin().androidBatteryInfo).pluggedStatus == "AC" ||
        (await BatteryInfoPlugin().androidBatteryInfo).pluggedStatus == "USB") {
      isInCharge = true;
    } else {
      isInCharge = false;
    }

    update();
  }

  Map<String, dynamic> getDeviceInfo(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      // 'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Future<bool> exitApp() {
    DateTime now = DateTime.now();
    if (currentBackToExitPressTime == null ||
        now.difference(currentBackToExitPressTime) > Duration(seconds: 2)) {
      currentBackToExitPressTime = now;
      // toast("برای خروج دوباره کلیک کنید");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
