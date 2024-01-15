import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/more/financials/invoice_service.dart';






class PaidInvoiceController extends getx.GetxController {
  
  var invoiceService = getx.Get.put(InvoicesService());


  //to expnad the column
  final isServiceTapped = false.obs;
  final isNoteTapped = false.obs;
  //TODO
  final isFinancialsListEmpty = false.obs;
  
  final TextEditingController searchPaidInvoiceController = TextEditingController();

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
  Future<List<dynamic>> filterInvoiceByDate() async{

    String startDateString = startDate();
    String endDateString = endDate();
    print("start date: $startDateString");
    print("end date: $endDateString");

    List<dynamic> result = invoiceService.filteredPaidInvoiceList
      .where((user) {
        String invoiceDateString = user['invoice_date'];

        // Assuming the date strings are in the format "yyyy-MM-dd"
        return invoiceDateString.compareTo(startDateString) >= 0 &&
            invoiceDateString.compareTo(endDateString) <= 0;
      })
      .toList();

    print("filtered by date list: ${result}");
    return result;
  }
  





  @override
  void dispose() {
    // TODO: implement dispose
    searchPaidInvoiceController.dispose();
    super.dispose();
  }
}