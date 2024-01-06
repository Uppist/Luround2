import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
//import 'package:luround/utils/colors/app_theme.dart';
//import 'package:luround/utils/components/my_snackbar.dart';










class InvoicesService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();


  /////[GET LOGGED-IN USER'S LIST OF PAID INVOICES]//////
  var paidInvoiceList = <dynamic>[].obs;
  var filteredPaidInvoiceList = <dynamic>[].obs;

  Future<void> filterPaidInvoice(String query) async {
    if (query.isEmpty) {
      filteredPaidInvoiceList.clear();
      filteredPaidInvoiceList.addAll(paidInvoiceList);
      print("when query is empty: $filteredPaidInvoiceList");
    } 
    else {
      // Clear the previous filtered list
      filteredPaidInvoiceList.clear();
      // Use addAll to add the filtered items to the list
      filteredPaidInvoiceList.addAll(
      paidInvoiceList.where((e) =>
          e.customer_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredPaidInvoiceList");
    }
  }

  Future<List<dynamic>> getUserPaidInvoice() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "invoice/paid-invoices",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user paid invoice list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          //final List<PaidInvoiceResponseModel> finalResult = response.map((e) => PaidInvoiceResponseModel.fromJson(e)).toList();

          paidInvoiceList.clear();
          paidInvoiceList.addAll(response);  //finalResult
          debugPrint("paid invoice list: $paidInvoiceList");

          //Return the list of sent quotes
          return paidInvoiceList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user paid invoice list');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF PAID INVOICES IN THE FUTURE BUILDER FOR PAID INVOICES]///
  Future<List<dynamic>> loadPaidInvoicesData() async {
    try {
      isLoading.value = true;
      final List<dynamic> invoices = await getUserPaidInvoice();
      invoices.sort((a, b) => a.customer_name.toLowerCase().compareTo(b.customer_name.toLowerCase()));

      isLoading.value = false;
      filteredPaidInvoiceList.value = List.from(invoices); 
      print("initState: ${filteredPaidInvoiceList}");
      return filteredPaidInvoiceList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }


  

  /////[GET LOGGED-IN USER'S LIST OF UNPAID INVOICES]//////
  var unpaidInvoiceList = <dynamic>[].obs;
  var filteredUnpaidInvoiceList = <dynamic>[].obs;

  Future<void> filterUnpaidInvoice(String query) async {
    if (query.isEmpty) {
      filteredUnpaidInvoiceList.clear();
      filteredUnpaidInvoiceList.addAll(unpaidInvoiceList);
      print("when query is empty: $filteredUnpaidInvoiceList");
    } 
    else {
      // Clear the previous filtered list
      filteredUnpaidInvoiceList.clear();
      // Use addAll to add the filtered items to the list
      filteredUnpaidInvoiceList.addAll(
      unpaidInvoiceList.where((e) =>
          e.customer_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredUnpaidInvoiceList");
    }
  }

  Future<List<dynamic>> getUserUnpaidInvoice() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "invoice/unpaid-invoices",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user unpaid invoice list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          //final List<UnpaidInvoiceResponseModel> finalResult = response.map((e) => PaidInvoiceResponseModel.fromJson(e)).toList();

          unpaidInvoiceList.clear();
          unpaidInvoiceList.addAll(response);  //finalResult
          debugPrint("unpaid invoice list: $unpaidInvoiceList");

          //Return the list of unpaid invoices
          return unpaidInvoiceList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user unpaid invoices');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF UNPAID INVOICES IN THE FUTURE BUILDER FOR UNPAID INVOICES]///
  Future<List<dynamic>> loadUnpaidInvoicesData() async {
    try {
      isLoading.value = true;
      final List<dynamic> invoices = await getUserUnpaidInvoice();
      invoices.sort((a, b) => a.customer_name.toLowerCase().compareTo(b.customer_name.toLowerCase()));

      isLoading.value = false;
      filteredUnpaidInvoiceList.value = List.from(invoices); 
      print("initState: ${filteredUnpaidInvoiceList}");
      return filteredUnpaidInvoiceList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }




  /////[GET LOGGED-IN USER'S LIST OF DUE INVOICES]//////
  var dueInvoiceList = <dynamic>[].obs;
  var filteredDueInvoiceList = <dynamic>[].obs;

  Future<void> filterDueInvoice(String query) async {
    if (query.isEmpty) {
      filteredDueInvoiceList.clear();
      filteredDueInvoiceList.addAll(dueInvoiceList);
      print("when query is empty: $filteredDueInvoiceList");
    } 
    else {
      // Clear the previous filtered list
      filteredDueInvoiceList.clear();
      // Use addAll to add the filtered items to the list
      filteredDueInvoiceList.addAll(
      dueInvoiceList.where((e) =>
          e.customer_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredDueInvoiceList");
    }
  }

  Future<List<dynamic>> getUserDueInvoice() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "invoice/due-invoices",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user due invoice list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          //final List<DueInvoiceResponseModel> finalResult = response.map((e) => DueInvoiceResponseModel.fromJson(e)).toList();

          dueInvoiceList.clear();
          dueInvoiceList.addAll(response);  //finalResult
          debugPrint("due invoice list: $dueInvoiceList");

          //Return the list of due invoices
          return dueInvoiceList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user due invoices');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF DUE INVOICES IN THE FUTURE BUILDER FOR due INVOICES]///
  Future<List<dynamic>> loadDueInvoicesData() async {
    try {
      isLoading.value = true;
      final List<dynamic> invoices = await getUserDueInvoice();
      invoices.sort((a, b) => a.customer_name.toLowerCase().compareTo(b.customer_name.toLowerCase()));

      isLoading.value = false;
      filteredDueInvoiceList.value = List.from(invoices); 
      print("initState: ${filteredDueInvoiceList}");
      return filteredDueInvoiceList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }









  @override
  void onInit() {
    // TODO: implement onInit
    loadPaidInvoicesData().then(
      (value) => print("Paid Invoices Loaded into the Widget Tree: $value")
    );
    loadUnpaidInvoicesData().then(
      (value) => print("Unpaid Invoices Loaded into the Widget Tree: $value")
    );
    loadDueInvoicesData().then(
      (value) => print("Due Invoices Loaded into the Widget Tree: $value")
    );
    super.onInit();
  }

}