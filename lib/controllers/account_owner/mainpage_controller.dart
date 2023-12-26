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
import 'package:luround/views/account_owner/profile/widget/edit_education/edit_cert_details/edit_cert_details.dart';
import 'package:luround/views/account_owner/services/screen/service_screen.dart';
import '../../views/account_owner/profile/screen/profile_screen.dart';






class MainPageController extends getx.GetxController {

  var FCMToken = LocalStorage.getFCMToken();

  Future<void> initFCM({
    required Future<void> Function(RemoteMessage) backgroundHandler
  }) async {
    ///////////////FCM  SET UP/////////////////////////////////
  
    //FCM Instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    //Get Unique FCM DEVICE TOKEN
    String? token = await messaging.getToken();
    await LocalStorage.saveFCMToken(token!);
    debugPrint('My Device FCMToken: $token'); //save to firebase

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
      
      //use a foreground notification package to show the notification
      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}'); //save to firebase
      }
      if(notification != null && android != null) {
        print("show notification in foreground mode with FLNP");
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