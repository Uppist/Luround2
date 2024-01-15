import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/more/financials/quotes/sent_quotes_response_model.dart';
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';






class SentQuotesController extends getx.GetxController {
   
  var quoteService = getx.Get.put(QuotesService());

  //to expand the column
  final isServiceTapped = false.obs;
  final isNoteTapped = false.obs;
  //TODO
  final isFinancialsListEmpty = false.obs;
  
  final TextEditingController searchQuoteController = TextEditingController();

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
  Future<List<SentQuotesResponse>> filterQuoteByDate() async{
    
    String startDateString = startDate();
    String endDateString = endDate();
    print("start date: $startDateString");
    print("end date: $endDateString");

    List<SentQuotesResponse> result = quoteService.filteredSentQuotesList
      .where((user) {
        String quoteDateString = user.quote_date;

        // Assuming the date strings are in the format "yyyy-MM-dd"
        return quoteDateString.compareTo(startDateString) >= 0 &&
            quoteDateString.compareTo(endDateString) <= 0;
      })
      .toList();

    print("filtered by date quote list: ${result}");
    return result;
  }





  @override
  void dispose() {
    // TODO: implement dispose
    searchQuoteController.dispose();
    super.dispose();
  }
}