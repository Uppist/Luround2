import 'package:currency_picker/currency_picker.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luround/utils/colors/app_theme.dart';










class PackageServiceController extends getx.GetxController {
  

  //add package service stepper//////////////////////////////////
  //(save to db)
  String selectDurationRadio = "select something";
  //checks the selected radio
  final isradio1 = false.obs;
  final isradio2 = false.obs;
  final isradio3 = false.obs;

  //service model
  //(save to db)
  String selectServiceModel = "select service model";

}