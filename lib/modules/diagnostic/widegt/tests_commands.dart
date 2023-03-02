import 'package:get/get.dart';

import '../controller/test_controller.dart';

succesTest(int testId, String type , {String desc}) {
  Get.find<TestController>().onEndTest(testId, type);
}

startTest(int testId, int seconds) {
  Get.find<TestController>().onStartTest(testId, seconds);
}
