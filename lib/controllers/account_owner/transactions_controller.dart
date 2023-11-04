import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;






class TransactionsController extends getx.GetxController {

  final isTrxAmountToggled = false.obs;
  
  //filter transactions list
  final List<String> items = ['Weekly', 'Monthly', 'Yearly'];
  final selectedValue = 'Weekly'.obs; //SAVED TO DB
  void filterList(String? newValue) {
    selectedValue.value = newValue!;
  }
  
  //for trx dashboard
  void toggleTrx() {
    isTrxAmountToggled.value = !isTrxAmountToggled.value;
    update();
  }
}