import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/more/financials/receipt/receipt_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
//import 'package:luround/utils/colors/app_theme.dart';
//import 'package:luround/utils/components/my_snackbar.dart';










class ReceiptsService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();


  /////[GET LOGGED-IN USER'S LIST OF SENT RECEIPTS]//////
  var sentReceiptsList = <ReceiptResponse>[].obs;
  var filteredSentReceiptList = <ReceiptResponse>[].obs;

  Future<void> filterSentReceipt(String query) async {
    if (query.isEmpty) {
      filteredSentReceiptList.clear();
      filteredSentReceiptList.addAll(sentReceiptsList);
      print("when query is empty: $filteredSentReceiptList");
    } 
    else {
      // Clear the previous filtered list
      filteredSentReceiptList.clear();
      // Use addAll to add the filtered items to the list
      filteredSentReceiptList.addAll(
      sentReceiptsList.where((e) =>
          e.send_to_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredSentReceiptList");
    }
  }

  Future<List<ReceiptResponse>> getUserSentReceipt() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "receipt/receipts",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user sent receipts list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          final List<ReceiptResponse> finalResult = response.map((e) => ReceiptResponse.fromJson(e)).toList();

          sentReceiptsList.clear();
          sentReceiptsList.addAll(finalResult);  //finalResult
          debugPrint("sent receipts list: $sentReceiptsList");

          //Return the list of sent receipts
          return sentReceiptsList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user sent receipt list');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF SENT RECEIPTS IN THE FUTURE BUILDER FOR SENT RECEIPTS]///
  Future<List<ReceiptResponse>> loadSentReceiptsData() async {
    try {
      isLoading.value = true;
      final List<ReceiptResponse> receipts = await getUserSentReceipt();
      receipts.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_email.toLowerCase()));

      isLoading.value = false;
      filteredSentReceiptList.value = List.from(receipts); 
      print("initState: ${filteredSentReceiptList}");
      return filteredSentReceiptList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }


  

  /////[GET LOGGED-IN USER'S LIST OF DRAFTED RECEIPTS]//////
  var draftedReceiptList = <ReceiptResponse>[].obs;
  var filteredDraftedReceiptsList = <ReceiptResponse>[].obs;

  Future<void> filterDraftedReceipt(String query) async {
    if (query.isEmpty) {
      filteredDraftedReceiptsList.clear();
      filteredDraftedReceiptsList.addAll(draftedReceiptList);
      print("when query is empty: $filteredDraftedReceiptsList");
    } 
    else {
      // Clear the previous filtered list
      filteredDraftedReceiptsList.clear();
      // Use addAll to add the filtered items to the list
      filteredDraftedReceiptsList.addAll(
      draftedReceiptList.where((e) =>
          e.send_to_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredDraftedReceiptsList");
    }
  }

  Future<List<ReceiptResponse>> getUserDraftedReceipt() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "receipt/saved-receipts",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user drafted receipt list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          final List<ReceiptResponse> finalResult = response.map((e) => ReceiptResponse.fromJson(e)).toList();

          draftedReceiptList.clear();
          draftedReceiptList.addAll(finalResult);  //finalResult
          debugPrint("darfted receipt list: $draftedReceiptList");

          //Return the list of drafted receipts
          return draftedReceiptList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user drafted receipts');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF DRAFTED RECEIPTS IN THE FUTURE BUILDER FOR DRAFTED RECEIPT]///
  Future<List<ReceiptResponse>> loadDraftedReceiptsData() async {
    try {
      isLoading.value = true;
      final List<ReceiptResponse> receipts = await getUserDraftedReceipt();
      receipts.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));

      isLoading.value = false;
      filteredDraftedReceiptsList.value = List.from(receipts); 
      print("initState: ${filteredDraftedReceiptsList}");
      return filteredDraftedReceiptsList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }













  @override
  void onInit() {
    // TODO: implement onInit
    loadSentReceiptsData().then(
      (value) => print("Sent Receipts Loaded into the Widget Tree: $value")
    );
    loadDraftedReceiptsData().then(
      (value) => print("Drafted Receipts Loaded into the Widget Tree: $value")
    );
    
    super.onInit();
  }

}