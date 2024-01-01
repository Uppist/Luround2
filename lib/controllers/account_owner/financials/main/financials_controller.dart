import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;






class FinancialsController extends getx.GetxController {


  /////[FOR QUOTES]/////////////
  final isFinancialsListEmpty = false.obs;
  //search textField
  //final isFieldTapped = false.obs;
  final isSearchProduct = false.obs;
  //final TextEditingController searchQuoteController = TextEditingController();
  final TextEditingController quoteNoteController = TextEditingController();
  final TextEditingController quoteClientEmailController = TextEditingController();
  final TextEditingController quoteClientNameController = TextEditingController();
  final TextEditingController quoteClientPhoneNumberController = TextEditingController();
  final TextEditingController searchProductsController = TextEditingController();

  
  var dates = <DateTime?>[].obs;

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

  //Edit added service screen/////
  final TextEditingController serviceDescController = TextEditingController();
  final TextEditingController meetingTypeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

   
  //for Speed dial floating action button (QUOTES)
  final isQuotesOpened = false.obs;







  /////[FOR INVOICE]/////////////
  final isInvoiceListEmpty = false.obs;
  //search textField
  final isSearchProductForInvoice = false.obs;
  final TextEditingController invoiceNoteController = TextEditingController();
  final TextEditingController invoiceClientEmailController = TextEditingController();
  final TextEditingController invoiceClientNameController = TextEditingController();
  final TextEditingController invoiceClientPhoneNumberController = TextEditingController();
  final TextEditingController searchProductsControllerForInvoice = TextEditingController();

  var datesForInvoice = <DateTime?>[].obs;

  ///CREATE INVOICE SECTION/////
  int maxLengthForInvoice = 500;
  //invoice date
  var invoiceDate = <DateTime?>[].obs;
  void selectedInvoiceDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      // Remove any previous items, if any
      invoiceDate.clear();
      // Add the new unique item
      invoiceDate.add(dateList[0]);
    }
  }
  //(save to db) this is the selected date 
  String updatedInvoiceDate ({required String initialDate}) {
    if(quoteDate.isNotEmpty) {
      var result = invoiceDate[0].toString();
      var refinedStr = result.substring(0, 10);
      print(refinedStr);
      return refinedStr;
    }
    return initialDate;
  }

  //due date for invoice
  var dueDateForInvoice = <DateTime?>[].obs;
  void selectedDueDateForInvoice(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      // Remove any previous items, if any
      dueDateForInvoice.clear();
      // Add the new unique item
      dueDateForInvoice.add(dateList[0]);
    }
  }
  //(save to db) this is the selected date 
  String updatedDueDateForInvoice ({required String initialDate}) {
    if(dueDateForInvoice.isNotEmpty) {
      var result = dueDateForInvoice[0].toString();
      var refinedStr = result.substring(0, 10);
      print(refinedStr);
      return refinedStr;
    }
    return initialDate;
  }

  //EDIT ADDED SERVICE SCREEN FOR INVOICE/////
  final TextEditingController serviceDescControllerForInvoice = TextEditingController();
  final TextEditingController meetingTypeControllerForInvoice = TextEditingController();
  final TextEditingController rateControllerForInvoice = TextEditingController();
  final TextEditingController durationControllerForInvoice = TextEditingController();
  final TextEditingController discountControllerForInvoice = TextEditingController();

  //for Speed dial floating action button (QUOTES)
  final isInvoiceOpened = false.obs;







  @override
  void dispose() {
    
    ////QUOTES CONTROLLERS///
    quoteNoteController.dispose();
    quoteClientEmailController.dispose();
    quoteClientNameController.dispose();
    quoteClientPhoneNumberController.dispose();
    searchProductsController.dispose();

    serviceDescController.dispose();
    meetingTypeController.dispose();
    rateController.dispose();
    durationController.dispose();
    discountController.dispose();


    ////INVOICE CONTROLLERS///
    invoiceNoteController.dispose();
    invoiceClientEmailController.dispose();
    invoiceClientNameController.dispose();
    invoiceClientPhoneNumberController.dispose();
    searchProductsControllerForInvoice.dispose();

    serviceDescControllerForInvoice.dispose();
    meetingTypeControllerForInvoice.dispose();
    rateControllerForInvoice.dispose();
    durationControllerForInvoice.dispose();
    discountControllerForInvoice.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}