import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:time_range_picker/time_range_picker.dart';










class ServicesController extends getx.GetxController {
  


  //boolean that checks if the user (account owner) currently doesn't have any service
  final isServicePresent = true.obs;

  //add service stepper//////////////////////////////////
  //(save to db)
  String selectDurationRadio = "select something";

  //checks the selected radio
  final isradio1 = false.obs;
  final isradio2 = false.obs;
  final isradio3 = false.obs;

  //list of dates for "calendar_picker" package
  var dates = <DateTime?>[].obs;
  
  //to calendar to select date range
  Future<void> showRangeCalendar({required BuildContext context}) async{
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig (
        calendarType: CalendarDatePicker2Type.range,
        cancelButtonTextStyle: GoogleFonts.poppins(
          color: AppColor.mainColor
        ),
        okButtonTextStyle: GoogleFonts.poppins(
          color: AppColor.mainColor,
        ),
        weekdayLabelTextStyle:  GoogleFonts.poppins(
          color: AppColor.mainColor,
          fontSize: 10.sp
        ),
        selectedYearTextStyle:  GoogleFonts.poppins(
          color: AppColor.mainColor,
        ),
        selectedRangeDayTextStyle:  GoogleFonts.poppins(
          color: AppColor.bgColor,
          fontSize: 8.sp
        ),
        selectedRangeHighlightColor: AppColor.mainColor.withOpacity(0.2),
        selectedDayTextStyle:  GoogleFonts.poppins(
          color: AppColor.bgColor,
          fontSize: 8.sp
        ),
        selectedDayHighlightColor: AppColor.mainColor,
        //calendarViewMode: DatePickerMode.day
      ),
      dialogSize: Size(500.w, 450.h), //325.w
      value: dates,
      borderRadius: BorderRadius.circular(15),
      /*builder: (context, child) {
        return Container();
      },*/
    );
    //set the empty list to equate the result

    dates.value = results!;
    
    debugPrint("date range: $dates");
    print("start date: ${startDate()}");
    print("end date: ${endDate()}");
  }

  //(save both dates below to db)
  String startDate () {
    if(dates.isNotEmpty && dates.length >= 2) {
      print(dates);
      var result = dates[0].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "from";
  }
  String endDate () {
    print(dates);
    if(dates.isNotEmpty && dates.length >= 2) {
      var result = dates[1].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "to";
  }

  //to add other links at {step 1}
  final toggleLink = false.obs;
  final isTextGone  = false.obs;

  //(save to db)
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addLinksController = TextEditingController();
  final TextEditingController inPersonController = TextEditingController();
  final TextEditingController virtualController = TextEditingController();

  //checks if the user has inputed their prices in order to enable the button
  final ispriceButtonEnabled = false.obs;

  //description textcontroller count
  int maxLength = 500;
  //for Stepper widget (starts to count at 0)
  int curentStep = 0;

  //select duration in minutes(save to db)
  final duration = Duration(hours: 0, minutes: 0).obs;
  //convert the about duration object to a string
  //String convertDuration() {}
  Future<void> showDurationPickerDialog({required BuildContext context}) async{
    var resultingDuration = await showDurationPicker(
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      initialTime: duration.value,
    );
    duration.value = resultingDuration!;
    ispriceButtonEnabled.value = true;
    //debugPrint("duartion: ${resultingDuration}");
    debugPrint("duration: ${duration.value}");
  }

  ////////////step 3 screen///////////(save to db by index from ui)
  List<Map<String, dynamic>> daysOfTheWeekCheckBox = [
    {
      "day": "Monday",
      "isChecked": false,     
    },
    {
      "day": "Tuesday",
      "isChecked": false,     
    },
    {
      "day": "Wednesday",
      "isChecked": false,     
    },
    {
      "day": "Thursday",
      "isChecked": false,     
    },
    {
      "day": "Friday",
      "isChecked": false,     
    },
    {
      "day": "Saturday",
      "isChecked": false,     
    },
    {
      "day": "Sunday",
      "isChecked": false,     
    },
  ];

  //to activate the next/done button in step 3 screen
  final isCheckBoxActive = false.obs;

  
  //service_screen time picker (add_service_step 3)/// ///////////////////////////////
  //(save to db) the two of them
  final startTimeValue = "".obs; 
  final stopTimeValue = "".obs;
  
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

  /*String getStartTime ({required String initialTime}) {
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
  }*/
  /////////////////////////////////////////////////////




  ///service_screen list/// 
  var selectedIndex = 0.obs; //for toggling price of the services list,
  final isVirtual = true.obs;  //boolean to switch between prices in the services list
  //List<String> tabs = ['Virtual', "In-Person"];

  void handleTabTap(int index) {
    isVirtual.value = !isVirtual.value;
    selectedIndex.value = index;
    print("price switch check: ${isVirtual.value}");
    update();
  }
  

  ///////////////////////////////////////////////////////////////////////

  










  @override
  void dispose() {
    // TODO: implement dispose
    serviceNameController.dispose();
    descriptionController.dispose();
    addLinksController.dispose();
    inPersonController.dispose();
    //virtualController.dispose();
    super.dispose();
  }

}