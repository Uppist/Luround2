import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;








class TransactionsController extends getx.GetxController {

  final isTrxAmountToggled = false.obs;
  
  //filter transactions list
  final List<String> items = ['All time', 'Today', 'Yesterday', 'This week', 'Last 7 days', "Last 30 days", "This month"];
  final selectedValue = 'All time'.obs; //SAVED TO DB
  void filterList(String? newValue) {
    selectedValue.value = newValue!;
  }
  
  //for trx dashboard
  void toggleTrx() {
    isTrxAmountToggled.value = !isTrxAmountToggled.value;
    update();
  }
}