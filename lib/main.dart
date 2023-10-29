import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'views/account_owner/mainpage/screen/mainpage.dart';







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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luround',
      home: MainPage(),  //MainPageAccViewer(),
      supportedLocales: [
        Locale('en'), // English
      ]
      //home: SplashScreen(),
    );
  }
}


