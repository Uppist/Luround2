import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:time_range_picker/time_range_picker.dart';










class BookingsController extends getx.GetxController {
  
  final TextEditingController searchController = TextEditingController();
  final isFieldTapped = false.obs;
  final isExpanded = false.obs;
  int selectedIndex = -1;


  //////RESCHEDULE BOOKINGS SCREEN///////////
  var dates = <DateTime?>[].obs;
  //(save to db) the two of them
  final startTimeValue = "".obs; 
  final stopTimeValue = "".obs;

  void selectedDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      // Remove any previous items, if any
      dates.clear();
      // Add the new unique item
      dates.add(dateList[0]);
    }
  }

  //(save to db) this is the selected date 
  String updatedDate ({required String initialDate}) {
    if(dates.isNotEmpty) {
      var result = dates[0].toString();
      var refinedStr = result.substring(0, 10);
      print(refinedStr);
      return refinedStr;
    }
    return initialDate;
  }


  String getStartTime ({required String initialTime}) {
    if(startTimeValue.isNotEmpty) { 
      debugPrint("t1: $startTimeValue");
      return startTimeValue.value;
    }
    return initialTime;
  }

  String getStopTime ({required String initialTime}) {
    if(stopTimeValue.isNotEmpty) { 
      print("t2: $stopTimeValue");
      return stopTimeValue.value;
    }
    return initialTime;
  }
  
  //get the start time coming from the server
  String splitTimeRangeT1 ({required String timeRange}) {

    // Split the string based on the hyphen
    List<String> timeStrings = timeRange.split('-');

    // Trim any leading or trailing whitespace
    String startTime = timeStrings[0].trim();

    print("Start Time: $startTime");
    return startTime;
  }
  
  
  //get the stop time coming from the server
  String splitTimeRangeT2 ({required String timeRange}) {
    // Split the string based on the hyphen
    List<String> timeStrings = timeRange.split('-');

    // Trim any leading or trailing whitespace
    String endTime = timeStrings[1].trim();

    print("End Time: $endTime");
    return endTime;
  }


  
  //t1
  Future<void> openFlutterTimePickerForStartTime({required BuildContext context}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input
    );

    if (time != null) {
      startTimeValue.value = time.format(context);
    }
  }
  
  //t2
  Future<void> openFlutterTimePickerForStopTime({required BuildContext context}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input
    );

    if (time != null) {
      stopTimeValue.value = time.format(context);
    }
  }

  /////////////////////////////////////////////////////
  








  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

}