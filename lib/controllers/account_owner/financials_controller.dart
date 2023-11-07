import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;










class FinancialsController extends getx.GetxController {

  //financials list
  final isFinancialsListEmpty = false.obs;
  
  //search textField
  final isFieldTapped = false.obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController quoteNoteController = TextEditingController();

  //filter by date range
  var dates = <DateTime?>[].obs;
  void selectedDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      dates.value = dateList;
      update();
    }
  }
  //(save both dates below to db)
  String startDate () {
    if(dates.isNotEmpty && dates.length >= 2) {
      print(dates);
      var result = dates[0].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "from";
  }
  String endDate () {
    print(dates);
    if(dates.isNotEmpty && dates.length >= 2) {
      var result = dates[1].toString();
      var refinedList = result.substring(0, 10);
      print(refinedList);
      return refinedList;
    }
    return "to";
  }
  ////////////////////////////
  


  ///CREATE QUOTE SECTION/////
  int maxLength = 500;
  //quote date
  var quoteDate = <DateTime?>[].obs;
  void selectedQuoteDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      // Remove any previous items, if any
      quoteDate.clear();
      // Add the new unique item
      quoteDate.add(dateList[0]);
    }
  }
  //(save to db) this is the selected date 
  String updatedQuoteDate ({required String initialDate}) {
    if(quoteDate.isNotEmpty) {
      var result = quoteDate[0].toString();
      var refinedStr = result.substring(0, 10);
      print(refinedStr);
      return refinedStr;
    }
    return initialDate;
  }

  //due date
  var dueDate = <DateTime?>[].obs;
  void selectedDueDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      // Remove any previous items, if any
      dueDate.clear();
      // Add the new unique item
      dueDate.add(dateList[0]);
    }
  }
  //(save to db) this is the selected date 
  String updatedDueDate ({required String initialDate}) {
    if(dueDate.isNotEmpty) {
      var result = dueDate[0].toString();
      var refinedStr = result.substring(0, 10);
      print(refinedStr);
      return refinedStr;
    }
    return initialDate;
  }







  //for Speed dial floating action button
  final isOpened = false.obs;






  @override
  void dispose() {
    searchController.dispose();
    quoteNoteController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}