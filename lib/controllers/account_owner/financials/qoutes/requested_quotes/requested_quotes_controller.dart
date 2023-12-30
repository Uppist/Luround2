import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;






class RequestedQuotesController extends getx.GetxController {
  

  //for search textfield text cancellation
  final isFieldTapped = false.obs;
  //
  final isFinancialsListEmpty = false.obs;
  
  final TextEditingController searchRequestedQuoteController = TextEditingController();

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
  @override
  void dispose() {
    // TODO: implement dispose
    searchRequestedQuoteController.dispose();
    super.dispose();
  }
}