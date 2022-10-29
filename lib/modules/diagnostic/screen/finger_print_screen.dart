import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';



class FingerPrintScreen extends StatefulWidget {
  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  
  int testId = 27;

  @override
  void initState() {
    super.initState();
    startTest();
  }

  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } else {
      Get.find<TestController>()
          .onEndTest(testId, 'fail', status: testOptions.unsuportted);
    }
    print(isAuthenticated);
    return isAuthenticated;
  }

  startTest() async {
    bool result = await authenticateWithBiometrics();
    result == true
        ? Get.find<TestController>().onEndTest(testId, 'pass')
        : Get.find<TestController>().onEndTest(testId, 'fail');
  }

  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
         
        ),
      ),
    );
  }
}
