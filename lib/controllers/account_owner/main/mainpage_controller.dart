import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/views/account_owner/bookings/screen/bookings_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/more/screen/more_screen.dart';
import 'package:luround/views/account_owner/services/screen/service_screen.dart';
import '../../../views/account_owner/profile/screen/profile_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';






class MainPageController extends getx.GetxController {

  Future initFLNP({required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin}) async{
    //FLNP Instance
    //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    //FLNP component
    //This is used to define the initialization settings for iOS and android
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    //AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();

  }

  void showFLNP({required String title, required String body, var payload, required FlutterLocalNotificationsPlugin fln}) async{
    
    //flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    //AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', //id
      'High Importance Notification', //title
      description: 'This is used to send messages notification',
      importance: Importance.high,
      enableLights: true,
      ledColor: Colors.white
    );
    
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id, //'channel_id',
      channel.name, //'channel_name',
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      //sound: RawResourceAndroidNotificationSound('notification')
    );


    var notification = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true
      )
    );
    
    await fln.show(0, title, body, notification);
  }


  Future<void> initFCM({
    required Future<void> Function(RemoteMessage) backgroundHandler
  }) async {
  
    //FCM Instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    //FLNP Instance
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    //FLNP component
    //This is used to define the initialization settings for iOS and android
    var initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/ic_stat_ic_notification');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // This handles routing to a specific page when there's a click event on the notification when the app is in foreground mode
    void onSelectNotification(NotificationResponse notificationResponse) async {
      debugPrint(notificationResponse.payload);
      var payloadData = jsonDecode(notificationResponse.payload!);
      if (payloadData["type"] == "home") {
        getx.Get.to(() => const MainPage());
      }
    }
    
    //initialize FLNP
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onSelectNotification);

    //Get Unique FCM DEVICE TOKEN
    String? token = await messaging.getToken();
    await LocalStorage.saveFCMToken(token!);
    debugPrint('My Device FCMToken: $token'); //save to firebase
    debugPrint("local storage fcmtoken${LocalStorage.getFCMToken()}");

    //grant permission for Android (Android is always automatic)
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

    // Listneing to the foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}'); //save to firebase
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}'); //save to firebase
      }
      if(notification != null && android != null) {
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', //id
          'High Importance Notification', //title
          importance: Importance.high
        );
        
        flutterLocalNotificationsPlugin.show(
          notification.hashCode, 
          notification.title, 
          notification.body, 
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id, 
              channel.name,
              //icon: 'launch_background'
            )
          )
        );
      }
    });
    //Enable foreground Notifications for iOS
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //TODO: USE FLUTTER LOCAL NOTIFICATIONS TO DISPLAY FOREGROUND NOTIFICATIONS

    // Listening to the background messages

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



  //to be used for 'messages notification", 'friend request notifications e.t.c'
  /*Future<void> sendPushNotificationWithFirebaseAPI({required String receiverFCMToken, required String title, required String content}) async {
    //TODO: make the notification display in foreground
  
    //FCM Instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;
  
    //grant permission for Android (Android is always automatic)
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
  
    //header for the end point
    final Map<String, String> headers = {
      'Authorization': 'key=$firebaseServerKeyFromTheConsole',
      'Content-type': 'application/json',
      'Accept': '/',
    };

    // notificationData or body for the end point
    final Map<String, dynamic> notificationData = {
      "to": receiverFCMToken,
      "priority": "high",
      "notification": {
        "title": title,
        "body":content,
        "sound": "default"
      },
      "data": {
        "title": title,
        "body": content,
        "type": "chat",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
        // Add other optional parameters for customizing your notification
      }
    };
  
    //show notification with 'flutter_local_notification" plugin
    RemoteNotification? notification = const RemoteNotification();

  
    //flutter local notifications fuckkinngg worked.. finallyyyyy
    showFLNP(title: title, body: content, fln: flutterLocalNotificationsPlugin);

    //Enable foreground Notifications for iOS
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //send a POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode(notificationData),  //notificationData
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Error sending notification: ${response.statusCode}\n${response.body}');
    }

  }*/

  
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