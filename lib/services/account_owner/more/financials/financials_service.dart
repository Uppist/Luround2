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



  ////FOR QUOTES/////
  var dataList = <UserServiceModel>[].obs;
  var filteredList = <UserServiceModel>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR QUOTES]///
  Future<List<UserServiceModel>> loadServicesData() async {
    try {
      isLoading.value = true;
      //await getUserServices();
      final List<UserServiceModel> products = await getUserServices();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));

      isLoading.value = false;
      filteredList.value = List.from(products);  
      return filteredList;

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
      filteredList.clear();
      filteredList.addAll(dataList);
      print("when query is empty: $filteredList");
    } 
    else {
      filteredList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredList.addAll(dataList
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredList");
    }
    update();
  }
  

  ///[CREATE QUOTES SCREEN] ////THIS
  getx.RxList<UserServiceModel> selectedProducts = <UserServiceModel>[].obs;
  getx.RxList<Map<String, dynamic>> editedSelectedProuctMapList = <Map<String, dynamic>>[].obs;
  


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

    for (var product in editedSelectedProuctMapList) {
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
    if (editedSelectedProuctMapList.isNotEmpty) {
      isLoading.value = false;
      editedSelectedProuctMapList.removeAt(index);
      print("list: $editedSelectedProuctMapList");
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



  Future<void> calculateDiscount({required int index, required BuildContext context, required String initialRateValue}) async {

    // Convert parameters from string to double data type
    double discountValue = double.tryParse(discountForQuote.value) ?? 0;
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
    editedSelectedProuctMapList[index].addEntries(indexed_subtotal.entries);
    print("updated list with total updated: $editedSelectedProuctMapList");
  
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
      editedSelectedProuctMapList[index]["description"] = service_description;
      editedSelectedProuctMapList[index]["duration"] = duration;
      editedSelectedProuctMapList[index]["discount"] = discount;
      editedSelectedProuctMapList[index]["total"] = total;
      editedSelectedProuctMapList[index]["meeting_type"] = meetingType;
      editedSelectedProuctMapList[index]["rate"] = rate;

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
          message: "failed to delete quote"
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
      "product_detail": editedSelectedProuctMapList
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
          message: "failed to save quote"
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
      "product_detail": editedSelectedProuctMapList
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
          message: "failed to save quote"
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
        debugPrint("dataList/productList: $dataList");

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
  var dataListForInvoice = <UserServiceModel>[].obs;
  var filteredListForInvoice = <UserServiceModel>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR QUOTES]///
  Future<List<UserServiceModel>> loadServicesDataForInvoice() async {
    try {
      isLoading.value = true;
      final List<UserServiceModel> products = await getUserServicesForInvoice();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));

      isLoading.value = false;
      filteredListForInvoice.value = List.from(products);  
      print("initialized List ForInvoice: ${filteredListForInvoice}");
      update();
      return filteredListForInvoice;

    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      //print("Error loading data: $error");
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  //working well
  Future<void> filterProductsForInvoice(String query) async {
    if (query.isEmpty) {
      filteredListForInvoice.clear();
      filteredListForInvoice.addAll(dataListForInvoice);
      print("when query is empty: $filteredListForInvoice");
    } 
    else {
      filteredListForInvoice.clear(); // Clear the previous filtered list
      // Use .addAll() to add the filtered items to the list
      filteredListForInvoice.addAll(dataListForInvoice
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredListForInvoice");
      update();
    }
  }
  

  ///[CREATE INVOICE SCREEN]
  getx.RxList<UserServiceModel> selectedProductsForInvoice = <UserServiceModel>[].obs;
  getx.RxList<Map<String, dynamic>> editedSelectedProuctMapListForInvoice = <Map<String, dynamic>>[].obs;
  

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

    for (var product in editedSelectedProuctMapListForInvoice) {
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
    if (editedSelectedProuctMapListForInvoice.isNotEmpty) {
      isLoading.value = false;
      editedSelectedProuctMapListForInvoice.removeAt(index);
      print("list: $editedSelectedProuctMapListForInvoice");
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
  


  Future<void> calculateDiscountForInvoice({required int index, required BuildContext context, required String initialRateValue}) async{
    // Convert parameters from string to double data type
    double discountValue = double.tryParse(discountForInvoice.text) ?? 0;
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
    editedSelectedProuctMapListForInvoice[index].addEntries(indexed_subtotal.entries);
    print("updated list with total updated: $editedSelectedProuctMapListForInvoice");
  
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
      editedSelectedProuctMapListForInvoice[index]["description"] = service_description;
      editedSelectedProuctMapListForInvoice[index]["duration"] = duration;
      editedSelectedProuctMapListForInvoice[index]["discount"] = discount;
      editedSelectedProuctMapListForInvoice[index]["total"] = total;
      editedSelectedProuctMapListForInvoice[index]["appointment_type"] = appointmentType;
      editedSelectedProuctMapListForInvoice[index]["rate"] = rate;
      editedSelectedProuctMapListForInvoice[index]["serviceID"] = service_id;
      //invoice gets converted to bookings according to somto
      //these below corresponds to bookings
      //editedSelectedProuctMapListForInvoice[index]["time"] = "";
      //editedSelectedProuctMapListForInvoice[index]["date"] = "";
      editedSelectedProuctMapListForInvoice[index]["message"] = "(non)";
      editedSelectedProuctMapListForInvoice[index]["location"] = "location depends on this :$appointmentType";
      editedSelectedProuctMapListForInvoice[index]["phone_number"] = phone_number;
      
      //showEverythingForInvoiceList();


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
      "booking_detail": editedSelectedProuctMapListForInvoice //product_detail
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
          message: "failed to save invoice"
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
      "booking_detail": editedSelectedProuctMapListForInvoice //product_detail
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
          message: "failed to save invoice"
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
          message: "failed to delete invoice"
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
  Future<List<UserServiceModel>> getUserServicesForInvoice() async {
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

        dataListForInvoice.clear();
        dataListForInvoice.addAll(finalResult);
        debugPrint("dataList/productList for invoice: $dataListForInvoice");

        // Return the user services list
        update();
        return dataListForInvoice;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        update();
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  










  ////FOR RECEIPT/////
  var dataListForReceipt = <UserServiceModel>[].obs;
  var filteredListForReceipt = <UserServiceModel>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
  ///[TO LAZY LOAD THE USER LIST OF SERVICES IN THE FUTURE BUILDER FOR QUOTES]///
  Future<List<UserServiceModel>> loadServicesDataForReceipt() async {
    try {
      isLoading.value = true;
      final List<UserServiceModel> products = await getUserServicesForReceipt();
      products.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));

      isLoading.value = false;
      filteredListForReceipt.value = List.from(products);  
      print("initialized List For Receipt: ${filteredListForReceipt}");
      update();
      return filteredListForReceipt;

    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      //print("Error loading data: $error");
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  //working well
  Future<void> filterProductsForReceipt(String query) async {
    if (query.isEmpty) {
      filteredListForReceipt.clear();
      filteredListForReceipt.addAll(dataListForReceipt);
      print("when query is empty: $filteredListForReceipt");
    } 
    else {
      filteredListForReceipt.clear(); // Clear the previous filtered list
      // Use .addAll() to add the filtered items to the list
      filteredListForReceipt.addAll(dataListForReceipt
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query
        .toList());

      print("when query is not empty: $filteredListForReceipt");
    }
    update();
  }
  

  ///[CREATE RECEIPT SCREEN]
  getx.RxList<UserServiceModel> selectedProductsForReceipt = <UserServiceModel>[].obs;
  getx.RxList<Map<String, dynamic>> editedSelectedProuctMapListForReceipt = <Map<String, dynamic>>[].obs;

  
  
  void showEverythingForReceiptList() {
    double subtotalPrice = 0;
    double totalPrice = 0;
    double totalDiscount = 0;
    double totalVat = 0;

    for (var product in editedSelectedProuctMapListForReceipt) {
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





  ///////////////////
  var reactiveTotalForReceipt = "".obs;
  var reactiveSubtotalForReceipt = "".obs;
  var reactiveTotalDiscountForReceipt = "".obs;
  var reactiveTotalVATForReceipt = "".obs;

  /////////////////
  //1
  Future<void> deleteSelectedProductForReceipt(int index) async{
    isLoading.value = true;
    if (editedSelectedProuctMapListForReceipt.isNotEmpty) {
      isLoading.value = false;
      editedSelectedProuctMapListForReceipt.removeAt(index);
      print("list: $editedSelectedProuctMapListForReceipt");
      //clear the figures
    } else {
      isLoading.value = false;
      debugPrint("the item has already been removed at the index");
    }
    update();
  }

  //2(these act like text editing controllers)
  TextEditingController serviceDescriptionForReceipt = TextEditingController(); //
  TextEditingController durationForReceipt = TextEditingController(); //(not in use)
  TextEditingController rateForReceipt = TextEditingController(); //valid
  TextEditingController selectedMeetingTypeForReceipt = TextEditingController(); //valid
  TextEditingController discountForReceipt = TextEditingController(); //valid
  TextEditingController convertedToLocalCurrencyDiscountForReceipt = TextEditingController(); //valid
  TextEditingController subtotalForReceipt = TextEditingController(); //valid
  


  Future<void> calculateDiscountForReceipt({required int index, required BuildContext context, required String initialRateValue}) async {
    // Convert parameters from string to double data type
    double discountValue = double.tryParse(discountForReceipt.text) ?? 0;
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
    editedSelectedProuctMapListForReceipt[index].addEntries(indexed_subtotal.entries);
    print("updated list with total updated: $editedSelectedProuctMapListForReceipt");
  
    //success snackbar
    showMySnackBar(
      context: context,
      backgroundColor: AppColor.darkGreen,
      message: "your discounted total is N${subtotalForReceipt.text}"
    );
    ///
    update();
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
      editedSelectedProuctMapListForReceipt[index]["duration"] = duration;
      editedSelectedProuctMapListForReceipt[index]["discount"] = discount;
      editedSelectedProuctMapListForReceipt[index]["total"] = total;
      editedSelectedProuctMapListForReceipt[index]["appointment_type"] = appointmentType;
      editedSelectedProuctMapListForReceipt[index]["rate"] = rate;
      
    
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
      "service_detail": editedSelectedProuctMapListForReceipt //product_detail
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
          message: "failed to save receipt"
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
      "service_detail": editedSelectedProuctMapListForReceipt //product_detail
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
          message: "failed to save receipt"
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
          message: "failed to delete receipt"
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
  Future<List<UserServiceModel>> getUserServicesForReceipt() async {
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

        dataListForReceipt.clear();
        dataListForReceipt.addAll(finalResult);
        debugPrint("dataList/productList for receipt: $dataListForReceipt");

        // Return the user services list
        update();
        return dataListForReceipt;
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











  @override
  void onInit() {
    super.onInit();
    ///////////just trying to test this on init func
    //FOR QUOTES
    getUserServices().then((List<UserServiceModel> list) {
      filteredList.clear();
      filteredList.addAll(list);  //service.dataList
      print("initState FOR QUOTES: $filteredList");
      update();
    });
    
    //FOR INVOICE
    getUserServicesForInvoice().then((List<UserServiceModel> list) {
      filteredListForInvoice.clear();
      filteredListForInvoice.addAll(list);  //service.dataList
      print("initState FOR INVOICE: $filteredListForInvoice");
      update();
    });

    //FOR RECEIPT
    getUserServicesForReceipt().then((List<UserServiceModel> list) {
      filteredListForReceipt.clear();
      filteredListForReceipt.addAll(list);  //service.dataList
      print("initState FOR RECEIPT: $filteredListForReceipt");
      update();
    });
  }

}