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
  /*String splitTimeRangeT1 ({required String timeRange}) {

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
  }*/


  
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


  //calculates the duration
  String calculateDuration({required String startTime, required String endTime}) {
    // Create DateFormat with the expected time format
    final DateFormat format = DateFormat('hh:mm a');

    // Parse the time strings into DateTime objects
    DateTime start = format.parse(startTime);
    DateTime end = format.parse(endTime);

    // Calculate the duration
    Duration duration = end.difference(start);

    // Check if the duration is in hours, minutes, or minutes only
    if (duration.inHours > 0) {
      // Duration is in hours and possibly minutes
      int hours = duration.inHours;
      int minutes = duration.inMinutes % 60;

      if (minutes > 0) {
        // Duration is in hours and minutes
        String durationString = '$hours hr: ${minutes.toString().padLeft(2, '0')} mins';
        print(durationString);
        update();
        return durationString;
      } 
      else {
        // Duration is in hours only
        String durationString = '$hours hr';
        print(durationString);
        update();
        return durationString;
      }
    } 
    else if (duration.inMinutes > 0) {
      // Duration is in minutes only
      int minutes = duration.inMinutes;
      String durationString = '$minutes mins';
      print(durationString);
      update();
      return durationString;
    } 
    else {
      // Duration is zero
      print('0 mins');
      update();
      return '0 mins';
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