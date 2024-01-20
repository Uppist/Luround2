import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/views/account_viewer/people_profile/screen/profile_page_acc_viewer.dart';
import 'package:luround/views/account_viewer/services/screen/services_screen.dart';
import '../../views/account_owner/profile/screen/profile_screen.dart';









class MainPageControllerAccViewer extends getx.GetxController {
  
  //selected index
  int selectedIndex = 0;
  

  //widget options
  final List<Widget> widgetOptions = <Widget>[
    AccViewerProfilePage(),
    AccViewerServicesPage(),
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
    ];
  }
}