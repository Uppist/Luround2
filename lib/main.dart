import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/splashscreen/splashscreen_1.dart';
import 'views/account_owner/mainpage/screen/mainpage.dart';
import 'views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';







void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.bgColor,
      statusBarColor: AppColor.bgColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  //initialize get_storage
  await GetStorage.init();
  //var token = GetStorage().read("token");
  //print(token);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luround',
      home: SplashScreen1(), //MainPageAccViewer(), //MainPage(),
      supportedLocales: [
        Locale('en'), // English
      ]
      //home: SplashScreen(),
    );
  }
}


