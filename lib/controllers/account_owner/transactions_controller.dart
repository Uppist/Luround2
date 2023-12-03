import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;








class TransactionsController extends getx.GetxController {

  final TextEditingController selectedCountryController = TextEditingController();
  var isCountrySelected = false.obs;
  var isBankSelected = false.obs;
  var isBankSelected2 = false.obs;
  var isButtonActive = false.obs;

  //for trx dashboard
  var isTrxAmountToggled = false.obs;
  //for trx dashboard
  void toggleTrx() {
    isTrxAmountToggled.value = !isTrxAmountToggled.value;
    update();
  }
  
  //filter transactions list
  final List<String> items = [
    'All time    ', 
    'Today    ', 
    'Yesterday    ', 
    'This week    ', 
    'Last 7 days    ', 
    "Last 30 days    ", //4
    "This month    "
  ];
  final selectedValue = 'All time    '.obs; //SAVED TO DB

  void filterList(String? newValue) {
    selectedValue.value = newValue!;
  }

  //filter/toggle between funds
  final List<String> moneyType = [
    'Total amount received    ', 
    'Total amount paid    ', 
    'wallet    ',   //4
  ];
  final selectedMoneyType = 'Total amount received    '.obs; //SAVED TO DB

  void filterMoneyTypeList(String? newValue) {
    selectedMoneyType.value = newValue!;
  }
  




  ///////////////////////[WALLETS SECTION]/////////////////////////////////
  //SHOW SAVED BANKS SCREEN//
  final searchSavedBankController = TextEditingController();

  ////ADD ACCOUNT FROM BUTTON////
  final inputBankController = TextEditingController();
  final inputAccountNameController = TextEditingController();
  final inputAccountNumberController = TextEditingController();

  ///SELECT BAMK SCREEN (ADD ACCOUNT FROM BUTTON)///
  final searchBankController = TextEditingController();


  ////NEW ACCOUNT TAB////
  final enterBankController = TextEditingController();
  final enterAccountNameController = TextEditingController();
  final enterAccountNumberController = TextEditingController();

  ///SELECT BAMK SCREEN (NEW ACCOUNT TAB)///
  final searchBankController2 = TextEditingController();

  //TRANSFER SCREEN//
  getx.RxString firstTimeOTP = ''.obs;  //to create wallet pin
  getx.RxString verifyFirstTimeOTP = ''.obs;  //to verify wallet pin
  final enterAmountController = TextEditingController();
  final enterRemarkController = TextEditingController();
  var isTrxNextButtoReady = false.obs;
  final enterTrxPinController = TextEditingController();












  
  @override
  void dispose() {
    // TODO: implement dispose
    selectedCountryController.dispose();
    inputBankController.dispose();
    inputAccountNameController.dispose();
    inputAccountNumberController.dispose();
    searchBankController.dispose();
    searchSavedBankController.dispose();
    enterAccountNumberController.dispose();
    enterBankController.dispose();

    enterAccountNameController.dispose(); ////

    //transfer screen
    enterRemarkController.dispose();
    enterTrxPinController.dispose();
    super.dispose();
  }


}