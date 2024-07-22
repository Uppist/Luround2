import 'dart:convert';
import 'dart:developer';
import 'dart:io';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/screen/bookings_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/more/screen/more_screen.dart';
import 'package:luround/views/account_owner/services/screen/main_service_screen.dart';
import '../../../views/account_owner/profile/screen/profile_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';








class MainPageController extends getx.GetxController {

  final getx.RxString accessTokenString = ''.obs;

  //get oAuth2.0 access token
  Future<String> getAccessToken() async {

    final accountCredentials = ServiceAccountCredentials.fromJson(
      //File(serviceAccountPath).readAsStringSync(),
      {
        "type": "service_account",
        "project_id": "luround-japhet",
        "private_key_id": "d878fe802a993831efa62c72d29d267092754c87",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8C8Acahk7yhQu\nOG8958MWWeNtLEw0QSMgzQKsK8nwdl2JJxDsJc6ofzuWOMYtApHX9gPZ5Nw3P9Mc\nX21lKoRJO7ii6X69tW8te2tSO9xh/IOSpi6y8FYRWWVK6vJ2Jx8B4YB4zqV2Te0n\nE3qgydmOyxipb6jcfNA2iZaZIXHyaqkhbql+wBNKIaL2WCiEbAB2b4F958qrr/jL\n0qbn9dLqCVLHXBTH5vZf2WplHXqhIw3MBre+56uDk14P3tRV87XdDoM9HxuDcNsl\nYiNBuhIrjI21Ld3dJurn8bhoeH00C/RgFidYVSN7R2frWdolTCxy/JHT9Zvh5apS\nSt9QEX2FAgMBAAECggEALiTsBYz7mDJkdVsf4R8IPmncZyPhp0j8p8XnC/zK1xkU\npt1RR8GXTr26D4jrCIyC4W3bUBLa/yvIUEQSgirGv3nKOx/1G/RzzcNleI577Aec\n+dWRzBMx65v2QUYaLWg4Mav2bK6456kDsv0SsHYXzvSDnsBpvYFbTqbAr98HKScb\nMGDEbfRCsqfS21IVBVBvBDcD3GbLt8/0lHNa22v61Yhq1zbtuMmQXurjB/1HeNUv\n68qg8IxUEDwi7qtmcMg9iHhArQAny9HhFIZCWlzjISJ6bilhZOszbrfOS54HA9WZ\nGogNYJ8q1Rz4ENYNB5gHyQ7Jo8wwxiy4SkMSXT8bGQKBgQDv++k6c77gGGzC+qUx\nv/wEP6n6KVnXEuQ4U+wuzNrnxGD1gtgKe5CzlQNObE7lA4M5dVzeD4zaAwz0xngR\njAOuYjEEw8pmqf3pFKtkebRXjDTTdZaWu+tJFn7JfX0ay6UqEk2U+BS6u0WXhEOy\ndsJ9NJ6odhE3X3hlRTFcwRL71wKBgQDImHwXvCJEoEymHhFi9WEctYN3SzdCCHwW\n/pI1RJtobsx+Qad1sDhxdRyQo9RbAJg1XJONi1vkHh08Uf3326DIRcPIkfWY3X9Y\n/MM+PwI8Kooh1dT8FevgD3qvccYkpYS72Q0eMVDACsuDdMZHTSn2CAtIrUvB+gOY\niybfGmqGAwKBgQCKbWnD8L36b7xU39VoFBDftoVqqm2LFPeV0jrbaAkhRXKUS4wo\nx8vY+qx0kR8VFOidvSf7Y0bg/n97tfvOS1BYR4V09ScL/yRaTTTr+RPgqBxUmXBq\ntCzs9M/fk8YVLcCwuuwLcOosKBflZULTb5OSO0cFb01Q/n3pFHd7xFcZ8wKBgAGQ\nZs9MkTvVwCM/csVBwosVwzun43tpU4ZeX8d4jHmo+4E0g9jAEgCYeCuMi3hWLdmk\nqiXdY08JCRNSVFedZ8iH+rnSoYaam4aXGfKfTSYo8sDGyQ1aImex1zQNAA2DGODa\nFWcZ3VZR/zo8K9ucd2pKr8PWThPqHiMPWrM8on3/AoGBAIUwle+xOR6ugHtLueti\ntMjQsTrCOwNs/qxQ/oV8/G0Ckw1ap2BPxw91Zlw+pcjz2P5DZr16KpV9OPJZnKRS\nArxL5yc2yBnyKCZTgGSslhEJUFU6Jq/GccI+DFjE/ZqLPg7c6YpLmSX2aMBESurS\nuVCKOFFUGS4jVpWSiwDdShMc\n-----END PRIVATE KEY-----\n",
        "client_email": "firebase-adminsdk-la087@luround-japhet.iam.gserviceaccount.com",
        "client_id": "105994231968331442270",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-la087%40luround-japhet.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    );

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = http.Client();
    final authClient = await clientViaServiceAccount(accountCredentials, scopes);

    final accessToken = authClient.credentials.accessToken;
    client.close();
    log(accessToken.data);
    accessTokenString.value = accessToken.data;
    return accessToken.data;
  }

  //will use this for future purpose
  Future<void> _sendNotification({
    required String targetUserToken,
    required String title,
    required String body,
    required String type,
  }) async {
    try {
      // Replace 'YOUR_SERVER_KEY' with your actual FCM server key
      //String serverKey = 'YOUR_SERVER_KEY';

      // Construct the FCM endpoint URL
      String endpoint = 'https://fcm.googleapis.com/v1/projects/luround-japhet/messages:send';

      // Construct the FCM payload to target multiple platforms and a specific device as well
      dynamic payload = {
        "message":{
          "token":targetUserToken,
          "notification":{
            "body": body,
            "title": title,
          }
        },
        //
        /*"data": {
          "story_id": "story_12345"
        },
        "android": {
          "notification": {
            "click_action": "TOP_STORY_ACTIVITY"
          }
        },
        "apns": {
          "payload": {
            "aps": {
              "category" : "NEW_MESSAGE_CATEGORY"
            }
          }
        }*/
        //
      };

      //Send the FCM request
      http.Response res  = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accessTokenString.value}', //'key=$serverKey',
          'Accept': '/',
        },
        body: jsonEncode(payload),
      );

