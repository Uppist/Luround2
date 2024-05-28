import 'dart:developer';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/ui/dayselection_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_2/one-off_widgets/textcontroller_set.dart';










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
  
  ///service_screen list for package service list/// 
  var selectedIndex = 0.obs; //for toggling price of the services list,
  final isVirtual = true.obs;  //boolean to switch between prices in the services list


  void handleTabTap(int index) {
    isVirtual.value = !isVirtual.value;
    selectedIndex.value = index;
    print("price switch check: ${isVirtual.value}");
    update();
  }


  //STEP 1//
  //core features list
  final inputs = [].obs;
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
  //ADD ONE-OFF SERVICE CREATION//
  //STEP 2 (save to db)//
  List<ServiceControllerSett> controllers = [ServiceControllerSett(), ServiceControllerSett()]; //(save to db)

  

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
  final inputsEdit = [].obs;
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
  //STEP 2 (save to db)//
  List<ServiceControllerSett> controllersEdit = [ServiceControllerSett(), ServiceControllerSett()]; //(save to db)

  

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