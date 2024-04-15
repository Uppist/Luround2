//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/payment_service.dart/paystack_constant.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_1.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/xtra/extra_splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:luround/views/account_viewer/404page/unknown_route.dart';
import 'package:luround/views/account_viewer/web_routes/routes.dart';
import 'firebase_options.dart';
//import 'package:flutter_web_plugins/url_strategy.dart';








var controller = Get.put(MainPageController());
//Top level non-anonymous function for FCM push notifications for background mode
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.data}');
  controller.displayNotification(message);
}


void main() async{
  

  WidgetsFlutterBinding.ensureInitialized();
  //keep beneath this widgetflutterbinding widget
  //usePathUrlStrategy();
  
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.bgColor,
      statusBarColor: Colors.transparent, //AppColor.bgColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  //initializing the Paystack API in my app  
  await PaystackClient.initialize(publicKey);

  //initialize get_storage
  await GetStorage.init();
  
  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //FCM Instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //Get Unique FCM DEVICE TOKEN AND SAVE TO GETSTORAGE()
  String? token = await messaging.getToken();
  await LocalStorage.saveFCMToken(token!);
  debugPrint("raw fcm token: $token");

  runApp(const MainApp());


}







class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  
  var token = LocalStorage.getToken();
  var FCMtoken = LocalStorage.getFCMToken();
  var tokenExpDateInt = LocalStorage.getTokenExpDate();
  var controller = Get.put(MainPageController());
  var authService = Get.put(AuthService());


  bool isExpiredVal = false;
  //checks if the token is expired
  Future<bool> isTokenExpired() async{
    bool isExpired = await FlutterSessionJwt.isTokenExpired();
    setState(() {
      isExpiredVal = isExpired;
    });
    print("is token expired: $isExpiredVal");
    return isExpired;
  }


  @override
  void initState() {

    //initialize firebase cloud messaging
    
    controller.initFCM(backgroundHandler: backgroundHandler);
    
    print("initialize fcm token $FCMtoken");
    print('token exp: $tokenExpDateInt');
    isTokenExpired();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    //Access a query parameter from the web url using "Get.parameters['']"
    String userName = Get.parameters['user'] ?? 'DefaultUserName';
 
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) {
        return child!;
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Luround',
        
        //try this
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
          useMaterial3: true,
        ),
        defaultTransition: Transition.rightToLeft,
        
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
        
        //register all routes for the web app here
        getPages: [
          
          GetPage(
            //parameters: {"user": userName},
            name: ProfileRoute,
            page: () => SplashScreenXtra2(),
            curve: Curves.bounceInOut,
            transition: Transition.rightToLeft
          ),


          /*GetPage(
            parameters: {"user": userName},

            name: ReviewsRoute,
            page: () => AccViewerReviewsPage(),
            curve: Curves.bounceInOut,
          ),
          GetPage(
            parameters: {"user": userName},
            name: RequestQuoteRoute,
            page: () => RequestQuoteScreen(),
            curve: Curves.easeInOut,
          ),
          GetPage(
            parameters: {"user": userName},
            name: BookingsRoute,
            page: () => BookAppointmentScreen(),
            curve: Curves.easeInOut,
          ),
          GetPage(
            parameters: {"user": userName},
            name: WriteReviewRoute,
            page: () => WriteReviewsPage(),
            curve: Curves.easeOutSine,
          ),*/

        ],*/

        home: token == null ? SplashScreen1() : isExpiredVal ? SplashScreenTokenExpired() : authService.checkForUserInactive(token: token) ? SplashScreenTokenExpired() : SplashScreenXtra(),
      
      ),
    );
  }
}


