import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;







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
  getx.RxString isoDateForQuote = ''.obs;
  String updatedDueDate ({required String initialDate}) {
    if(dueDate.isNotEmpty) {
      isoDateForQuote.value = dueDate[0]!.toUtc().toIso8601String();
      print(isoDateForInvoice.value);
      //var result = dueDate[0].toString();
      //var refinedStr = result.substring(0, 10);
      //print(refinedStr);
      return isoDateForQuote.value;
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
  
  ////API////






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
    if(invoiceDate.isNotEmpty) {
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
  getx.RxString isoDateForInvoice = ''.obs;
  String updatedDueDateForInvoice ({required String initialDate}) {
    if(dueDateForInvoice.isNotEmpty) {
      isoDateForInvoice.value = dueDateForInvoice[0]!.toUtc().toIso8601String();
      print(isoDateForInvoice.value);
      //var result = dueDateForInvoice[0].toString();
      //var refinedStr = result.substring(0, 10);
      //print(refinedStr);
      return isoDateForInvoice.value;
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







  /////[FOR RECEIPT]/////////////
  final isReceiptListEmpty = false.obs;
  //search textField
  final isSearchProductForReceipt = false.obs;
  final TextEditingController receiptNoteController = TextEditingController();
  final TextEditingController receiptClientEmailController = TextEditingController();
  final TextEditingController receiptClientNameController = TextEditingController();
  final TextEditingController receiptClientPhoneNumberController = TextEditingController();
  final TextEditingController searchProductsControllerForReceipt = TextEditingController();

  var datesForReceipt = <DateTime?>[].obs;

  ///CREATE RECEIPT SECTION/////
  int maxLengthForReceipt = 500;

  //receipt date
  var receiptDate = <DateTime?>[].obs; 

  void selectedReceiptDate(List<DateTime?> dateList) {
    if (dateList.isNotEmpty) {
      // Remove any previous items, if any
      receiptDate.clear();
      // Add the new unique item
      receiptDate.add(dateList[0]);
    }
  }

  //(save to db) this is the selected date 
  String updatedReceiptDate ({required String initialDate}) {
    if(receiptDate.isNotEmpty) {
      var result = receiptDate[0].toString();
      var refinedStr = result.substring(0, 10);
      print(refinedStr);
      return refinedStr;
    }
    return initialDate;
  }

  
  //EDIT ADDED SERVICE SCREEN FOR RECEIPT/////
  final TextEditingController serviceDescControllerForReceipt = TextEditingController();
  final TextEditingController meetingTypeControllerForReceipt = TextEditingController();
  final TextEditingController rateControllerForReceipt = TextEditingController();
  final TextEditingController durationControllerForReceipt = TextEditingController();
  final TextEditingController discountControllerForReceipt = TextEditingController();

  //for Speed dial floating action button (RECEIPTS)
  final isReceiptOpened = false.obs;

  //mode of payment value for create receipt screen (DROPDOWM MENU FIELD) (RECEIPTS)
  final selectedModeOfPayment = "Card".obs; //save to db
  final listOfModeOfPayments = <String>["Card", "Transfer", "Others"];

  
  

  //C




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


    ////RECEIPT CONTROLLERS////
    receiptNoteController.dispose();
    receiptClientEmailController.dispose();
    receiptClientNameController.dispose();
    receiptClientPhoneNumberController.dispose();
    searchProductsControllerForInvoice.dispose();

    serviceDescControllerForReceipt.dispose();
    meetingTypeControllerForReceipt.dispose();
    rateControllerForReceipt.dispose();
    durationControllerForReceipt.dispose();
    discountControllerForReceipt.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}