import 'dart:developer';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_2/one-off_widgets/textcontroller_set.dart';







class EventsController extends getx.GetxController {
  //SUSPEND SERVICE
  getx.RxBool isToggled = false.obs;
  getx.RxBool toggleLink = false.obs;
  getx.RxBool isTextGone = false.obs;

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