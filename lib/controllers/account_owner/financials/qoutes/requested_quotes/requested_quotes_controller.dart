import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/more/financials/quotes/received_quotes_response.dart';
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;






class RequestedQuotesController extends getx.GetxController {
  
  var quoteService = getx.Get.put(QuotesService());

  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlLink({required String link}) async{
    //String myPhoneNumber = "+234 07040571471";
    //Uri uri = Uri.parse(myPhoneNumber);
    Uri linkUri = Uri(
      scheme: 'https',
      path: link.replaceFirst("https://", "")
    );
    if(await launcher.canLaunchUrl(linkUri)) {
      launcher.launchUrl(
        linkUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $linkUri');
    }
  }

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
  Future<List<ReceivedQuotesResponse>> filterQuoteByDate() async{
    String startDateString = startDate();
    String endDateString = endDate();
    print("start date: $startDateString");
    print("end date: $endDateString");

    List<ReceivedQuotesResponse> result = quoteService.filteredReceivedQuotesList
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
    searchRequestedQuoteController.dispose();
    super.dispose();
  }
}