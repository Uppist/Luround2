import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_1.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/xtra/extra_splashscreen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/withdrawal_receipt.dart';
import 'views/account_owner/mainpage/screen/mainpage.dart';
import 'views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';






var controller = Get.put(MainPageController());

//Top level non-anonymous function for FCM push notifications for background mode
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
}




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
  
  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //initialize get_storage
  await GetStorage.init();

  //initialize firebase cloud messaging
  controller.initFCM(backgroundHandler: backgroundHandler);

  //check for existing token from luround's backend server 
  var token = LocalStorage.getToken();
  var userId = LocalStorage.getUserID();
  print(token);
  print("my_id: $userId");

  runApp(const MainApp());
}





class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  var token = LocalStorage.getToken();

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
        home: token == null ? SplashScreen1() : MainPage(),  //SplashScreenXtra(), //MainPageAccViewer(),
        supportedLocales: [
          Locale('en'), // English Locale
        ]
      ),
    );
  }
}


