import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/routes/web_routes.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/payment_service.dart/paystack_constant.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_1.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/xtra/extra_splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:flutter_web_plugins/url_strategy.dart';





// Define a GlobalKey<NavigatorState> for functional navigation
//GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//to display EURO currency
NumberFormat currency(context) {
  //String os = Platform.operatingSystem;
  //if(Platform.isAndroid)
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN");
  //print("CURRENCY SYMBOL: ${format.currencySymbol}");
  //print("CURRENCY NAME: ${format.currencyName}");
  return format;
}



//Top level non-anonymous function for FCM push notifications for background mode
var controller = Get.put(MainPageController());
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
    //String userName = Get.parameters['user'] ?? 'DefaultUserName';
 
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
        
        home: token == null ? const SplashScreen1() : isExpiredVal ? const SplashScreenTokenExpired() : authService.checkForUserInactive(token: token) ? const SplashScreenTokenExpired() : const SplashScreenXtra(),
      
      ),
    );

    /*return ScreenUtilInit(
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
        
        //unknown route
        unknownRoute: GetPage(
          name: '/', 
          page: () => UnknownPage(
            onPressed: () {}     
          )
        ),
        
        //traditional way of registering routes without getx
        /*routes: {
          '/': (context) => HomeScreen(),
          '/destination': (context) => DestinationScreen(argument: ''),
        },*/

        initialRoute: SplashPageRoute,
        
        //register all routes for the web app here
        getPages: [
          
          GetPage(
            name: LoginPageRoute,
            page: () => LoginPage(),
            curve: Curves.bounceInOut,
            transition: Transition.rightToLeft
          ),


          /*GetPage(
            name: ReviewsRoute,
            page: () => AccViewerReviewsPage(),
            curve: Curves.bounceInOut,
            transition: Transition.rightToLeft
          ),
          GetPage(
            name: BookingsRoute,
            page: () => RequestQuoteScreen(),
            curve: Curves.easeInOut,
            transition: Transition.rightToLeft
          ),
          GetPage(
            name: BookingsRoute,
            page: () => BookAppointmentScreen(),
            curve: Curves.easeInOut,
            transition: Transition.rightToLeft
          ),
          GetPage(
            name: WriteReviewRoute,
            page: () => WriteReviewsPage(),
            curve: Curves.easeOutSine,
            transition: Transition.rightToLeft
          ),*/

        ],

      
      ),
    );*/

  }
}


