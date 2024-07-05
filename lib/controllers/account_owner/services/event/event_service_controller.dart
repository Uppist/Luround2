import 'dart:developer';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/suspension_boolean.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/row_widget.dart';






class EventsController extends getx.GetxController {

  
  //SUSPEND SERVICE
  getx.RxBool isToggled = false.obs;
  getx.RxBool toggleLink = false.obs;
  getx.RxBool isTextGone = false.obs;
  
  void toggleService({
    required String serviceId, 
    required bool newValue, 
    required List<UserServiceModel> list
    }) {
    
    final service = list.firstWhere((service) => service.serviceId == serviceId);
    service.isActive = newValue;
    //newValue.value = isServiceSuspended(serviceStatus: service.serviceStatus);
    log('${newValue}');
  }

  //(save to db)
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addLinkController = TextEditingController();
  final TextEditingController addLocationController = TextEditingController();
  final TextEditingController inPersonPriceController = TextEditingController();
  final TextEditingController virtualPriceController = TextEditingController();

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
  
  
  //STEP2
  getx.RxString eventSchedule = "".obs;
  //date picker from flutter
  getx.RxString selectedDate = "".obs;
  //time picker from flutter
  getx.RxString selectedStartTime = "".obs;
  getx.RxString selectedStopTime = "".obs;


  //STEP3
  getx.RxString priceType = "".obs;
  

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
  ///service_screen list/// 
  //PUT IN THE CONTROLLER
  getx.RxInt selectedDurationIndex = 0.obs;
  getx.RxString selectedFieldIndex = 'Virtual'.obs;




  //ADD EVENT SERVICE CREATION//
  //STEP 2 (save to db)////
  // List to hold the dynamically added widgets
  getx.RxList<Widget> widgetList = <Widget>[].obs;
  
  // List to hold the data for backend(save)
  getx.RxList<Map<String, dynamic>> dataListForBackend = <Map<String, dynamic>>[].obs;

  // Counter to provide unique keys for each row
  int rowKeyCounter = 0;

  // Function to add a new row of widgets
  void addRow() {
    //increment the rowkeycounter
    int currentRowKey = rowKeyCounter++;
    
    //remove from the widget list w.r.t index
    widgetList.add(
      RowWidget(
      key: ValueKey(currentRowKey),
      onDelete: () => removeRow(currentRowKey),
      onDateSelected: (date) {
        setDate(currentRowKey, date);
      },
      onStartTimeSelected: (startTime) {
        setStartTime(currentRowKey, startTime);
      },
      onStopTimeSelected: (stopTime) {
        setStopTime(currentRowKey, stopTime);
      },
    ));

    //remove from the backend list w.r.t index
    dataListForBackend.add({
      'key': currentRowKey,
      'date': null,
      'start_time': null,
      'stop_time': null,
    });
    log("$dataListForBackendEdit");
    update();
  }

  // Function to remove a row of widgets
  void removeRow(int key) {
    widgetList.removeWhere((widget) => (widget.key as ValueKey).value == key);
    dataListForBackend.removeWhere((data) => data['key'] == key);
    log("$widgetList");
    log("$dataListForBackend");
    update();
  }

  // Function to set the date in dataListForBackend
  void setDate(int key, String date) {
    dataListForBackend.firstWhere((data) => data['key'] == key)['date'] = date;
    log("$dataListForBackend");
  }

  // Function to set the start time in dataListForBackend
  void setStartTime(int key, String startTime) {
    dataListForBackend.firstWhere((data) => data['key'] == key)['start_time'] = startTime;
    log("$dataListForBackend");
    update();
  }

  // Function to set the stop time in dataListForBackend
  void setStopTime(int key, String stopTime) {
    dataListForBackend.firstWhere((data) => data['key'] == key)['stop_time'] = stopTime;
    log("$dataListForBackend");
    update();
  }
  

















  /////////////////////////[EDIT SERVICE SCREEN COMPONENTS HERE]/////////////////////////////////////////////

