import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:get/get.dart' as getx;










class ServicesController extends getx.GetxController {
  


  //boolean that checks if the user (account owner) currently doesn't have any service
  final isServicePresent = true.obs;


  //add service stepper//////////////////////////////////
  //(save to db)
  String selectDurationRadio = "Tap to select duration";

  //checks the selected radio
  final isradio1 = false.obs;
  final isradio2 = false.obs;
  final isradio3 = false.obs;


  var dates = <DateTime?>[];
  //selected index
  //int selectedindex = -1; // Initialize to -1 to indicate no selection
  //(save both dates below to db)
  String startDate () {
    if(dates.isNotEmpty) {
      var result = dates[0].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "from";
  }
  String endDate () {
    if(dates.isNotEmpty) {
      var result = dates[1].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "to";
  }

  //to calendar to select date range
  /*Future<void> showRangeCalendar({required BuildContext context}) async{
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig (
        calendarType: CalendarDatePicker2Type.range,
      ),
      dialogSize: const Size(325, 400),
      value: dates,
      borderRadius: BorderRadius.circular(15),
    );
    //set the empty list to equate the result
    dates = results!;
    debugPrint("date range: $dates");
    print("start date: ${startDate()}");
    print("end date: ${endDate()}");
    update();
  }*/

  //formKey for step 1 and 2 screens.
  final formKey = GlobalKey();
  final formKey2 = GlobalKey();

  //to add other links 
  final toggleLink = false.obs;

  //(save to db)
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addLinksController = TextEditingController();
  final TextEditingController inPersonController = TextEditingController();
  final TextEditingController virtualController = TextEditingController();

  //checks if the user has inputed their prices for the type of dr
  final ispriceButtonEnabled = false.obs;

  //description textcontroller count
  int maxLength = 500;
  //for Stepper widget
  int curentStep = 0;

  //select duration in minutes(save to db)
  Duration duration = const Duration(hours: 0, minutes: 0);

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

  //to active the button instep 3 screen
  final isCheckBoxActive = false.obs;

  //to select time frame for a service to be rendered (both are to be saved to db)
  var startTime = 'from'.obs;
  var endTime = 'to'.obs;

  var startMinute = '00'.obs;
  var endMinute = '00'.obs;
  ///////////////////////////////////
  

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