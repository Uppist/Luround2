import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';










class FinancialsService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var finController = getx.Get.put(FinancialsController());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var user_email = LocalStorage.getUseremail();
  var user_name = LocalStorage.getUsername();





  //API LIST//
  var dataList = <UserServiceModel>[].obs;
  




  //FOR QUOTES//
  var quotebslist = <Map<String, dynamic>>[].obs;
  var filteredQoutebslist = <Map<String, dynamic>>[].obs;
  var selectedQuotebslist = <Map<String, dynamic>>[].obs;


  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR QUOTES]///
  Future <List<Map<String, dynamic>>> loadServicesDataForQuote() async {
    try {
      isLoading.value = true;

      final List<UserServiceModel> products = await getUserServices();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));
      isLoading.value = false;
      //filteredList.value = List.from(products);
      //Populate filteredQoutebslist using map
      quotebslist.value = products.map((userModel) => userModel.toJson()).toList();

      // Print the modified list
      print("Qoutebslist: $quotebslist");
      return quotebslist;

    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  //working well
  Future<void> filterProducts(String query) async {
    if (query.isEmpty) {
      filteredQoutebslist.clear();
      filteredQoutebslist.addAll(quotebslist);
      print("when query is empty: $filteredQoutebslist");
    } 
    else {
      filteredQoutebslist.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredQoutebslist.addAll(quotebslist
        .where((user) => user['service_name'].toString().toLowerCase().contains(query.toLowerCase())) // == query
        .toList());
      print("when query is not empty: $filteredQoutebslist");
    }
    update();
  }
  

  ///[CREATE QUOTES SCREEN] ////THIS
  


  ///////////////////
  var reactiveTotalForQoute = "".obs;
  var reactiveSubtotalForQuote = "".obs;
  var reactiveTotalDiscountForQuote = "".obs;
  var reactiveTotalVATForQuote = "".obs;
  void showEverythingForQuoteList() {
    double subtotalPrice = 0;
    double totalPrice = 0;
    double totalDiscount = 0;
    double totalVat = 0;

    for (var product in selectedQuotebslist) {
      subtotalPrice += double.parse(product['rate']);
      totalDiscount += double.parse(product['discount']);
      totalVat += double.parse(product['total']) * 0.075;
      totalPrice += double.parse(product['total']);
    }
    ///////////////////
    reactiveTotalForQoute.value = (totalPrice + totalVat).toString();
    reactiveSubtotalForQuote.value = subtotalPrice.toString();
    reactiveTotalDiscountForQuote.value = totalDiscount.toString();
    reactiveTotalVATForQuote.value = totalVat.toString();
  }



  /////////////////
  //1
  Future<void> deleteSelectedProductForQuote(int index) async{
    isLoading.value = true;
    if (selectedQuotebslist.isNotEmpty) {
      isLoading.value = false;
      selectedQuotebslist.removeAt(index);
      print("list: $selectedQuotebslist");
      //clear the figures
    } else {
      isLoading.value = false;
      debugPrint("the item has already been removed at the index");
    }
    update();
  }
  
  //2(these act like text editing controllers)
  getx.RxString serviceDescriptionForQuote = "".obs; //
  getx.RxString durationForQuote = "".obs; //(not in use)
  getx.RxString rateForQuote = "".obs; //valid
  getx.RxString selectedMeetingTypeForQuote = "".obs; //valid
  getx.RxString discountForQuote = "".obs; //valid
  getx.RxString convertedToLocalCurrencyDiscountForQuote = "".obs; //valid
  getx.RxString subTotalForQuote = "".obs; //valid



  Future<void> calculateDiscount({required int index, required BuildContext context, required String initialRateValue, required String initialDiscountValue}) async {

    // Convert parameters from string to double data type
    double discountValue = double.tryParse(discountForQuote.value.isEmpty ? initialDiscountValue : discountForQuote.value) ?? 0;
    double rateValue = double.tryParse(rateForQuote.value.isEmpty ? initialRateValue : rateForQuote.value) ?? 0;

    // Calculate the discount
    double calculatedDiscount = (discountValue / 100) * rateValue;

    // Calculate the new total after the discount has been subtracted from it
    double newSubtotal = rateValue - calculatedDiscount;
    debugPrint("Calculated Discount: $calculatedDiscount");
    debugPrint("New Subtotal: $newSubtotal");
  
    convertedToLocalCurrencyDiscountForQuote.value = calculatedDiscount.toString();
    subTotalForQuote.value = newSubtotal.toString();

    //updated from here
    final indexed_subtotal = <String, dynamic>{"discounted_total": newSubtotal.toString(),};
    selectedQuotebslist[index].addEntries(indexed_subtotal.entries);
    print("updated list with total updated: $selectedQuotebslist");
  
    //success snackbar
    showMySnackBar(
      context: context,
      backgroundColor: AppColor.darkGreen,
      message: "your discounted total is N$newSubtotal"
    );
    ///
    update();
  }

  
  //4
  Future<void> editProductForCreatingQuote({
    required BuildContext context,
    required String service_name,
    required String discount,
    required String service_description,
    required String rate,
    required String duration,
    required String meetingType,
    required int index,
    required String total, 
  }) async{

    isLoading.value = true;
    //Find the index of the item you want to modify
    if (index != -1) {

      isLoading.value = false;

      // Modify the values of the found item in the originally selected list
      selectedQuotebslist[index]["description"] = service_description;
      selectedQuotebslist[index]["duration"] = duration;
      selectedQuotebslist[index]["discount"] = discount;
      selectedQuotebslist[index]["total"] = total;
      selectedQuotebslist[index]["meeting_type"] = meetingType;
      selectedQuotebslist[index]["appointment_type"] = meetingType;
      selectedQuotebslist[index]["rate"] = rate;

      //success snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.darkGreen,
        message: "item edited and saved successfully"
      ).whenComplete(() => getx.Get.back());
    } 
    else {
      isLoading.value = false;
      debugPrint("Item not found in the list.");
    }
    update();
  }

  
  ///[DELETE QUOTE FROM DB]//
  Future<void> deleteQuoteFromDB({
    required BuildContext context,
    required String quote_id,
    }) async {

    isLoading.value = true;

    var body = {};

    try {
      http.Response res = await baseService.httpDelete(endPoint: "quotes/delete-quote?quote_id=$quote_id", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("quote deleted by id successfully from database");

        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "quote deleted successfully"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to delete quote ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
    update();
  }

  //5
  ///[CREATE NEW QUOTE AND SAVE IT TO DB]//
  Future<void> createNewQuoteAndSendToDB({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String note,
    required String quote_date,
    required String quote_due_date
    }) async {

    isLoading.value = true;

    var body = {
      "status": "SAVED",
      "appointment_type": "already in the product detail list",
      "quote_date": quote_date,
      "send_to_name": client_name,
      "send_to_email": client_email,
      "phone_number": client_phone_number,
      "due_date": quote_due_date,
      "vat": reactiveTotalVATForQuote.value,
      "sub_total": reactiveSubtotalForQuote.value,
      "discount": "-N${reactiveTotalDiscountForQuote.value} ",
      "total": reactiveTotalForQoute.value,
      "product_detail": selectedQuotebslist,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "quotes/save-quote", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("quote created and saved successfully to database");
        finController.quoteClientNameController.clear();
        finController.quoteClientEmailController.clear();
        finController.quoteClientPhoneNumberController.clear();

        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "quote created and saved successfully"
        );
        //.whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to save quote ${res.body}"
        );
        //.whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
    update();
  }

  ///[CREATE NEW QUOTE AND SEND IT TO CLIENT]//
  Future<void> createNewQuoteAndSendToClient({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String note,
    required String quote_date,
    required String quote_due_date
    }) async {

    isLoading.value = true;

    var body = {
      "status": "SENT",
      "appointment_type": "already in the product detail list",
      "quote_date": quote_date,
      "send_to_name": client_name,
      "send_to_email": client_email,
      "phone_number": client_phone_number,

      "due_date": quote_due_date,
      "vat": reactiveTotalVATForQuote.value,
      "sub_total": reactiveSubtotalForQuote.value,
      "discount": "-N${reactiveTotalDiscountForQuote.value} ",
      "total": reactiveTotalForQoute.value,
      "product_detail": selectedQuotebslist
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "quotes/send-quote", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("quote created and saved successfully to database");
        finController.quoteClientNameController.clear();
        finController.quoteClientEmailController.clear();
        finController.quoteClientPhoneNumberController.clear();

        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "quote created and saved successfully"
        );
        //.whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to save quote ${res.body}"
        );
        //.whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
    update();
  }



  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$user_email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        final List<UserServiceModel> finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();

        dataList.clear();
        dataList.addAll(finalResult);
        debugPrint("user list of services: $dataList");

        // Return the user services list
        return dataList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    }
  }
  ////////////////////////////////////////////////////////////







  ////FOR INVOICE/////
  var invoicebslist = <Map<String, dynamic>>[].obs;
  var filteredInvoicebslist = <Map<String, dynamic>>[].obs;
  var selectedInvoicebslist = <Map<String, dynamic>>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR INVOICE]///
  Future <List<Map<String, dynamic>>> loadServicesDataForInvoice() async {
    try {
      isLoading.value = true;

      final List<UserServiceModel> products = await getUserServices();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));
      isLoading.value = false;
      //filteredList.value = List.from(products);
      //Populate filteredQoutebslist using map
      invoicebslist.value = products.map((userModel) => userModel.toJson()).toList();

      // Print the modified list
      print("Invoicebslist: $invoicebslist");
      return invoicebslist;
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  //working well
  Future<void> filterProductsForInvoice(String query) async {
    if (query.isEmpty) {
      filteredInvoicebslist.clear();
      filteredInvoicebslist.addAll(invoicebslist);
      print("when query is empty: $filteredInvoicebslist");
    } 
    else {
      filteredInvoicebslist.clear(); // Clear the previous filtered list
      // Use .addAll() to add the filtered items to the list
      filteredInvoicebslist.addAll(invoicebslist
        .where((user) => user['service_name'].toString().toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredInvoicebslist");
      update();
    }
  }
  

  ///[CREATE INVOICE SCREEN]

  ///////////////////h
  var reactiveTotalForInvoice = "".obs;
  var reactiveSubtotalForInvoice = "".obs;
  var reactiveTotalDiscountForInvoice = "".obs;
  var reactiveTotalVATForInvoice = "".obs;
  void showEverythingForInvoiceList() {
    double subtotalPrice = 0;
    double totalPrice = 0;
    double totalDiscount = 0;
    double totalVat = 0;

    for (var product in selectedInvoicebslist) {
      subtotalPrice += double.parse(product['rate']);
      totalPrice += double.parse(product['total']);
      totalDiscount += double.parse(product['discount']);
      totalVat += double.parse(product['total']) * 0.075;
    }
    ///////////////////
    reactiveTotalForInvoice.value = (totalPrice + totalVat).toString();
    reactiveSubtotalForInvoice.value = subtotalPrice.toString();
    reactiveTotalDiscountForInvoice.value = totalDiscount.toString();
    reactiveTotalVATForInvoice.value = totalVat.toString();
  }




  /////////////////
  //1
  Future<void> deleteSelectedProductForInvoice(int index) async{
    isLoading.value = true;
    if (selectedInvoicebslist.isNotEmpty) {
      isLoading.value = false;
      selectedInvoicebslist.removeAt(index);
      print("list: $selectedInvoicebslist");
      update();
      //clear the figures
    } else {
      isLoading.value = false;
      debugPrint("the item has already been removed at the index");
    }
  }
  
  //2(these act like text editing controllers)
  TextEditingController serviceDescriptionForInvoice = TextEditingController(); //
  TextEditingController durationForInvoice = TextEditingController(); //(not in use)
  TextEditingController rateForInvoice = TextEditingController(); //valid
  TextEditingController selectedMeetingTypeForInvoice = TextEditingController(); //valid
  TextEditingController discountForInvoice = TextEditingController(); //valid
  TextEditingController convertedToLocalCurrencyDiscountForInvoice = TextEditingController(); //valid
  TextEditingController subtotalForInvoice = TextEditingController(); //valid
  


  Future<void> calculateDiscountForInvoice({required int index, required BuildContext context, required String initialRateValue, required String initialDiscountValue}) async{
    // Convert parameters from string to double data type
    double discountValue = double.tryParse(discountForInvoice.text.isNotEmpty ? discountForInvoice.text : initialDiscountValue) ?? 0;
    double rateValue = double.tryParse(rateForInvoice.text.isNotEmpty ? rateForInvoice.text : initialRateValue) ?? 0;

    // Calculate the discount
    double calculatedDiscount = (discountValue / 100) * rateValue;

    // Calculate the new total after the discount has been subtracted from it
    double newSubtotal = rateValue - calculatedDiscount;

    debugPrint("Calculated Discount: $calculatedDiscount");
    debugPrint("New Subtotal: $newSubtotal");
  
    convertedToLocalCurrencyDiscountForInvoice.text = calculatedDiscount.toString();
    subtotalForInvoice.text = newSubtotal.toString();
    
    //updated from here
    final indexed_subtotal = <String, dynamic>{"discounted_total": newSubtotal.toString(),};
    selectedInvoicebslist[index].addEntries(indexed_subtotal.entries);
    print("updated list with total updated: $selectedInvoicebslist");
  
    //success snackbar
    showMySnackBar(
      context: context,
      backgroundColor: AppColor.darkGreen,
      message: "your discounted total is N$newSubtotal"
    );
    ///
    update();
  }

  //4
  Future<void> editProductForInvoiceCreation({
    required BuildContext context,
    required String service_name,
    required String service_description,
    required String service_id,
    required String discount,
    required String rate,
    required String total, 
    required String duration,
    required String appointmentType,
    required int index,

    //invoice gets converted to bookings according to somto
    //these below corresponds to bookings
    required String phone_number,  //put client phone number
  }) async{

    isLoading.value = true;
    //Find the index of the item you want to modify
    if (index != -1) {

      isLoading.value = false;

      // Modify the values of the found item in the originally selected list
      selectedInvoicebslist[index]["description"] = service_description;
      selectedInvoicebslist[index]["duration"] = duration;
      selectedInvoicebslist[index]["discount"] = discount;
      selectedInvoicebslist[index]["total"] = total;
      selectedInvoicebslist[index]["appointment_type"] = appointmentType;
      selectedInvoicebslist[index]["rate"] = rate;
      selectedInvoicebslist[index]["serviceID"] = service_id;
      //invoice gets converted to bookings according to somto
      //these below corresponds to bookings
      selectedInvoicebslist[index]["message"] = "(non)";
      selectedInvoicebslist[index]["location"] = "location depends on this :$appointmentType";
      selectedInvoicebslist[index]["phone_number"] = phone_number;
      


      //success snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.darkGreen,
        message: "item edited and saved successfully"
      ).whenComplete(() => getx.Get.back());
    } 
    else {
      isLoading.value = false;
      debugPrint("Item not found in the list.");
    }
    update();
  }

  //5
  ///[CREATE NEW QUOTE AND SAVE IT TO DB]//
  Future<void> createNewInvoiceAndSaveToDB({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String note,
    required String invoice_date,
    required String due_date
    }) async {

    isLoading.value = true;

    var body = {
      "send_to": client_name,
      "send_to_email": client_email,
      "phone_number": client_phone_number,
      "note": note,
      "notes": note,
      "due_date": due_date,
      "vat": reactiveTotalVATForInvoice.value,
      "sub_total": reactiveSubtotalForInvoice.value,
      "discount": "-N${reactiveTotalDiscountForInvoice.value}",
      "total": reactiveTotalForInvoice.value,
      "booking_detail": selectedInvoicebslist
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "invoice/generate-invoice", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("invoice created and saved successfully to database");
        finController.invoiceClientNameController.clear();
        finController.invoiceClientEmailController.clear();
        finController.invoiceClientPhoneNumberController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "invoice created and saved successfully"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to save invoice ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
    update();
  } 

  ///[CREATE NEW QUOTE AND SEND IT TO CLIENT]//
  Future<void> createNewInvoiceAndSendToClient({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String note,
    required String invoice_date,
    required String due_date
    }) async {

    isLoading.value = true;

    var body = {
      "send_to": client_name,
      "send_to_email": client_email,
      "phone_number": client_phone_number,
      "note": note,
      "notes": note,
      "due_date": due_date,
      "vat": reactiveTotalVATForInvoice.value,
      "sub_total": reactiveSubtotalForInvoice.value,
      "discount": "-N${reactiveTotalDiscountForInvoice.value}",
      "total": reactiveTotalForInvoice.value,
      "booking_detail": selectedInvoicebslist
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "invoice/generate-invoice", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("invoice created and saved successfully to database");
        finController.invoiceClientNameController.clear();
        finController.invoiceClientEmailController.clear();
        finController.invoiceClientPhoneNumberController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "invoice created and saved successfully"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to save invoice ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }

  ///[DELETE INVOICE FROM DB]//
  Future<void> deleteInvoiceFromDB({
    required BuildContext context,
    required String invoice_id,
    }) async {

    isLoading.value = true;

    var body = {};

    try {
      http.Response res = await baseService.httpDelete(endPoint: "invoice/delete-invoice?invoice_id=$invoice_id", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("invoice deleted by id successfully from database");

        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "invoice deleted successfully"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to delete invoice ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }





  ///////////////////////////////////////////////////////////////////////////////
  
  ////FOR RECEIPT/////
  var receiptbslist = <Map<String, dynamic>>[].obs;
  var filteredReceiptbslist = <Map<String, dynamic>>[].obs;
  var selectedReceiptbslist = <Map<String, dynamic>>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR RECEIPT]///
  Future<List<Map<String, dynamic>>> loadServicesDataForReceipt() async {
    try {
      isLoading.value = true;

      final List<UserServiceModel> products = await getUserServices();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));
      isLoading.value = false;
      //filteredList.value = List.from(products);
      //Populate the receipt list using map
      receiptbslist.value = products.map((userModel) => userModel.toJson()).toList();

      // Print the modified list
      print("Receiptbslist: $receiptbslist");
      return receiptbslist;
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }


  //working well
  Future<void> filterProductsForReceipt(String query) async {
    if (query.isEmpty) {
      filteredReceiptbslist.clear();
      filteredReceiptbslist.addAll(receiptbslist);
      print("when query is empty: $filteredReceiptbslist");
    } 
    else {
      filteredReceiptbslist.clear(); // Clear the previous filtered list
      // Use .addAll() to add the filtered items to the list
      filteredReceiptbslist.addAll(receiptbslist
        .where((user) => user['service_name'].toString().toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredReceiptbslist");
    }
    update();
  }
  


  ///[CREATE RECEIPT SCREEN]
  ///////////////////
  var reactiveTotalForReceipt = "".obs;
  var reactiveSubtotalForReceipt = "".obs;
  var reactiveTotalDiscountForReceipt = "".obs;
  var reactiveTotalVATForReceipt = "".obs;
  
  void showEverythingForReceiptList() {
    double subtotalPrice = 0;
    double totalPrice = 0;
    double totalDiscount = 0;
    double totalVat = 0;

    for (var product in selectedReceiptbslist) {
      subtotalPrice += double.parse(product['rate']);
      totalPrice += double.parse(product['total']);
      totalDiscount += double.parse(product['discount']);
      totalVat += double.parse(product['total']) * 0.075;
    }
    ///////////////////
    reactiveTotalForReceipt.value = (totalPrice + totalVat).toString();
    reactiveSubtotalForReceipt.value = subtotalPrice.toString();
    reactiveTotalDiscountForReceipt.value = totalDiscount.toString();
    reactiveTotalVATForReceipt.value = totalVat.toString();
  }


  /////////////////
  //1
  Future<void> deleteSelectedProductForReceipt(int index) async{
    isLoading.value = true;
    if (selectedReceiptbslist.isNotEmpty) {
      isLoading.value = false;
      selectedReceiptbslist.removeAt(index);
      print("list: $selectedReceiptbslist");
      //clear the figures
    } else {
      isLoading.value = false;
      debugPrint("the item has already been removed at the index");
    }
  }

  //2(these act like text editing controllers)
  TextEditingController serviceDescriptionForReceipt = TextEditingController(); //
  TextEditingController durationForReceipt = TextEditingController(); //(not in use)
  TextEditingController rateForReceipt = TextEditingController(); //valid
  TextEditingController selectedMeetingTypeForReceipt = TextEditingController(); //valid
  TextEditingController discountForReceipt = TextEditingController(); //valid
  TextEditingController convertedToLocalCurrencyDiscountForReceipt = TextEditingController(); //valid
  TextEditingController subtotalForReceipt = TextEditingController(); //valid
  


  Future<void> calculateDiscountForReceipt({required int index, required BuildContext context, required String initialRateValue, required String initialDiscountValue}) async {
    // Convert parameters from string to double data type
    double discountValue = double.tryParse(discountForReceipt.text.isNotEmpty ? discountForReceipt.text : initialDiscountValue) ?? 0;
    double rateValue = double.tryParse(rateForReceipt.text.isNotEmpty ? rateForReceipt.text : initialRateValue) ?? 0;

    // Calculate the discount
    double calculatedDiscount = (discountValue / 100) * rateValue;

    // Calculate the new total after the discount has been subtracted from it
    double newSubtotal = rateValue - calculatedDiscount;

    debugPrint("Calculated Discount: $calculatedDiscount");
    debugPrint("New Subtotal: $newSubtotal");
  
    convertedToLocalCurrencyDiscountForReceipt.text = calculatedDiscount.toString();
    subtotalForReceipt.text = newSubtotal.toString();
    
    //updated from here
    final indexed_subtotal = <String, dynamic>{"discounted_total": newSubtotal.toString(),};
    selectedReceiptbslist[index].addEntries(indexed_subtotal.entries);
    print("updated list with total updated: $selectedReceiptbslist");
  
    //success snackbar
    showMySnackBar(
      context: context,
      backgroundColor: AppColor.darkGreen,
      message: "your discounted total is N${subtotalForReceipt.text}"
    );
    //
  }

  //4
  Future<void> editProductForReceiptCreation({
    required BuildContext context,
    required String service_id,
    required String discount,
    required String rate,
    required String total, 
    required String duration,
    required String appointmentType,
    required int index,
  }) async{

    isLoading.value = true;
    //Find the index of the item you want to modify
    if (index != -1) {

      isLoading.value = false;

      // Modify the values of the found item in the originally selected list
      selectedReceiptbslist[index]["duration"] = duration;
      selectedReceiptbslist[index]["discount"] = discount;
      selectedReceiptbslist[index]["total"] = total;
      selectedReceiptbslist[index]["appointment_type"] = appointmentType;
      selectedReceiptbslist[index]["rate"] = rate;
      
    
      //success snackbar
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.darkGreen,
        message: "item edited and saved successfully"
      ).whenComplete(() => getx.Get.back());
    } 
    else {
      isLoading.value = false;
      debugPrint("Item not found in the list.");
    }
  
  }

  //5
  ///[CREATE NEW RECEIPT AND SEND TO CLIENT]//
  Future<void> createNewReceiptAndSendToClient({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String note,
    required String receipt_date,
    required String mode_of_payment
    }) async {

    isLoading.value = true;

    var body = {
      "receipt_date": receipt_date,
      ////////////////
      "send_to": client_name,
      "send_to_email": client_email,
      "phone_number": client_phone_number,
      "payment_status": "SENT",
      "mode_of_payment": mode_of_payment,
      "note": note,
      "vat": reactiveTotalVATForReceipt.value,
      "sub_total": reactiveSubtotalForReceipt.value,
      "discount": "-N${reactiveTotalDiscountForReceipt.value}",
      "total": reactiveTotalForReceipt.value,
      "service_detail": selectedReceiptbslist
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "receipt/generate-receipt", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("receipt created and saved successfully to database");
        finController.receiptClientNameController.clear();
        finController.receiptClientEmailController.clear();
        finController.receiptClientPhoneNumberController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "receipt created and saved successfully"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to save receipt ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
    update();
  }

  //5
  ///[CREATE NEW RECEIPT AND SAVE IT TO DB]//
  Future<void> createNewReceiptAndSaveToDB({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String note,
    required String receipt_date,
    required String mode_of_payment
    }) async {

    isLoading.value = true;

    var body = {
      "receipt_date": receipt_date,
      ////////////////
      "send_to": client_name,
      "send_to_email": client_email,
      "phone_number": client_phone_number,
      "payment_status": "DRAFT",
      "mode_of_payment": mode_of_payment,
      "note": note,
      "vat": reactiveTotalVATForReceipt.value,
      "sub_total": reactiveSubtotalForReceipt.value,
      "discount": "-N${reactiveTotalDiscountForReceipt.value}",
      "total": reactiveTotalForReceipt.value,
      "service_detail": selectedReceiptbslist
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "receipt/save-receipt", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("receipt created and saved successfully to database");
        finController.receiptClientNameController.clear();
        finController.receiptClientEmailController.clear();
        finController.receiptClientPhoneNumberController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "receipt created and saved successfully"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to save receipt ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
    update();
  }






  ///[DELETE RECEIPT FROM DB]//
  Future<void> deleteReceiptFromDB({
    required BuildContext context,
    required String receipt_id,
    }) async {

    isLoading.value = true;

    var body = {};

    try {
      http.Response res = await baseService.httpDelete(endPoint: "receipt/delete-receipt?receiptId=$receipt_id", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        //debugPrint('this is response body ==> ${res.body}');
        debugPrint("receipt deleted by id successfully from database");

        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "receipt deleted successfully"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to delete receipt ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
    update();
  }














  @override
  void onInit() {
    super.onInit();

    ///just trying to test this on init func////
    getUserServices().then((List<UserServiceModel> list) {
      print("list of user services: $list");
    });
    
  }

}