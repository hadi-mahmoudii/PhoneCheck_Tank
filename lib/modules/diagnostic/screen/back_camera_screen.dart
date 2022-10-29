// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

import '../widegt/dialogs.dart';

class BackCameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BackCameraScreenState();
}

class BackCameraScreenState extends State<BackCameraScreen> {
  List<CameraDescription> _cameras;
  CameraController controller;
  bool inProgress = true;

  @override
  void initState() {
    Get.find<TestController>().onStartTest(29, 15);
    initCamera();
    super.initState();
  }

  initCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
    setState(() {
      inProgress = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: inProgress ? Container() : CameraPreview(controller),
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondColor,
          onPressed: () => {
            askResultDialog("camera", 29)
          },
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
