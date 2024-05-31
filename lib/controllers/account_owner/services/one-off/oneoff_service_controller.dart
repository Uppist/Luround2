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







class ServicesController extends getx.GetxController {
  
  //SUSPEND SERVICE
  getx.RxBool isToggled = false.obs;
  getx.RxBool toggleLink = false.obs;
  getx.RxBool isTextGone = false.obs;

  //(save to db)
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addLinksController = TextEditingController();
  //final TextEditingController inPersonController = TextEditingController();
  //final TextEditingController virtualController = TextEditingController();

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

  ////STEP 3////
  final isCheckBoxActive = false.obs;
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



  /////////////////////////////////////////////////////
  //ADD ONE-OFF SERVICE CREATION//
  //STEP 2 (save to db)//
  List<ServiceControllerSett> controllers = [ServiceControllerSett(), ServiceControllerSett()]; //(save to db)

  

  ///service_screen list/// 
  //PUT IN THE CONTROLLER
  getx.RxInt selectedDurationIndex = 0.obs;
  getx.RxString selectedFieldIndex = 'Virtual'.obs;
  

















  /////////////////////////[EDIT SERVICE SCREEN COMPONENTS HERE]/////////////////////////////////////////////

  //(save to db)
  final TextEditingController serviceNameControllerEdit = TextEditingController();
  final TextEditingController descriptionControllerEdit = TextEditingController();
  final TextEditingController addLinksControllerEdit = TextEditingController();
  
  //checks if the user has inputed their prices in order to enable the button
  final isServiceNameTappedEdit = false.obs;

  //description textcontroller count
  int maxLengthEdit = 500;

  //for Stepper widget (starts to count at 0)
  getx.RxInt curentStepEdit = 0.obs;

  ////STEP 3////
  final isCheckBoxActiveEdit = false.obs;
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
  Future<void> updateStopTimeEdit(String day, String stopTime) async {
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


  //show currency picker when adding/creating a service
  var editServiceCurrency = "".obs;
  Future<void> showNiceCurrencyPickerEdit({required BuildContext context}) async{
    showCurrencyPicker(
      physics: const BouncingScrollPhysics(),
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

  //save to db
  List<ServiceControllerSett> controllersEdit = [ServiceControllerSett(), ServiceControllerSett()];
  /////////////////////////////////////////////////////











  @override
  void onInit() {
    super.onInit();
  }




  @override
  void dispose() {
    // TODO: implement dispose
    serviceNameController.dispose();
    descriptionController.dispose();
    addLinksController.dispose();

    serviceNameControllerEdit.dispose();
    descriptionControllerEdit.dispose();
    addLinksControllerEdit.dispose();
    super.dispose();
  }

}