import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';







class TransactionsController extends getx.GetxController {
  
  //var service = getx.Get.put(WithdrawalService());

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
    //'This week    ', 
    'Last 7 days    ', 
    "Last 30 days    ", //4
    //"This month    "
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

  Future<void> filterMoneyTypeList(String? newValue) async{
    selectedMoneyType.value = newValue!;
  }
  




  ///////////////////////[WALLETS SECTION]/////////////////////////////////
  //SHOW SAVED BANKS SCREEN//
  final searchSavedBankController = TextEditingController();

  ////ADD ACCOUNT FROM BUTTON////
  final inputBankController = TextEditingController();
  final inputBankCodeController = TextEditingController();
  getx.RxString bankCodeFB = ''.obs;
  final inputAccountNameController = TextEditingController();
  final inputAccountNumberController = TextEditingController();

  ///SELECT BAMK SCREEN (ADD ACCOUNT FROM BUTTON)///
  final searchBankController = TextEditingController();
  getx.RxString selectedBank = ''.obs;


  ////NEW ACCOUNT TAB (2)////
  final enterBankController = TextEditingController();
  final enterBankCodeController = TextEditingController();
  getx.RxString bankCode = ''.obs;
  final enterAccountNameController = TextEditingController();
  final enterAccountNumberController = TextEditingController();

  ///SELECT BAMK SCREEN (NEW ACCOUNT TAB)///
  final searchBankController2 = TextEditingController();
  getx.RxString selectedBank2 = ''.obs;

  //TRANSFER SCREEN//
  getx.RxString firstTimeOTP = ''.obs;  //to create wallet pin
  getx.RxString verifyFirstTimeOTP = ''.obs;  //to verify wallet pin
  final TextEditingController selectedCountryController = TextEditingController();

  final enterAmountController = TextEditingController();
  final enterRemarkController = TextEditingController();
  var isTrxNextButtoReady = false.obs;
  final enterTrxPinController = TextEditingController();












  
  @override
  void dispose() {
    // TODO: implement dispose
    inputBankCodeController.dispose();
    enterBankCodeController.dispose();
    selectedCountryController.dispose();
    inputBankController.dispose();
    inputAccountNameController.dispose();
    inputAccountNumberController.dispose();
    searchBankController.dispose();
    searchSavedBankController.dispose();
    enterAccountNumberController.dispose();
    enterBankController.dispose();

    //enterAccountNameController.dispose(); ////

    //transfer screen
    enterRemarkController.dispose();
    enterTrxPinController.dispose();
    super.dispose();
  }


}