import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/views/account_owner/auth/screen/onboarding/page/first_page.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/page/second_page.dart';
import '../../views/account_owner/auth/screen/onboarding/page/third_page.dart';






class AuthController extends getx.GetxController {

  //ONBOARDING SECTION//
  final List<Widget> pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];



}