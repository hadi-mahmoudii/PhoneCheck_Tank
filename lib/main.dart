import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/In_diagnostic_controller/buttons_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/inTests_controller.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:phonecheck/modules/diagnostic/screen/result_screen.dart';
import 'package:phonecheck/routes/app_pages.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  Get.put(HomeController(), permanent: true);
  Get.put(DiagnosticController(), permanent: true);
  Get.put(TestController(), permanent: true);
  Get.put(InTestsController(), permanent: true);

 

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
 
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  void initState() {
    super.initState();
    print('app life cycle');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      Get.find<ButtonsController>().index++;
    }
    print('state is $state');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return GetMaterialApp(
      defaultTransition: Transition.fade,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // supportedLocales: [
      //   Locale("fa", "IR"),
      // ],
      // locale: Locale("fa", "IR"),
      title: 'تانک',
      // theme: Themes.light,
      // darkTheme: Themes.dark,
      theme: ThemeData(
          fontFamily: FONTFAMILY,
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: Colors.black,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 20,
          )),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
  
    );
  }
}

