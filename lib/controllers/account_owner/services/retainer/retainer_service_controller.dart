import 'dart:developer';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/ui/dayselection_model.dart';
import 'package:luround/models/account_owner/ui/textcontroller_model.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/utils/colors/app_theme.dart';










class PackageServiceController extends getx.GetxController {
  
  //SUSPEND SERVICE
  getx.RxBool isToggled = false.obs;

  //checks if the user has inputed their the service name
  getx.RxBool isServiceNameTapped = false.obs;

  //to activate the next/done button in step 3 screen
  getx.RxBool isCheckBoxActive = false.obs;

  //for Stepper widget (starts to count at 0)
  int curentStep = 0;


  //(save to db)
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addLinksController = TextEditingController();
  final TextEditingController coreFeaturesController = TextEditingController();


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
  
  ///service_screen list for retainer service list/// 
  //PUT IN THE CONTROLLER
  getx.RxInt selectedDurationIndex = 0.obs;
  getx.RxString selectedFieldIndex = 'Virtual'.obs;


  //STEP 1//
  //core features list
  final inputs = <String>[].obs;
  final isFeaturesTapped = false.obs;
  
  // Function to add input to the core features list
  Future<void> addInput(String input) async{
    inputs.add(input);
    log("$inputs");
    update();
  }

  // Function to remove input by index from the core features list
  Future<void> removeInput(int index) async{
    inputs.removeAt(index);
    log("$inputs");
    update();
  }

  ////STEP 3////
  // List of days with selection status
  var days = <Map<String, dynamic>>[
    {'day': 'Monday', 'isSelected': false},
    {'day': 'Tuesday', 'isSelected': false},
    {'day': 'Wednesday', 'isSelected': false},
    {'day': 'Thursday', 'isSelected': false},
    {'day': 'Friday', 'isSelected': false},
    {'day': 'Saturday', 'isSelected': false},
    {'day': 'Sunday', 'isSelected': false},
  ];  //.obs;

  // List of selected days with their start and stop times
  //save to db
  var selectedDays = <DaySelectionModel>[].obs;

  // Toggles the selection status of a day, adding or removing it from the selectedDays list
  void toggleDaySelection(
    int index,
    String day, 
    bool? isSelected,
    String startTime,
    String stopTime,
  ) {
    final index2 = selectedDays.indexWhere((element) => element.day == day);
    days[index]['isSelected'] = isSelected;
    if (isSelected!) {
      log("$isSelected");
      addDay(day, startTime, stopTime);
    } else {
      log("$isSelected");
      removeItem(index: index2);
    }
    update();
  }

  //Retrieves the DaySelectionModel for a specific day
  DaySelectionModel? getDaySelection(String day) {
    return selectedDays.firstWhereOrNull((element) => element.day == day);
  }

  // Adds a day with its start and stop times to the selectedDays list
  Future<void> addDay(String day, String startTime, String stopTime) async {
    selectedDays.add(DaySelectionModel(day: day, startTime: startTime, stopTime: stopTime));
    log("list: $selectedDays");
  }

  // Removes a day from the selectedDays list based on its index
  Future<void> removeItem({required int index}) async {
    if (index >= 0 && index < selectedDays.length) {
      log("Item ${selectedDays[index]} removed at index $index");
      selectedDays.removeAt(index);
      selectedDays.refresh();
      log("updated list: $selectedDays");
    } else {
      print("Invalid index: $index");
    }
  }

  // Updates the start time of a specific day in the selectedDays list
  Future<void> updateStartTime(String day, String startTime) async {
    final index = selectedDays.indexWhere((element) => element.day == day);
    if (index != -1) {
      selectedDays[index].startTime = startTime;
      selectedDays.refresh();
      update(); // Notify UI
    }
  }

  // Updates the stop time of a specific day in the selectedDays list
  Future<void> updateStopTime(String day, String stopTime) async {
    final index = selectedDays.indexWhere((element) => element.day == day);
    if (index != -1) {
      selectedDays[index].stopTime = stopTime;
      selectedDays.refresh();
      update(); // Notify UI
    }
  }

