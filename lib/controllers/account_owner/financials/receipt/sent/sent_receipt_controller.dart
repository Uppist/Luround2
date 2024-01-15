import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/more/financials/receipt_service.dart';






class SentReceiptController extends getx.GetxController {

  var receiptService = getx.Get.put(ReceiptsService());
  
  //to expnad the column
  final isServiceTapped = false.obs;
  final isNoteTapped = false.obs;
  //TODO
  final isFinancialsListEmpty = false.obs;
  
  final TextEditingController searchSentReceiptController = TextEditingController();

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
  
  
  //filter
  Future<List<dynamic>> filterReceiptByDate() async{

    String startDateString = startDate();
    String endDateString = endDate();
    print("start date: $startDateString");
    print("end date: $endDateString");

    List<dynamic> result = receiptService.filteredSentReceiptList
      .where((user) {
        String receiptDateString = user['receipt_date'];

        // Assuming the date strings are in the format "yyyy-MM-dd"
        return receiptDateString.compareTo(startDateString) >= 0 &&
          receiptDateString.compareTo(endDateString) <= 0;
      })
      .toList();

    print("filtered by date list: ${result}");
    return result;
  }






  @override
  void dispose() {
    // TODO: implement dispose
    searchSentReceiptController.dispose();
    super.dispose();
  }
}