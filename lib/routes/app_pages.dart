import 'package:get/get.dart';
import 'package:phonecheck/modules/dashboard/screen/home_screen.dart';
import 'package:phonecheck/modules/dashboard/screen/splash_screen.dart';
import 'package:phonecheck/modules/diagnostic/model/result.dart';
import 'package:phonecheck/modules/diagnostic/screen/accelerometer_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/back_camera_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/bluetooth_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/cellular_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/charge_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/compass_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/display_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/earpiece_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/finger_print_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/flash_light_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/front_camera_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/hard_ware_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/headphone_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/light_sensor_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/microphone_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/multi_touch_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/pinch_zoom_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/proximity_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/result_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/speaker_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/touch_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/vibration_screen.dart';
import 'package:phonecheck/modules/diagnostic/screen/wifi_screen.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    //, binding: HomeBinding()),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.touch, page: () => TouchScreen()),
    GetPage(name: Routes.MultiTouch, page: () => MultiTouchScreen()),
    GetPage(name: Routes.Display, page: () => DisplayScreen()),
    GetPage(name: Routes.PinchZoom, page: () => PinchZoomScreen()),
    GetPage(name: Routes.Speaker, page: () => SpeakerScreen()),
    GetPage(name: Routes.Earpiece, page: () => EarpieceScreen()),
    GetPage(name: Routes.Microphone, page: () => MicrophoneScreen()),
    GetPage(name: Routes.Headphone, page: () => HeadphoneScreen()),
    GetPage(name: Routes.Accelerometer, page: () => AccelerometerScreen()),
    GetPage(name: Routes.Compass, page: () => CompassScreen()),
    GetPage(name: Routes.Wifi, page: () => WifiScreen()),
    GetPage(name: Routes.Cellular, page: () => CellularScreen()),
    GetPage(name: Routes.Bluetooth, page: () => BluetoothScreen()),
    GetPage(name: Routes.LightSensor, page: () => LightSensorScreen()),
    GetPage(name: Routes.Charge, page: () => ChargeScreen()),
    GetPage(name: Routes.Vibration, page: () => VibrationScreen()),
    GetPage(name: Routes.HardWare, page: () => HardWareScreen()),
    GetPage(name: Routes.Proximity, page: () => ProximityScreen()),
    GetPage(name: Routes.FingerPrint, page: () => FingerPrintScreen()),
    GetPage(name: Routes.BackCamera, page: () => BackCameraScreen()),
    GetPage(name: Routes.FrontCamera, page: () => FrontCameraScreen()),
    GetPage(name: Routes.FlashLight, page: () => FlashLightScreen()),
    GetPage(name: Routes.Result, page: ()=>ResultScreen()),
  ];
}
