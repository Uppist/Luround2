import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_1.dart';
import 'views/account_owner/mainpage/screen/mainpage.dart';
import 'views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';









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
  //check for existing token
  var token = LocalStorage.getToken();
  print(token);
  // Initialize GoogleSignIn
  //final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']); // Initialize with the necessary scopes
  //GoogleSignIn().signInSilently();

  runApp(const MainApp());
}





class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  var token = LocalStorage.getToken();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']); // Initialize with the necessary scopes

  @override
  void initState() {
    // TODO: implement initState
    void _initGoogleSignIn() async {
      try {
        await _googleSignIn.signInSilently();
      } catch (error) {
        print('Error initializing Google Sign-In: $error');
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) {
        return child!;
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Luround',
        home: token == null ? SplashScreen1() : MainPage(), //MainPageAccViewer(), //MainPage(), //SplashScreen1()
        supportedLocales: [
          Locale('en'), // English Locale
        ]
      ),
    );
  }
}


