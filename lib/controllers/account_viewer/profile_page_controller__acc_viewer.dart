import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;









class ProfilePageAccViewerController extends getx.GetxController {
  
  //show sign me up section
  final showSignMeUpSection = true.obs;

   
  //write a review section
  int maxLength = 500;
  final TextEditingController reviewController = TextEditingController();
  final reviewFocus = false.obs;
  final rating = 0.0.obs;  //save to db
  updateReviewFocus(bool val) => {
    reviewFocus.value = val
  };
  
  
  
  ///////////////serenren for testing purposes
  
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
  //////////////////////////////////////////////////
  

  //dispose function from getX
  @override
  void dispose() {
    // TODO: implement onInit
    reviewController.dispose();
    super.dispose();
  }

}