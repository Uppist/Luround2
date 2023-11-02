import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';
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
      print("t1: ${startTimeValue}");
      return startTimeValue.value;
    }
    return initialTime;
  }

  String getStopTime ({required String initialTime}) {
    if(stopTimeValue.isNotEmpty) { 
      print("t2: ${stopTimeValue}");
      return stopTimeValue.value;
    }
    return initialTime;
  }

  
  //function that converts the start time to String
  String startTimeFunc({required TimeOfDay startTime}) {
    String formattedTime = DateFormat.jm().format(
      DateTime(2023, 1, 2, startTime.hour, startTime.minute),
    );
    print(formattedTime); // This will print the time in "h:mm a" format
    return formattedTime;
  }
  //function that converts the stop time to String
  String stopTimeFunc({required TimeOfDay stopTime}) {
    String formattedTime = DateFormat.jm().format(
      DateTime(2023, 1, 2, stopTime.hour, stopTime.minute),
    );
    print(formattedTime); // This will print the time in "h:mm a" format
    return formattedTime;
  }

  //func that opens this awesome time range picker package
  Future<void> openTimeRangePicker({required BuildContext context}) async{
    TimeRange result = await showTimeRangePicker(
      context: context,
      //start: TimeOfDay.now()
    );
    startTimeValue.value = startTimeFunc(startTime: result.startTime);
    stopTimeValue.value = stopTimeFunc(stopTime: result.endTime);
    print("start = ${startTimeValue.value} : stop = ${stopTimeValue.value}");
    //print("start = ${jay} : stop = ${alvin}");
  }
  /////////////////////////////////////////////////////
  








  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

}