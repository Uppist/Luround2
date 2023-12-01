import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;








class TransactionsController extends getx.GetxController {

  final TextEditingController selectedCountryController = TextEditingController();
  
  //for trx dashboard
  final isTrxAmountToggled = false.obs;
  
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
  
  //for trx dashboard
  void toggleTrx() {
    isTrxAmountToggled.value = !isTrxAmountToggled.value;
    update();
  }
  














  
  @override
  void dispose() {
    // TODO: implement dispose
    selectedCountryController.dispose();
    super.dispose();
  }







  //test run
  void zipFunc() async{

    List<Map<String, dynamic>> list1 = [
      {'id': 1, 'name': 'John'},
      {'id': 2, 'name': 'Alice'},
    ];

    List<Map<String, dynamic>> list2 = [
      {'age': 25, 'city': 'New York'},
      {'age': 30, 'city': 'San Francisco'},
    ];

    //List<Map<String, dynamic>> appendedList = [];

    // Append maps from list1 to appendedList
    /*appendedList.addAll(list1);8

    // Alternatively, using the spread operator
    appendedList = [...appendedList, ...list2];*/

    //print(appendedList);

    list1.addAll(list2);

    print(list1);

  }




}