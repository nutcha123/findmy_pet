import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants.dart';
import 'package:project/inject_controller.dart';
import 'package:project/screens/wrapper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'screens/login/login.dart';

void main() async {

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    
  WidgetsFlutterBinding.ensureInitialized();

  // connect Firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          onInit: () => injectDependencies(),
          debugShowCheckedModeBanner: false,

          // Use Flextheme
          theme: FlexThemeData.light(scheme: FlexScheme.blumineBlue).copyWith(

            textTheme: GoogleFonts.kanitTextTheme(),
          ),
          darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
          themeMode: ThemeMode.system,
          title: 'Project II',

          // Load accesstoken from storage
          home: !isAuth ? Login() : const Wrapper(),
           builder: EasyLoading.init(),
        );
      },
    );
  }
}
