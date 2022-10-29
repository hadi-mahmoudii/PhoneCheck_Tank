// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/dashboard/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    preHeight = screenHeight / 100;
    preWidth = screenWidth / 100;
    toolBar = MediaQuery.of(context).padding.top + (kToolbarHeight / 1.5);
    tabBar = (MediaQuery.of(context).padding.bottom + kTextTabBarHeight);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 117, 255, 0.9),
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
 

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => {Get.find<SplashController>().goToHome()},
        // ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash-bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Color.fromRGBO(0, 117, 255, 0.9),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth / 2.2,
                          child: SvgPicture.asset("assets/images/logo-full.svg",
                              width: screenWidth / 1.5, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "بررسی تخصصی سلامت دستگاه شما",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: SizedBox(
                      width: 80,
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
