import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_1.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/xtra/extra_splashscreen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/withdrawal_receipt.dart';
import 'package:luround/views/account_viewer/404page/unknown_route.dart';
import 'package:luround/views/account_viewer/people_profile/screen/profile_page_acc_viewer.dart';
import 'package:luround/views/account_viewer/services/screen/services_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/transaction_successful_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/request_quote_screen.dart';
import 'package:luround/web_routes/routes.dart';
import 'views/account_owner/mainpage/screen/mainpage.dart';
import 'views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:flutter_web_plugins/url_strategy.dart';





var controller = Get.put(MainPageController());


//flutter local notifications fuckkinngg worked.. finallyyyyy
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//Top level non-anonymous function for FCM push notifications for background mode
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notification', //title
    importance: Importance.high
  );

  //added this to catch the back ground push notification and display it in foreground cause user may be using the app
  flutterLocalNotificationsPlugin.show(
    message.data.hashCode, 
    message.data['title'], 
    message.data['body'], 
    NotificationDetails(
      android: AndroidNotificationDetails(channel.id, channel.name,)
    )
  );
}




void main() async{
  

  WidgetsFlutterBinding.ensureInitialized();
  //keep beneath this widgetbinding widget
  //usePathUrlStrategy();
  
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
  int tokenExpDate = LocalStorage.getTokenExpDate() ?? 0;
  var authService = Get.put(AuthService());




  @override
  Widget build(BuildContext context) {
    
    // Access the parameter using Get.parameters['userName']
    String userName = Get.parameters['user'] ?? 'DefaultUserName';
 
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) {
        return child!;
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Luround',
        
        /*unknownRoute: GetPage(
          name: '/', 
          page: () => UnknownPage(
            onPressed: () {}     
          )
        ),
        
        /*routes: {
          '/': (context) => HomeScreen(),
          '/destination': (context) => DestinationScreen(argument: ''),
        },*/

        initialRoute: ProfileRoute,

        defaultTransition: Transition.fade,

        getPages: [
          
          GetPage(
            name: ProfileRoute,
            page: () {
              return SplashScreenXtra2();},
          ),
        ],*/

        home: token == null || authService.isTokenExpired(tokenExpDate) ? SplashScreen1() : MainPage(),  //SplashScreenXtra2(), //MainPageAccViewer(),
      ),
    );
  }
}