      //Check if the request was successful
      if(res.statusCode == 200 || res.statusCode == 201) {
        log('response code:  ${res.statusCode}');
        log('response body:  ${res.body}');
        log('Notification sent successfully to $targetUserToken');
      }
      else {
        print('response status:  ${res.statusCode}');
        print('response body:  ${res.body}');
        print("Failed to send notification to user");
      }

    }


    catch(e, stacktrace) {
      throw Exception("$e || $stacktrace");
    }
  }
  ///////////////////////////////////////////////
  


  void displayNotification(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Instantiate setting for (Android/iOS)
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); //'app_icon'
    const DarwinInitializationSettings iosInitializationSetting = DarwinInitializationSettings(
      requestAlertPermission: true, 
      requestBadgePermission: true, 
      requestSoundPermission: true
    );
  
    //join "Android/iOS" instantiation together
    const InitializationSettings initializationSettings =
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: iosInitializationSetting
      );
    
    //Initialize the plugin  (Android/iOS)
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // Create the notification details for android
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'default_channel',
        'Default Channel',
        channelDescription: 'Default Notification Channel',
        color: AppColor.mainColor,
        ledColor: Colors.white,
        enableLights: true,
        enableVibration: true,
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        ledOnMs: 1000, // Specify LED on duration in milliseconds
        ledOffMs: 500, 
      );

      // Create the notification details for iOS
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true
        );
  
      //join both notification details together
      final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      
      if(notification != null && android != null) {

        // Display the notification
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode, 
          notification.title, 
          notification.body, 
          platformChannelSpecifics,
        );

      }

    }

  Future<void> initFCM({
    required Future<void> Function(RemoteMessage) backgroundHandler
  }) async {

  
    //FCM Instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    //Get Unique FCM DEVICE TOKEN AND SAVE TO GETSTORAGE()
    String? token = await messaging.getToken();
    await LocalStorage.saveFCMToken(token!);
    debugPrint("My Device FCMToken: $token"); //save to firebase
    debugPrint("local storage fcmtoken: ${LocalStorage.getFCMToken()}");

    //grant permission for Android/iOS (Android is always automatic)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');

    //grant permission for iOS
    if (Platform.isIOS) {
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    //FCM method that listens to foreground notification messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      //you can save to db
      debugPrint('Message data: ${message.data}');
      //display notification
      displayNotification(message);
    });

    //Enable foreground Notifications for iOS
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //FCM method that listens to background notification messages
    // Enable Background Notification to retrieve any message which caused the application to open from a terminated state
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    // This handles routing to a secific page when there's a click event on the notification
    void handleMessage(RemoteMessage message) {
      //specify message data types here
      if (message.data['type'] == 'home') {
        getx.Get.to(() => const MainPage());
      }
    }

    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    // This handles background notifications when the app is not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    //This handles background notifications when the app is terminated
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    //////////////////////////////////////////////

  }


  
  //selected index
  getx.RxInt selectedIndex = 0.obs;

  //widget options
  final List<Widget> widgetOptions = <Widget>[
    const ProfilePage(),
    const ServicesPage(),
    const BookingsPage(),
    MorePage(),
    //EditCertDetails()
  ];


  dynamic setIndex(int setindex) {
    //if (setindex >= 0 && setindex < widgetOptions.length) {
      selectedIndex.value = setindex;
      log("index: $setindex");
    //}
    update();
  }



  /*Future<void> navigateToMainpageAtIndex({required Widget page, required int index}) async{
    // Use Navigator to push to onto the navigation stack
    setIndex(index);
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
      )
    );
  }*/

  //navbar items
  List<BottomNavigationBarItem> navBarsItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/profile_active.svg'),
        icon: SvgPicture.asset('assets/svg/profile.svg'),
        label: 'Profile',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/services_active.svg'),
        icon: SvgPicture.asset('assets/svg/services.svg'),
        label: 'Services',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/bookings_active.svg'),
        icon:  SvgPicture.asset('assets/svg/bookings.svg'),
        label: 'Bookings',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/svg/more_active.svg'),
        icon: SvgPicture.asset('assets/svg/more.svg'),
        label: 'More',
      ),
    ];
  }
}