import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import '../../views/account_owner/profile/screen/profile_screen.dart';






class ProfilePageController extends getx.GetxController {
  
  
  bool isEmpty = true;

  //svg pictures
  var svgPictures = <String> [
    'assets/svg/location_icon.svg',
    'assets/svg/call_icon.svg',
    'assets/svg/email_icon.svg',
    'assets/svg/site_icon.svg',
    'assets/svg/linkedin_icon.svg',
    'assets/svg/facebook_icon.svg',
    'assets/svg/twitter_icon.svg',
  ];
  
  //title texts (accordingly)
  var titleText = <String> [
    'Lagos, Nigeria.',
    '(234) 7040 571 471',
    'ronaldrichards@example.com',
    'https://www.mysite.com',
    'linkedin.com/in/richie12234',
    'facebook.com/fb/richard',
    'twitter.com/x/richard',
  ];

  //subtitle texts (accordingly)
  var subtitleText = <String> [
    'Location',
    'Mobile',
    'Email',
    'Website',
    'LinkedIn',
    'Facebook',
    'Twitter',
  ];


}