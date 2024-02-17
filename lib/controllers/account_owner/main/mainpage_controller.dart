import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/screen/bookings_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/more/screen/more_screen.dart';
import 'package:luround/views/account_owner/services/screen/service_screen.dart';
import '../../../views/account_owner/profile/screen/profile_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';





class MainPageController extends getx.GetxController {
  
  //will use this for future purpose
  Future<void> _sendNotification({
    required String targetUserToken,
    required String title,
    required String body
  }) async {
    try {
      // Replace 'YOUR_SERVER_KEY' with your actual FCM server key
      String serverKey = 'YOUR_SERVER_KEY';

      // Construct the FCM endpoint URL
      String endpoint = 'https://fcm.googleapis.com/fcm/send';

      // Construct the FCM payload
      dynamic payload = {
        'to': targetUserToken,
        'notification': {
          'title': title,
          'body': body,
        },
      };

      //Send the FCM request
      http.Response res  = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
          'Accept': '/',
        },
        body: jsonEncode(payload),
      );

      //Check if the request was successful
      if(res.statusCode == 200 || res.statusCode == 201) {
        print('response body:  ${res.body}');
        print('Notification sent successfully to $targetUserToken');
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
    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); //'app_icon'
    final DarwinInitializationSettings iosInitializationSetting = const DarwinInitializationSettings(
      requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true
    );
  
    //join "Android/iOS" instantiation together
    final InitializationSettings initializationSettings =
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: iosInitializationSetting
      );
    
    // Initialize the plugin  (Android/iOS)
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
      );

      // Create the notification details for iOS
      final DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true
        );
  
      //join both notification details together
      final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      // Display the notification
      await flutterLocalNotificationsPlugin.show(
        message.data.hashCode, 
        message.data['title'], 
        message.data['body'], 
        platformChannelSpecifics,
      );
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
  int selectedIndex = 0;

  //widget options
  final List<Widget> widgetOptions = <Widget>[
    ProfilePage(),
    ServicesPage(),
    BookingsPage(),
    MorePage(),
    //EditCertDetails()
  ];

  void setIndex(int index) {
    selectedIndex = index;
    update(); // This triggers a rebuild when the index changes
  }

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