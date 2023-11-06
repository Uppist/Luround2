import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;










class FinancialsController extends getx.GetxController {

  //financials list
  final isFinancialsListEmpty = false.obs;
  
  //search textField
  final isFieldTapped = false.obs;
  final TextEditingController searchController = TextEditingController();

  //filter financials list drop down
  final List<String> items = [
    'All time      ', 
    'Today      ', 
    'Yesterday      ', 
    'This week      ',
    'Last 90 days        ', //8
    "Last 30 days        ", //8
    "This month      " //6
  ];
  final selectedValue = 'All time      '.obs; //SAVED TO DB
  void filterList(String? newValue) {
    selectedValue.value = newValue!;
  }

  //for Speed dial floating action button
  final isOpened = false.obs;






  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}