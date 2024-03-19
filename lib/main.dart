//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
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
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/withdrawal_receipt.dart';
import 'package:luround/views/account_owner/profile/widget/reviews/reviews_screen.dart';
import 'package:luround/views/account_viewer/404page/unknown_route.dart';
import 'package:luround/views/account_viewer/people_profile/screen/profile_page_acc_viewer.dart';
import 'package:luround/views/account_viewer/people_profile/widget/reviews_section/reviews_screen.dart';
import 'package:luround/views/account_viewer/people_profile/widget/reviews_section/write_review_screen.dart';
import 'package:luround/views/account_viewer/services/screen/services_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/transaction_successful_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/screen/book_a_service.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/request_quote_screen.dart';
import 'package:luround/views/account_viewer/web_routes/routes.dart';
import 'views/account_owner/mainpage/screen/mainpage.dart';
import 'package:firebase_core/firebase_core.dart';
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
      statusBarColor: AppColor.bgColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  //initializing the Paystack API in my app  
  await PaystackClient.initialize(publicKey);
  
  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //initialize get_storage
  await GetStorage.init();

  //check for existing fcmtoken
  var token = LocalStorage.getFCMToken();
  print("my_FCMtoken: $token");

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
  int tokenExpDate = LocalStorage.getTokenExpDate() ?? 0;
  var controller = Get.put(MainPageController());
  var authService = Get.put(AuthService());

  @override
  void initState() {
    //initialize firebase cloud messaging
    controller.initFCM(backgroundHandler: backgroundHandler);
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
        
        //register all routes for the web app here
        getPages: [
          
          GetPage(
            //parameters: {"user": userName},
            name: ProfileRoute,
            page: () => SplashScreenXtra2(),
            curve: Curves.bounceInOut
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
        //|| authService.checkForUserInactive(token: token)
        home: token == null || authService.isTokenExpired(tokenExpDate) || authService.checkForUserInactive(token: token) ? SplashScreenTokenExpired() : MainPage(),  //SplashScreenXtra2(), //MainPageAccViewer(),
      
      ),
    );
  }
}


