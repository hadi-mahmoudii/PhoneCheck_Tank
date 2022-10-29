import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

import '../../dashboard/widegt/loading_widget.dart';


// 5901@Tank110

               
 class ChargeScreen extends StatefulWidget {
  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen> {
int testId = 23;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<TestController>().onStartTest(23, 10);
  }
   

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
         
          body: Center(
            child: StreamBuilder<AndroidBatteryInfo>(
                stream: BatteryInfoPlugin().androidBatteryInfoStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data.pluggedStatus == "AC" || snapshot.data.pluggedStatus == "USB"){
                      Timer(Duration(seconds: 2),
                    () => Get.find<TestController>().onEndTest(testId, 'pass'));
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Phone is Charging'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.check_box_rounded,color: Colors.green,),
                  ],
                );
                    }else {
                     return Column(
                  children: [
                    Row(
                      children: const [
                        Text('Please connect Phone to Charger and Try Again'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.charging_station),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.find<TestController>().onStartTest(testId, 10);
                        },
                        child: const Text(
                          'Try Again',
                          style: TextStyle(color: Colors.redAccent),
                        )),
                  ],
                );
                    }
                  }
                  return LoadingWidget(mainFontColor: Colors.black,);
                }),
          ),
        ),
      ),
    );
  }
}