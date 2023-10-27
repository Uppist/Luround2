import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/views/account_owner/services/screen/service_screen.dart';
import '../../views/account_owner/profile/screen/profile_screen.dart';






class MainPageController extends getx.GetxController {
  
  //selected index
  int selectedIndex = 0;

  //widget options
  final List<Widget> widgetOptions = <Widget>[
    ProfilePage(),
    ServicesPage(),
    SizedBox(),
    SizedBox(),
  ];

  

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