  // Reorders the selectedDays list based on the order of days in the week
  Future<List<DaySelectionModel>> reorderDays(List<DaySelectionModel> selectedDays) async {
    // Define the order of days in the week
    const List<String> weekDaysOrder = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    // Create a map to define the order index of each day
    Map<String, int> dayOrderMap = {
      for (int i = 0; i < weekDaysOrder.length; i++) weekDaysOrder[i]: i
    };

    // Sort the selectedDays list based on the day order defined in dayOrderMap
    selectedDays.sort((a, b) => dayOrderMap[a.day]!.compareTo(dayOrderMap[b.day]!));

    // Return the sorted list
    return selectedDays;
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
          fontWeight: FontWeight.w500,
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
  //STEP 2////
  List<ServiceControllerSett> controllersInput = List.generate(
    7,
    (index) => ServiceControllerSett(),
  );

  final TextEditingController customTimeSlotController = TextEditingController();
  final isCheckBoxActiveForPricing = false.obs;
  final isCustomTextFieldActivated = false.obs;
  // List of time slots with selection status
  var priceSlot = <Map<String, dynamic>>[
    {'time': '2 weeks', 'isSelected': false},
    {'time': '1 month', 'isSelected': false},
    {'time': '3 months', 'isSelected': false},
    {'time': '6 months', 'isSelected': false},
    {'time': '12 months', 'isSelected': false},
    {'time': '18 months', 'isSelected': false},
    {'time': '24 months', 'isSelected': false},
  ];

  // List of selected timeslots with their virtual and in-person price
  //save to db
  final selectedTimeSlot = <PricingInfo>[].obs;

  // Toggles the selection status of a day, adding or removing it from the selectedDays list
  void toggleTimeSlotSelection(
    int index,
    String time, 
    bool? isSelected,
    String virtual,
    String inperson,
  ) {
    final index2 = selectedTimeSlot.indexWhere((element) => element.time_allocation == time);
    priceSlot[index]['isSelected'] = isSelected;
    //priceSlot[index]['time'] = time;
    ServiceControllerSett controllerSet = controllersInput[index];
    if (isSelected!) {
      //log("$isSelected");
      log(time);
      addTime(time, virtual, inperson);
    } else {
      //log("$isSelected");
      log(time);
      controllerSet.virtualPriceController.clear();
      controllerSet.inpersonPriceController.clear();
      removeTime(index: index2);
    }
    update();
  }

  //Retrieves the Price Info for a specific time
  PricingInfo? getTimeSelection(String time) {
    return selectedTimeSlot.firstWhereOrNull((element) => element.time_allocation == time);
  }

  // Adds a day with its start and stop times to the selectedDays list
  Future<void> addTime(String time, String virtualPrice, String inpersonPrice) async {
    selectedTimeSlot.add(PricingInfo(time_allocation: time, virtual_pricing: virtualPrice, in_person_pricing: inpersonPrice));
    log("list: $selectedTimeSlot");
  }

  // Removes a day from the selectedDays list based on its index
  Future<void> removeTime({required int index}) async {
    if (index >= 0 && index < selectedTimeSlot.length) {
      log("Item ${selectedTimeSlot[index]} removed at index $index");
      selectedTimeSlot.removeAt(index);

      selectedTimeSlot.refresh();
      log("updated list: $selectedTimeSlot");
    } 
    else {
      print("Invalid index: $index");
    }
  }

  // Updates the duration of a specific timeSlot in the selectedTimeSlot list
  Future<void> updateCustomDuration(String time) async {
    final index = selectedTimeSlot.indexWhere((element) => element.time_allocation == "Custom");
    if (index != -1) {
      selectedTimeSlot[index].time_allocation = time;
      selectedTimeSlot.refresh();
      log("updated list: $selectedTimeSlot");
      update(); // Notify UI
    }
  }

  // Updates the virtualPrice of a specific timeSlot in the selectedTimeSlot list
  Future<void> updateVirtualPrice(String time, String virtualPrice,) async {
    final index = selectedTimeSlot.indexWhere((element) => element.time_allocation == time);
    if (index != -1) {
      selectedTimeSlot[index].virtual_pricing = virtualPrice;
      selectedTimeSlot.refresh();
      log("updated list: $selectedTimeSlot");
      update(); // Notify UI
    }
  }

  // Updates the inpersonPrice of a specific timeSlot in the selectedTimeSlot list
  Future<void> updateInpersonPrice(String time, String inpersonPrice) async {
    final index = selectedTimeSlot.indexWhere((element) => element.time_allocation == time);
    if (index != -1) {
      selectedTimeSlot[index].in_person_pricing = inpersonPrice;
      selectedTimeSlot.refresh();
      log("updated list: $selectedTimeSlot");
      update(); // Notify UI
    }
  }

  // Reorders the selectedDays list based on the order of days in the week
  Future<List<PricingInfo>> reorderTimeSlot(List<PricingInfo> selectedTimeSlot) async {
    // Define the order of days in the week
    const List<String> weekDaysOrder = [
      '15 mins',
      '30 mins',
      '45 mins',
      '1 hr',
      '1 hr : 30 mins',
      '2 hrs',
      '4 hrs',
      '6 hrs',
      '8 hrs',
      //'Custom',
    ];

    // Create a map to define the order index of each time/duration
    Map<String, int> dayOrderMap = {
      for (int i = 0; i < weekDaysOrder.length; i++) weekDaysOrder[i]: i
    };

    // Sort the selectedTimeslot list based on the time order defined in timeOrderMap
    selectedTimeSlot.sort((a, b) => dayOrderMap[a.time_allocation]!.compareTo(dayOrderMap[b.time_allocation]!));

    // Return the sorted list
    return selectedTimeSlot;
  }

  

  /////////////////////////////////////////////////////
















  //////EDIT PACKAGE SERVICE SCREEN//////////
  //(save to db)
  final TextEditingController serviceNameControllerEdit = TextEditingController();
  final TextEditingController descriptionControllerEdit = TextEditingController();
  final TextEditingController addLinksControllerEdit = TextEditingController();
  final TextEditingController coreFeaturesControllerEdit= TextEditingController();

  //description textcontroller count
  int maxLengthEdit = 500;
  
  //for Stepper widget (starts to count at 0)
  getx.RxInt curentStepEdit = 0.obs;

  void handleTextChangedEdit(String val,) {
    // Check if character count exceeds the maximum
    if (val.length > maxLengthEdit) {
      descriptionControllerEdit.value = TextEditingValue(
        text: val.substring(0, maxLengthEdit),
        selection: TextSelection.collapsed(offset: maxLengthEdit),
      );
      debugPrint("You have reached max length");
    }
  }

  //to activate the next/done button in step 3 screen
  final isCheckBoxActiveEdit = false.obs;

  //show currency picker when adding/creating a service
  var addServiceCurrencyEdit = "".obs;
  Future<void> showNiceCurrencyPickerAddEdit({required BuildContext context}) async{
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
        addServiceCurrencyEdit.value = currency.symbol;
        print('Select currency: ${addServiceCurrencyEdit.value}');
      },
   );
  }
  /////////////////////////////////////////////////////



  //STEP 1//
  //core features list
  final inputsEdit = <String>[].obs;
  final isFeaturesTappedEdit = false.obs;
  
  // Function to add input to the core features list
  Future<void> addInputEdit(String input) async{
    inputsEdit.add(input);
    log("$inputsEdit");
    update();
  }

  // Function to remove input by index from the core features list
  Future<void> removeInputEdit(int index) async{
    inputsEdit.removeAt(index);
    log("$inputsEdit");
    update();
  }

  ////STEP 3////
  // List of days with selection status
  var daysEdit = <Map<String, dynamic>>[
    {'day': 'Monday', 'isSelected': false},
    {'day': 'Tuesday', 'isSelected': false},
    {'day': 'Wednesday', 'isSelected': false},
    {'day': 'Thursday', 'isSelected': false},
    {'day': 'Friday', 'isSelected': false},
    {'day': 'Saturday', 'isSelected': false},
    {'day': 'Sunday', 'isSelected': false},
  ];  //.obs;

  // List of selected days with their start and stop times
  //save to db
  var selectedDaysEdit = <DaySelectionModel>[].obs;

  // Toggles the selection status of a day, adding or removing it from the selectedDays list
  void toggleDaySelectionEdit(
    int index,
    String day, 
    bool? isSelected,
    String startTime,
    String stopTime,
  ) {
    final index2 = selectedDaysEdit.indexWhere((element) => element.day == day);
    daysEdit[index]['isSelected'] = isSelected;
    if (isSelected!) {
      log("$isSelected");
      addDayEdit(day, startTime, stopTime);
    } else {
      log("$isSelected");
      removeItemEdit(index: index2);
    }
    update();
  }

  //Retrieves the DaySelectionModel for a specific day
  DaySelectionModel? getDaySelectionEdit(String day) {
    return selectedDaysEdit.firstWhereOrNull((element) => element.day == day);
  }

  // Adds a day with its start and stop times to the selectedDays list
  Future<void> addDayEdit(String day, String startTime, String stopTime) async {
    selectedDaysEdit.add(DaySelectionModel(day: day, startTime: startTime, stopTime: stopTime));
    log("list: $selectedDaysEdit");
  }

  // Removes a day from the selectedDays list based on its index
  Future<void> removeItemEdit({required int index}) async {
    if (index >= 0 && index < selectedDaysEdit.length) {
      log("Item ${selectedDaysEdit[index]} removed at index $index");
      selectedDaysEdit.removeAt(index);
      selectedDaysEdit.refresh();
      log("updated list: $selectedDaysEdit");
    } else {
      print("Invalid index: $index");
    }
  }

  // Updates the start time of a specific day in the selectedDays list
  Future<void> updateStartTimeEdit(String day, String startTime) async {
    final index = selectedDaysEdit.indexWhere((element) => element.day == day);
    if (index != -1) {
      selectedDaysEdit[index].startTime = startTime;
      selectedDaysEdit.refresh();
      update(); // Notify UI
    }
  }

  // Updates the stop time of a specific day in the selectedDays list
  Future<void> updateStopTimEdit(String day, String stopTime) async {
    final index = selectedDaysEdit.indexWhere((element) => element.day == day);
    if (index != -1) {
      selectedDaysEdit[index].stopTime = stopTime;
      selectedDaysEdit.refresh();
      update(); // Notify UI
    }
  }

  // Reorders the selectedDays list based on the order of days in the week
  Future<List<DaySelectionModel>> reorderDaysEdit(List<DaySelectionModel> selectedDays) async {
    // Define the order of days in the week
    const List<String> weekDaysOrder = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    // Create a map to define the order index of each day
    Map<String, int> dayOrderMap = {
      for (int i = 0; i < weekDaysOrder.length; i++) weekDaysOrder[i]: i
    };

    // Sort the selectedDays list based on the day order defined in dayOrderMap
    selectedDaysEdit.sort((a, b) => dayOrderMap[a.day]!.compareTo(dayOrderMap[b.day]!));

    // Return the sorted list
    return selectedDaysEdit;
  }




  /////////////////////////////////////////////////////
  //ADD RETAINER SERVICE CREATION//
  ////STEP 2 EDIT////
  List<ServiceControllerSett> controllersEdit = List.generate(7, (int index) => ServiceControllerSett());
  final TextEditingController customTimeSlotControllerEdit = TextEditingController();
  final isCheckBoxActiveForPricingEdit = false.obs;
  final isCustomTextFieldActivatedEdit = false.obs;
  // List of time slots with selection status
  var priceSlotEdit = <Map<String, dynamic>>[
    {'time': '2 weeks', 'isSelected': false},
    {'time': '1 month', 'isSelected': false},
    {'time': '3 months', 'isSelected': false},
    {'time': '6 months', 'isSelected': false},
    {'time': '12 months', 'isSelected': false},
    {'time': '18 months', 'isSelected': false},
    {'time': '24 months', 'isSelected': false},
  ];  //.obs;

  // List of selected timeslots with their virtual and in-person price
  //save to db
  var selectedTimeSlotEdit = <PricingInfo>[].obs;

  // Toggles the selection status of a day, adding or removing it from the selectedDays list
  void toggleTimeSlotSelectionEdit(
    int index,
    String time, 
    bool? isSelected,
    String virtual,
    String inperson,
  ) {
    final index2 = selectedTimeSlotEdit.indexWhere((element) => element.time_allocation == time);
    priceSlotEdit[index]['isSelected'] = isSelected;
    ServiceControllerSett controllerSet = controllersEdit[index];
    //priceSlotEdit[index]['time'] = time;
    if (isSelected!) {
      log("$isSelected");
      addTimeEdit(time, virtual, inperson);
    } else {
      log("$isSelected");
      controllerSet.inpersonPriceController.clear();
      controllerSet.virtualPriceController.clear();
      removeTimeEdit(index: index2);
    }
    update();
  }

  //Retrieves the Price Info for a specific time
  PricingInfo? getTimeSelectionEdit(String time) {
    return selectedTimeSlotEdit.firstWhereOrNull((element) => element.time_allocation == time);
  }

  // Adds a day with its start and stop times to the selectedDays list
  Future<void> addTimeEdit(String time, String virtualPrice, String inpersonPrice) async {
    selectedTimeSlotEdit.add(PricingInfo(time_allocation: time, virtual_pricing: virtualPrice, in_person_pricing: inpersonPrice));
    log("list: $selectedTimeSlotEdit");
  }

  // Removes a day from the selectedDays list based on its index
  Future<void> removeTimeEdit({required int index}) async {
    if (index >= 0 && index < selectedTimeSlotEdit.length) {
      log("Item ${selectedTimeSlotEdit[index]} removed at index $index");
      selectedTimeSlotEdit.removeAt(index);
      selectedTimeSlotEdit.refresh();
      log("updated list: $selectedTimeSlotEdit");
    } 
    else {
      print("Invalid index: $index");
    }
  }

  // Updates the duration of a specific timeSlot in the selectedTimeSlot list
  Future<void> updateCustomDurationEdit(String time) async {
    final index = selectedTimeSlot.indexWhere((element) => element.time_allocation == time);
    if (index != -1) {
      selectedTimeSlot[index].time_allocation = time;
      selectedTimeSlot.refresh();
      update(); // Notify UI
    }
  }

  // Updates the virtualPrice of a specific timeSlot in the selectedTimeSlot list
  Future<void> updateVirtualPriceEdit(String time, String virtualPrice) async {
    final index = selectedTimeSlotEdit.indexWhere((element) => element.time_allocation == time);
    if (index != -1) {
      selectedTimeSlotEdit[index].virtual_pricing = virtualPrice;
      selectedTimeSlotEdit.refresh();
      update(); // Notify UI
    }
  }

  // Updates the inpersonPrice of a specific timeSlot in the selectedTimeSlot list
  Future<void> updateInpersonPriceEdit(String time, String inpersonPrice) async {
    final index = selectedTimeSlotEdit.indexWhere((element) => element.time_allocation == time);
    if (index != -1) {
      selectedTimeSlotEdit[index].in_person_pricing = inpersonPrice;
      selectedTimeSlotEdit.refresh();
      update(); // Notify UI
    }
  }

  // Reorders the selected time slot list based on the order of days in the week
  Future<List<PricingInfo>> reorderTimeSlotEdit(List<PricingInfo> selectedTimeSlot) async {
    // Define the order of days in the week
    const List<String> weekDaysOrder = [
      '15 mins', 
      '30 mins',
      '45 mins',
      '1 hr',
      '1 hr : 30 mins',
      '2 hrs',
      '4 hrs',
      '6 hrs',
      '8 hrs',
      //'Custom',
    ];

    // Create a map to define the order index of each time/duration
    Map<String, int> dayOrderMap = {
      for (int i = 0; i < weekDaysOrder.length; i++) weekDaysOrder[i]: i
    };

    // Sort the selectedTimeslot list based on the time order defined in timeOrderMap
    selectedTimeSlotEdit.sort((a, b) => dayOrderMap[a.time_allocation]!.compareTo(dayOrderMap[b.time_allocation]!));

    // Return the sorted list
    return selectedTimeSlotEdit;
  }
  

  /////////////////////////////////////////////////////







  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }




  @override
  void dispose() {
    // TODO: implement dispose
    serviceNameController.dispose();
    descriptionController.dispose();
    addLinksController.dispose();
    coreFeaturesController.dispose();


    serviceNameControllerEdit.dispose();
    descriptionControllerEdit.dispose();
    addLinksControllerEdit.dispose();
    coreFeaturesControllerEdit.dispose();
    super.dispose();
  }

}