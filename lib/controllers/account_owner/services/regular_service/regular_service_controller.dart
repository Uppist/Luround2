import 'package:currency_picker/currency_picker.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_2/one-off_widgets/textcontroller_set.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_2/one-off_widgets/view_models/one-off_service_field_model.dart';








class ServicesController extends getx.GetxController {
  
  //SUSPEND SERVICE
  getx.RxBool isToggled = false.obs;


  //////NOT IN ANYMORE USE FOR REGULAR SERVICE///////
  /////(save to db)
  String selectDateRange = "select something";
  //checks the selected radio
  final isradio1 = false.obs;
  final isradio2 = false.obs;
  final isradio3 = false.obs;
  ///////////////////////////////////////////////////

  //add service stepper//////////////////////////////////
  getx.RxString serviceTimeline = "2 weeks".obs;
  final listOfServiceTimeline = <String>["2 weeks", "1 month", "3 months", "6 months", "1 year",];
  //service model
  //(save to db)
  getx.RxString selectServiceModel = "".obs;
  //checks the selected radio
  final isOneOff = false.obs;
  final isRetainer = false.obs;
  /////////////////////////////////////////////////////////


  //list of dates for "calendar_picker" package (addservices)
  var dates = <DateTime?>[].obs;
  void selectedDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      dates.clear();
      dates.addAll(dateList);
      update();
    }
  }
  //////////////////////////////


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

  //checks if the user has inputed their the service name
  final isServiceNameTapped = false.obs;
  //for Stepper widget (starts to count at 0)
  int curentStep = 0;

  //select duration in minutes
  final duration = const Duration(hours: 0, minutes: 0).obs;
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
    //ispriceButtonEnabled.value = true;
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
  
  //available time list
  List<String> availableTime = [];
  
  Future<List<String>> getTimeIntervals({required String earliestTime, required String latestTime, required Duration interval}) async {
    
    try {
      final DateFormat format = DateFormat('h:mm a');
      DateTime earliest = parseTimeString(earliestTime);
      DateTime latest = parseTimeString(latestTime);
    
      availableTime.clear();
      // Set to store unique time intervals
      Set<String> uniqueTimeSet = {earliestTime};

      // Calculate intervals until the latest time
      while (earliest.isBefore(latest)) {
        earliest = earliest.add(interval);
        // Check if the current calculated time is equal to or before the latest time
        if (earliest.isBefore(latest)) {
          if (!uniqueTimeSet.contains(format.format(earliest))) {
            uniqueTimeSet.add(format.format(earliest));
          }
          else {
            debugPrint("already in the list");
          }
        } 
      }

      // Convert the set to a list
      availableTime.addAll(uniqueTimeSet.toList());

      // Add the latest time
      availableTime.add(latestTime);

      print("available_time_: $availableTime");
      return availableTime;
    }
    catch(e, stacktrace) {
      throw Exception("te-error: $e == $stacktrace");
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
    } else {
      int selectedIndex = selectedDays.indexOf(daysOfTheWeekCheckBox[index]['day']);
      if (selectedIndex != -1) {
        removeItem(index: selectedIndex);
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
  

  ///////////////////////////////////////////////////////////////////
  //trying to calculate the time-frame string
  List<String> timeFrameList = [];
  void addFirstTime() {
    if (!timeFrameList.contains(startTimeValue.value)) {
      //add all start time to the list
      timeFrameList.add(startTimeValue.value,);
      print("timeframe list: $timeFrameList");
    } else {
      print("${startTimeValue.value} is already in the list");
    }
  }

  void addLastTime() {
    if (!timeFrameList.contains(stopTimeValue.value)) {
      //add all start time to the list
      timeFrameList.add(stopTimeValue.value,);
      print("timeframe list: $timeFrameList");
    } else {
      print("${stopTimeValue.value} is already in the list");
    }
  }

  void removeTime({required int index}) {
    if (index >= 0 && index < timeFrameList.length) {
      //add all start time to the list
      timeFrameList.removeAt(index);
      print("timeframe list: $timeFrameList");
      print("Item ${timeFrameList[index]} removed at index $index");
    } 
    else {
      print("Invalid index: $index");
    }
  }

  //get the earliest time in the list
  String findEarliestTime() {
    DateTime earliestTime = DateTime(2100); // A future date to compare against

    for (String timeString in timeFrameList) {
      DateTime time = parseTimeString(timeString);
      if (time.isBefore(earliestTime)) {
        earliestTime = time;
      }
    }
    print("Earliest Time: $earliestTime");
    return formatTimeString(earliestTime);
  }
  
  //get the latest time in the list
  String findLatestTime() {
    DateTime latestTime = DateTime(0); // A past date to compare against

    for (String timeString in timeFrameList) {
      DateTime time = parseTimeString(timeString);
      if (time.isAfter(latestTime)) {
        latestTime = time;
      }
    }
    print("Latest Time: $latestTime");
    return formatTimeString(latestTime);
  }
  
  //parseTimeString
  DateTime parseTimeString(String timeString) {
    // Parse time string into DateTime
    final DateFormat format = DateFormat('h:mm a');
    return format.parse(timeString);
  }
  
  
  //formatTimeString
  /*String formatTimeString(DateTime time) {
    // Format DateTime into string
    return "${time.hour}:${time.minute < 10 ? '0${time.minute}' : time.minute}${time.hour < 12 ? ' AM' : ' PM'}";
  }*/
  
  String formatTimeString(DateTime time) {
    // Format DateTime into string
    int hour = time.hour == 0 ? 12 : time.hour > 12 ? time.hour - 12 : time.hour;
    String period = time.hour < 12 ? ' AM' : ' PM';

    return "${hour}:${time.minute < 10 ? '0${time.minute}' : time.minute}$period";
  }


  //show currency picker when adding/creating a service
  var addServiceCurrency = "".obs;
  Future<void> showNiceCurrencyPickerAdd({required BuildContext context}) async{
    showCurrencyPicker(
      physics: BouncingScrollPhysics(),
      context: context,
      theme: CurrencyPickerThemeData(
        backgroundColor: AppColor.bgColor,
        flagSize: 25,
        titleTextStyle: GoogleFonts.inter(
          color: AppColor.blackColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500
        ),
        currencySignTextStyle: GoogleFonts.inter(
          color: AppColor.blackColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500
        ),
        subtitleTextStyle: GoogleFonts.inter(
          color: AppColor.darkGreyColor.withOpacity(0.5),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400
        ),
        //bottomSheetHeight: MediaQuery.of(context).size.height / 2,
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(CupertinoIcons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.mainColor //.withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Currency currency) {
        addServiceCurrency.value = currency.symbol;
        print('Select currency: ${addServiceCurrency.value}');
      },
   );
  }

  /////////////////////////////////////////////////////















  /////////////////////////////////////////////////////
  //ADD ONE-OFF SERVICE CREATION//
  //EDIT SPECIFIC CERTIFICATE PAGE//
  //final TextEditingController durationController = TextEditingController();
  //final TextEditingController virtualPriceController = TextEditingController();
  //final TextEditingController inpersonPriceController = TextEditingController();

  
  List<ServiceControllerSett> controllers = [ServiceControllerSett(), ServiceControllerSett()]; //(save to db)
  //List<Widget> viewTextfields = []; 

  /*void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1; 
    }
    final item = viewTextfields.removeAt(oldIndex);
    viewTextfields.insert(newIndex, item);
    update();
  }*/

  











  





















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

  //service model
  //edit service stepper//////////////////////////////////
  getx.RxString serviceTimelineEdit = "2 weeks".obs;
  final listOfServiceTimelineEdit = <String>["2 weeks", "1 month", "3 months", "6 months", "1 year",];
  //service model
  //(save to db)
  getx.RxString selectServiceModelEdit = "".obs;

  //checks the selected radio
  final isOneOffEdit = false.obs;
  final isRetainerEdit = false.obs;
  ////////////////////////////////////////////////

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
  final isServiceNameTappedEdit = false.obs;

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

  /*void addStartTimeEdit() {
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
  }*/

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
    } else {
      int selectedIndex = selectedDaysEdit.indexOf(daysOfTheWeekCheckBoxEdit[index]['day']);
      if (selectedIndex != -1) {
        removeItemEdit(index: selectedIndex);
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


  //trying to calculate the time-frame string
  List<String> timeFrameListEdit = [];
  void addFirstTimeEdit() {
    if (!timeFrameListEdit.contains(startTimeValueEdit.value)) {
      //add all start time to the list
      timeFrameListEdit.add(startTimeValueEdit.value,);
      print("timeframe list: $timeFrameListEdit");
    } else {
      print("${startTimeValueEdit.value} is already in the list");
    }
  }

  void addLastTimeEdit() {
    if (!timeFrameListEdit.contains(stopTimeValueEdit.value)) {
      //add all start time to the list
      timeFrameListEdit.add(stopTimeValueEdit.value,);
      print("timeframe list: $timeFrameListEdit");
    } else {
      print("${stopTimeValueEdit.value} is already in the list");
    }
  }

  void removeTimeEdit({required int index}) {
    if (index >= 0 && index < timeFrameListEdit.length) {
      //add all start time to the list
      timeFrameListEdit.removeAt(index);
      print("timeframe list: $timeFrameListEdit");
      print("Item ${timeFrameListEdit[index]} removed at index $index");
    } 
    else {
      print("Invalid index: $index");
    }
  }

  //get the earliest time in the list
  String findEarliestTimeEdit() {
    DateTime earliestTime = DateTime(2100); // A future date to compare against

    for (String timeString in timeFrameListEdit) {
      DateTime time = parseTimeString(timeString);
      if (time.isBefore(earliestTime)) {
        earliestTime = time;
      }
    }
    print("Earliest Time: $earliestTime");
    return formatTimeString(earliestTime);
  }
  
  //get the latest time in the list
  String findLatestTimeEdit() {
    DateTime latestTime = DateTime(0); // A past date to compare against

    for (String timeString in timeFrameListEdit) {
      DateTime time = parseTimeString(timeString);
      if (time.isAfter(latestTime)) {
        latestTime = time;
      }
    }
    print("Latest Time: $latestTime");
    return formatTimeString(latestTime);
  }
  
  //get time intervals
  Future<void> getTimeIntervalsEdit({required String earliestTime, required String latestTime, required Duration interval}) async{
    
    try{
      final DateFormat format = DateFormat('h:mm a');
      DateTime earliest = parseTimeString(earliestTime);
      DateTime latest = parseTimeString(latestTime);

      // Add the first time interval (earliest time)
      availableTimeEdit.clear();

      // Set to store unique time intervals
      Set<String> uniqueTimeSet = {earliestTime};

      // Calculate intervals until the latest time
      while (earliest.isBefore(latest)) {
        earliest = earliest.add(interval);
        // Check if the current calculated time is equal to or before the latest time
        if (earliest.isBefore(latest)) {
          if (!uniqueTimeSet.contains(format.format(earliest))) {
            uniqueTimeSet.add(format.format(earliest));
          }
          else {
            debugPrint("already in the list");
          }
        }
      }

      // Convert the set to a list
      availableTimeEdit.addAll(uniqueTimeSet.toList());

      // Add the latest time
      availableTimeEdit.add(latestTime);
      print("available_ time_edit: $availableTimeEdit");
      }
      catch(e, stacktrace) {
        throw Exception("te-error: $e == $stacktrace");
      }
    
    }


  //show currency picker when adding/creating a service
  var editServiceCurrency = "".obs;
  Future<void> showNiceCurrencyPickerEdit({required BuildContext context}) async{
    showCurrencyPicker(
      physics: BouncingScrollPhysics(),
      context: context,
      theme: CurrencyPickerThemeData(
        backgroundColor: AppColor.bgColor,
        flagSize: 25,
        titleTextStyle: GoogleFonts.inter(
          color: AppColor.blackColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500
        ),
        currencySignTextStyle: GoogleFonts.inter(
          color: AppColor.blackColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500
        ),
        subtitleTextStyle: GoogleFonts.inter(
          color: AppColor.darkGreyColor.withOpacity(0.5),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400
        ),
        //bottomSheetHeight: MediaQuery.of(context).size.height / 2,
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(CupertinoIcons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.mainColor //.withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Currency currency) {
        editServiceCurrency.value = currency.symbol;
        print('Select currency: ${editServiceCurrency.value}');
      },
   );
  }

  
  /////////////////////////////////////////////////////











  @override
  void onInit() {
    // TODO: implement onInit
    //
    /*serviceNameControllerEdit.addListener(() {
      ispriceButtonEnabledEdit.value = serviceNameControllerEdit.text.isNotEmpty;  
    });*/
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