  //(save to db)
  final TextEditingController serviceNameControllerEdit = TextEditingController();
  final TextEditingController descriptionControllerEdit = TextEditingController();
  final TextEditingController addLinkControllerEdit = TextEditingController();
  final TextEditingController addLocationControllerEdit = TextEditingController();
  final TextEditingController inPersonPriceControllerEdit = TextEditingController();
  final TextEditingController virtualPriceControllerEdit = TextEditingController();
  //checks if the user has inputed their prices in order to enable the button
  final isServiceNameTappedEdit = false.obs;

  //description textcontroller count
  int maxLengthEdit = 500;

  //for Stepper widget (starts to count at 0)
  getx.RxInt curentStepEdit = 0.obs;
  

  //STEP 2
  getx.RxString eventScheduleEdit = "".obs;
  //date picker from flutter
  getx.RxString selectedDateEdit = "".obs;
  //time picker from flutter
  getx.RxString selectedStartTimeEdit = "".obs;
  getx.RxString selectedStopTimeEdit = "".obs;


  //STEP3
  getx.RxString priceTypeEdit = "".obs;

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



  //EDIT EVENT SERVICE CREATION//
  //STEP 2 (save to db)////
  // List to hold the dynamically added widgets
  getx.RxList<Widget> widgetListEdit = <Widget>[].obs;
  
  // List to hold the data for backend(save)
  getx.RxList<Map<String, dynamic>> dataListForBackendEdit = <Map<String, dynamic>>[].obs;

  // Counter to provide unique keys for each row
  int rowKeyCounterEdit = 0;

  // Function to add a new row of widgets
  void addRowEdit() {
    //increment the rowkeycounter
    int currentRowKey = rowKeyCounterEdit++;
    
    //remove from the widget list w.r.t index
    widgetListEdit.add(
      RowWidget(
      key: ValueKey(currentRowKey),
      onDelete: () => removeRowEdit(currentRowKey),
      onDateSelected: (date) {
        setDateEdit(currentRowKey, date);
      },
      onStartTimeSelected: (startTime) {
        setStartTimeEdit(currentRowKey, startTime);
      },
      onStopTimeSelected: (stopTime) {
        setStopTimeEdit(currentRowKey, stopTime);
      },
    ));

    //remove from the backend list w.r.t index
    dataListForBackendEdit.add({
      'key': currentRowKey,
      'date': null,
      'start_time': null,
      'stop_time': null,
    });
    log("$dataListForBackendEdit");
    update();
  }

  // Function to remove a row of widgets
  void removeRowEdit(int key) {
    widgetListEdit.removeWhere((widget) => (widget.key as ValueKey).value == key);
    dataListForBackendEdit.removeWhere((data) => data['key'] == key);
    log("$widgetListEdit");
    log("$dataListForBackendEdit");
    update();
  }

  // Function to set the date in dataListForBackend
  void setDateEdit(int key, String date) {
    dataListForBackendEdit.firstWhere((data) => data['key'] == key)['date'] = date;
    log("$dataListForBackendEdit");
  }

  // Function to set the start time in dataListForBackend
  void setStartTimeEdit(int key, String startTime) {
    dataListForBackendEdit.firstWhere((data) => data['key'] == key)['start_time'] = startTime;
    log("$dataListForBackendEdit");
    update();
  }

  // Function to set the stop time in dataListForBackend
  void setStopTimeEdit(int key, String stopTime) {
    dataListForBackendEdit.firstWhere((data) => data['key'] == key)['stop_time'] = stopTime;
    log("$dataListForBackendEdit");
    update();
  }











  @override
  void onInit() {
    super.onInit();
  }




  @override
  void dispose() {
    // TODO: implement dispose
    serviceNameController.dispose();
    descriptionController.dispose();
    addLinkController.dispose();
    addLocationController.dispose();
    inPersonPriceController.dispose();
    virtualPriceController.dispose();

    serviceNameControllerEdit.dispose();
    descriptionControllerEdit.dispose();
    addLinkControllerEdit.dispose();
    addLocationControllerEdit.dispose();
    inPersonPriceControllerEdit.dispose();
    virtualPriceControllerEdit.dispose();
    super.dispose();
  }
}