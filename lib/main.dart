import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/test.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_1.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/xtra/extra_splashscreen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/withdrawal_receipt.dart';
import 'package:luround/views/account_viewer/people_profile/screen/profile_page_acc_viewer.dart';
import 'package:luround/views/account_viewer/services/screen/services_screen.dart';
import 'views/account_owner/mainpage/screen/mainpage.dart';
import 'views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';






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
        //unknownRoute: GetPage(name: '/unknown', page: () => 404Page()),
        /*routes: {
          '/': (context) => HomeScreen(),
          '/destination': (context) => DestinationScreen(argument: ''),
        },*/
        /*initialRoute: '/profile',
        onGenerateRoute: (settings) {
           
          var startParamIndex = settings.name?.indexOf('=');
          var fragmentEndIndex = settings.name?.indexOf('?');
          if (settings.name != null &&
              startParamIndex != -1 &&
              startParamIndex != null &&
              settings.name?.substring(0, fragmentEndIndex) == '/profile'
            ) {
              var name = settings.name!;
              var queryParameter = name.substring(startParamIndex).replaceFirst('=', '');
              return MaterialPageRoute(
                builder: (_) =>
                  AccViewerProfilePage(userName: queryParameter)
              );
            } else {
              return MaterialPageRoute(
                builder: (_) => AccViewerProfilePage(userName: 'noting'));
            }
      
          
          /*if (settings.name == '/profile') {
            //var uriData = Uri.parse(settings.name!);
            // Extract the username from the query parameters
            final Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

            // Access the 'user' parameter
            String userName = arguments?['user'] ?? 'kds-osx';
            // Return a GetPageRoute with the destination screen and pass the argument
            return GetPageRoute(
              page: () => AccViewerProfilePage(userName: userName),
            );
          }
          if (settings.name == '/services') {
            // Extract the username from the query parameters
            final Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

            // Access the 'user' parameter
            String userName = arguments?['user'] ?? 'kds-osx';

            // Return a GetPageRoute with the destination screen and pass the argument
            return GetPageRoute(
              page: () => AccViewerServicesPage(userName: userName),
            );
          }
          // Handle other named routes here if needed
          // Return null for routes that are not defined
          return null;*/


        },

        getPages: [
          GetPage(
            name: '/profile',
            page: () {
              final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;

              // Access the 'user' parameter
              String userName = arguments?['user'] ?? '';
      
              return AccViewerProfilePage(userName: userName);
            },
          ),
          GetPage(
            name: '/services',
            page: () {
              final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
              // Access the 'user' parameter
              String userName = arguments?['user'] ?? 'kds-osx';
              return AccViewerServicesPage(userName: userName);
            },
          ),
        ],*/

        home: token == null ? SplashScreen1() : MainPage(),  //SplashScreenXtra2(), //MainPageAccViewer(),
        supportedLocales: [
          Locale('en'),
        ]
      ),
    );
  }
}


