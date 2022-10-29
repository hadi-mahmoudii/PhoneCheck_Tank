// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/core/widgets/CustomTabIndicator.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/dashboard/widegt/device_page/device_page.dart';
import 'package:phonecheck/modules/dashboard/widegt/main_page_dashboard/main_page.dart';
import 'package:phonecheck/modules/dashboard/widegt/system_page/system_page.dart';

import '../../diagnostic/screen/diagnostic_screen.dart' as a;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return GetBuilder<HomeController>(
      assignId: true,
      builder: (controller) {
        return WillPopScope(
          onWillPop: controller.exitApp,
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                  backwardsCompatibility: true,
                  // systemOverlayStyle:
                  //     SystemUiOverlayStyle(statusBarColor: Colors.white),
                  shape: Border(bottom: BorderSide(color: Colors.black12)),
                  elevation: 0,
                  // forceElevated: true,
                  backgroundColor: primaryColor,
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  actions: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: SvgPicture.asset("assets/images/logo-full.svg",
                          height: 32, color: Colors.black),
                    ),
          
       
                  ],
                  title: Text(
                    "Tank! Device Check",
                  )
                  // bottom:
                  ),
              body: Container(
                // padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 6),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      height: 46,
                      margin: EdgeInsets.only(bottom: 5),
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: secondColor,
                        indicator: CustomTabIndicator(),
                        controller: controller.tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: tabUnselectedColor,
                        tabs: [
                          Tab(child: Text("Dashboard")),
                          Tab(child: Text("Device")),
                          Tab(child: Text("System")),
                          Tab(child: Text("Tests")),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          MainPageDashboard(),
                          DevicePage(),
                         SystemPage(),
                          a.DiagnosticScreen()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  

 
}
