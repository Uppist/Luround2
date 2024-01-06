import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';






class RequestedQuotesController extends getx.GetxController {
  
  var quoteService = getx.Get.put(QuotesService());

  //for search textfield text cancellation
  final isNoteTapped = false.obs;
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
  

  //filter
  Future<List<dynamic>> filterQuoteByDate() async{
    //Convert the start and end date strings to DateTime objects
    DateTime startDateTime = DateTime.parse(startDate());
    DateTime endDateTime = DateTime.parse(endDate());
    print("conv datetime: $startDateTime");
    print("conv datetime: $endDateTime");

    //Filter the invoice list based on the date range
    List<dynamic> result = quoteService.filteredReceivedQuotesList
    .where((user) {
    DateTime quoteDate = DateTime.parse(user['date']);

    // Check if the invoice date is within the selected range
    return quoteDate.isAfter(startDateTime.subtract(Duration(days: 1))) &&
      quoteDate.isBefore(endDateTime.add(Duration(days: 1)));
    }).toList();

    print("filtered by date quote list: ${result}");
    return result;
  }




  
  
  @override
  void dispose() {
    // TODO: implement dispose
    searchRequestedQuoteController.dispose();
    super.dispose();
  }
}