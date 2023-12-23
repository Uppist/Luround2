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
  

  //add service stepper//////////////////////////////////
  //(save to db)
  String selectDurationRadio = "select something";

  //checks the selected radio
  final isradio1 = false.obs;
  final isradio2 = false.obs;
  final isradio3 = false.obs;

  //list of dates for "calendar_picker" package (addservices)
  var dates = <DateTime?>[].obs;
  void selectedDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      dates.value = dateList;
      update();
    }
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

  //description textcontroller count
  int maxLength = 500;
  
  void handleTextChanged(String val,) {
    // Check if character count exceeds the maximum
    if (val.length > maxLength) {
      descriptionController.value = TextEditingValue(
        text: val.substring(0, maxLength),
        selection: TextSelection.collapsed(offset: maxLength),
      );
      debugPrint("You have reached max length");
    }
  }

  //checks if the user has inputed their prices in order to enable the button
  final ispriceButtonEnabled = false.obs;
  //for Stepper widget (starts to count at 0)
  int curentStep = 0;

  //select duration in minutes
  final duration = Duration(hours: 0, minutes: 0).obs;
  //(save to db)
  String formatDuration() {
    int hours = duration.value.inHours;
    // Get remaining minutes after subtracting hours
    int minutes = (duration.value.inMinutes % 60).abs();

    String hoursString = hours > 0 ? '$hours hr' : '';
    String minutesString = minutes > 0 ? '$minutes mins' : '';

    if (hours > 0 && minutes > 0) {
      return '$hoursString: $minutesString';
    } 
    else {
      return '$hoursString$minutesString';
    }
  }


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
  
  ////**[STEP 3]***////
  List<String> selectedDays = [];
  //service_screen time picker (add_service_step 3)/// ///////////////////////////////
  //(save to db) the two of them
  final startTimeValue = "".obs; 
  final stopTimeValue = "".obs;

  List<String> availableTime = [];
  void addStartTime() {
    if (!availableTime.contains(startTimeValue.value)) {
      //add all start time to the list
      availableTime.add(startTimeValue.value,);
      print("avail_time_list: $availableTime");
    } else {
      print("${startTimeValue.value} is already in the list");
    }
  }

  void removeStartTime({required int index}) {
    if (index >= 0 && index < availableTime.length) {
      //add all start time to the list
      availableTime.removeAt(index);
      print("avail_time_list: $availableTime");
      print("Item ${availableTime[index]} removed at index $index");
    } 
    else {
      print("Invalid index: $index");
    }
  }




  void addItem({required String item}) {
    if (!selectedDays.contains(item)) {
      // Get the selected days in the order of the days of the week
      List<String> orderedSelectedDays = daysOfTheWeekCheckBox
      .where((day) => day['isChecked'])
      .map<String>((day) => day['day'] as String)
      .toList();

      // Update the selectedDays list based on the checkbox state
      selectedDays = List.from(orderedSelectedDays);
      //selectedDays.add(item);
    } else {
      print("$item is already in the list");
    }
  }

  void removeItem({required int index}) {
    if (index >= 0 && index < selectedDays.length) {
      print("Item ${selectedDays[index]} removed at index $index");
      selectedDays.removeAt(index);
    } else {
      print("Invalid index: $index");
    }
  }

  void toggleCheckbox(int index, bool? value) {
    // Toggle the isChecked value
    daysOfTheWeekCheckBox[index]['isChecked'] = value; //!daysOfTheWeekCheckBox[index]['isChecked'];

    // Update the selectedDays list based on the checkbox state
    if (daysOfTheWeekCheckBox[index]['isChecked']) {
      addItem(item: daysOfTheWeekCheckBox[index]['day']);
      //addStartTime();
    } else {
      int selectedIndex = selectedDays.indexOf(daysOfTheWeekCheckBox[index]['day']);
      if (selectedIndex != -1) {
        removeItem(index: selectedIndex);
        //removeStartTime(index: selectedIndexForAvailTime);
      }
    }
  }
  
  //available_days(save to db)
  String availableDays() {
    // Check if the list is not empty before getting the first and last values
    if (selectedDays.isNotEmpty) {
      String firstDay = selectedDays.first;
      String lastDay = selectedDays.last;

      // Now you can use firstDay and lastDay as needed
      print('First day: $firstDay');
      print('Last day: $lastDay');

      // Combine first and last days into a single string
      String combinedString = '$firstDay - $lastDay';
      print('Combined string: $combinedString');
      return combinedString;
    } else {
      // Handle the case when the list is empty
      print('The list of selected days is empty.');
      throw Exception("The list is empty fam");
    }
  }
  /////////////////////////////////

  //to activate the next/done button in step 3 screen
  final isCheckBoxActive = false.obs;
  




  
  
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
  }*/


  
  //t1
  /*Future<void> openFlutterTimePickerForStartTime({required BuildContext context, required int index}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input
    );

    if (time != null) {
      startTimeValue.value = time.format(context);
      daysOfTheWeekCheckBox[index].addAll({
        "from" : startTimeValue.value,
      });
    }
    update();
  }
  
  //t2
  Future<void> openFlutterTimePickerForStopTime({required BuildContext context, required int index}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input
    );

    if (time != null) {
      stopTimeValue.value = time.format(context);
      daysOfTheWeekCheckBox[index].addAll({
        "to" : stopTimeValue.value,
      });
    }
    update();
  }*/

  /////////////////////////////////////////////////////


















  




  ///service_screen list/// 
  var selectedIndex = 0.obs; //for toggling price of the services list,
  final isVirtual = true.obs;  //boolean to switch between prices in the services list


  void handleTabTap(int index) {
    isVirtual.value = !isVirtual.value;
    selectedIndex.value = index;
    print("price switch check: ${isVirtual.value}");
    update();
  }
  

















  /////////////////////////[EDIT SERVICE SCREEN COMPONENTS HERE]/////////////////////////////////////////////

  //edit service stepper//////////////////////////////////
  //(save to db)
  String selectDateRangeEdit = "select something";

  //checks the selected radio
  final isradio1Edit = false.obs;
  final isradio2Edit = false.obs;
  final isradio3Edit = false.obs;

  //list of dates for "calendar_picker" package (addservices)
  var datesEdit = <DateTime?>[].obs;
  void selectedDateEdit(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      datesEdit.value = dateList;
      update();
    }
  }


  //(save both dates below to db)
  String startDateEdit() {
    if(datesEdit.isNotEmpty && datesEdit.length >= 2) {
      print(datesEdit);
      var result = datesEdit[0].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "from";
  }
  String endDateEdit() {
    print(datesEdit);
    if(datesEdit.isNotEmpty && datesEdit.length >= 2) {
      var result = datesEdit[1].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "to";
  }

  //to add other links at {step 1}
  final toggleLinkEdit = false.obs;
  final isTextGoneEdit  = false.obs;

  //(save to db)
  final TextEditingController serviceNameControllerEdit = TextEditingController();
  final TextEditingController descriptionControllerEdit = TextEditingController();
  final TextEditingController addLinksControllerEdit = TextEditingController();
  final TextEditingController inPersonControllerEdit = TextEditingController();
  final TextEditingController virtualControllerEdit = TextEditingController();

  //checks if the user has inputed their prices in order to enable the button
  final ispriceButtonEnabledEdit = false.obs;

  //description textcontroller count
  int maxLengthEdit = 500;

  //for Stepper widget (starts to count at 0)
  getx.RxInt curentStepEdit = 0.obs;

  //select duration in minutes
  final durationEdit = Duration(hours: 0, minutes: 0).obs;
  
  //(save to db)
  String formatDurationEdit() {
    int hours = durationEdit.value.inHours;
    // Get remaining minutes after subtracting hours
    int minutes = (durationEdit.value.inMinutes % 60).abs();

    String hoursString = hours > 0 ? '$hours hr' : '';
    String minutesString = minutes > 0 ? '$minutes mins' : '';

    if (hours > 0 && minutes > 0) {
      return '$hoursString: $minutesString';
    } 
    else {
      return '$hoursString$minutesString';
    }
  }


  Future<void> showDurationPickerDialogEdit({required BuildContext context}) async{
    var resultingDuration = await showDurationPicker(
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      initialTime: durationEdit.value,
    );
    durationEdit.value = resultingDuration!;
    ispriceButtonEnabledEdit.value = true;
    //debugPrint("duartion: ${resultingDuration}");
    debugPrint("duration: ${durationEdit.value}");
  }

  ////////////step 3 screen///////////(save to db by index from ui)
  List<Map<String, dynamic>> daysOfTheWeekCheckBoxEdit = [
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
  
  ////**[STEP 3]***////////
  List<String> selectedDaysEdit = [];
  List<String> availableTimeEdit = [];
  void addStartTimeEdit() {
    if (!availableTimeEdit.contains(startTimeValueEdit.value)) {
      //add all start time to the list
      availableTimeEdit.add(startTimeValueEdit.value);
    } else {
      print("${startTimeValueEdit.value} is already in the list");
    }
  }

  void removeStartTimeEdit({required int index}) {
    if (index >= 0 && index < availableTimeEdit.length) {
      //add all start time to the list
      availableTimeEdit.removeAt(index);
      print("Item ${availableTimeEdit[index]} removed at index $index");
    } 
    else {
      print("Invalid index: $index");
    }
  }

  void addItemEdit({required String item}) {
    if (!selectedDaysEdit.contains(item)) {
      // Get the selected days in the order of the days of the week
      List<String> orderedSelectedDays = daysOfTheWeekCheckBoxEdit
      .where((day) => day['isChecked'])
      .map<String>((day) => day['day'] as String)
      .toList();

      // Update the selectedDays list based on the checkbox state
      selectedDaysEdit = List.from(orderedSelectedDays);
      //selectedDays.add(item);
    } else {
      print("$item is already in the list");
    }
  }
  

  void removeItemEdit({required int index}) {
    if (index >= 0 && index < selectedDaysEdit.length) {
      print("Item ${selectedDaysEdit[index]} removed at index $index");
      selectedDaysEdit.removeAt(index);
    } else {
      print("Invalid index: $index");
    }
  }

  void toggleCheckboxEdit(int index, bool? value) {   
    // Toggle the isChecked value
    daysOfTheWeekCheckBoxEdit[index]['isChecked'] = value;

    // Update the selectedDays list based on the checkbox state
    if (daysOfTheWeekCheckBoxEdit[index]['isChecked']) {
      addItemEdit(item: daysOfTheWeekCheckBoxEdit[index]['day']);
      //addStartTimeEdit();
    } else {
      int selectedIndex = selectedDaysEdit.indexOf(daysOfTheWeekCheckBoxEdit[index]['day']);
      if (selectedIndex != -1) {
        removeItemEdit(index: selectedIndex);
        //removeStartTimeEdit(index: selectedIndex);
      }
    }
  }
  
  //available_days(save to db)
  String availableDaysEdit() {
    // Check if the list is not empty before getting the first and last values
    if (selectedDaysEdit.isNotEmpty) {
      String firstDay = selectedDaysEdit.first;
      String lastDay = selectedDaysEdit.last;

      // Now you can use firstDay and lastDay as needed
      print('First day: $firstDay');
      print('Last day: $lastDay');

      // Combine first and last days into a single string
      String combinedString = '$firstDay - $lastDay';
      print('Combined string: $combinedString');
      return combinedString;
    } else {
      // Handle the case when the list is empty
      print('The list of selected days is empty.');
      throw Exception("The list is empty fam");
    }
  }
  /////////////////////////////////

  //to activate the next/done button in step 3 screen
  final isCheckBoxActiveEdit = false.obs;

  
  //service_screen time picker (add_service_step 3)/// ///////////////////////////////
  //(save to db) the two of them
  final startTimeValueEdit = "".obs; 
  final stopTimeValueEdit = "".obs;


  /*String getStartTime ({required String initialTime}) {
    if(startTimeValueEdit.isNotEmpty) { 
      debugPrint("t1: $startTimeValueEdit");
      return startTimeValueEdit.value;
    }
    return initialTime;
  }

  String getStopTime ({required String initialTime}) {
    if(stopTimeValueEdit.isNotEmpty) { 
      print("t2: $stopTimeValueEdit");
      return stopTimeValueEdit.value;
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
  }*/


  
  //t1
  /*Future<void> openFlutterTimePickerForStartTimeEdit({required BuildContext context, required int index}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input
    );

    if (time != null) {
      startTimeValueEdit.value = time.format(context);
      daysOfTheWeekCheckBoxEdit[index].addAll({
      "from" : startTimeValueEdit.value,
    });
    }
  }
  
  //t2
  Future<void> openFlutterTimePickerForStopTimeEdit({required BuildContext context, required int index}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input
    );

    if (time != null) {
      stopTimeValueEdit.value = time.format(context);
      daysOfTheWeekCheckBoxEdit[index].addAll({
      "to" : stopTimeValueEdit.value,
    });
    }
  }*/

  /////////////////////////////////////////////////////











  @override
  void onInit() {
    // TODO: implement onInit
    //
    serviceNameControllerEdit.addListener(() {
      ispriceButtonEnabledEdit.value = serviceNameControllerEdit.text.isNotEmpty;  
    });
    //[ADD OTHER LISTENERS]
    super.onInit();
  }




  @override
  void dispose() {
    // TODO: implement dispose
    serviceNameController.dispose();
    descriptionController.dispose();
    addLinksController.dispose();
    inPersonController.dispose();
    //virtualController.dispose();

    serviceNameControllerEdit.dispose();
    descriptionControllerEdit.dispose();
    addLinksControllerEdit.dispose();
    inPersonControllerEdit.dispose();
    virtualControllerEdit.dispose();
    super.dispose();
  }

}