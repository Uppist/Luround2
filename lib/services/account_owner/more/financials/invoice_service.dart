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


  /////[GET LOGGED-IN USER'S LIST OF SENT QUOTES]//////
  var sentQuotesList = <dynamic>[].obs;
  var filteredSentQuotesList = <dynamic>[].obs;

  Future<void> filterSentQuotes(String query) async {
    if (query.isEmpty) {
      filteredSentQuotesList.clear();
      filteredSentQuotesList.addAll(sentQuotesList);
      print("when query is empty: $filteredSentQuotesList");
    } 
    else {
      // Clear the previous filtered list
      filteredSentQuotesList.clear();
      // Use addAll to add the filtered items to the list
      filteredSentQuotesList.addAll(
      sentQuotesList.where((e) =>
          e.customer_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredSentQuotesList");
    }
  }

  Future<List<dynamic>> getUserSentQuotes() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "quotes/sent-quotes",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user sent quotes list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          //final List<SentQuotesResponseModel> finalResult = response.map((e) => SentQuotesResponseModel.fromJson(e)).toList();

          sentQuotesList.clear();
          sentQuotesList.addAll(response);  //finalResult
          debugPrint("sent quotes list: $sentQuotesList");

          //Return the list of sent quotes
          return sentQuotesList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user sent quotes');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF SENT QUOTES IN THE FUTURE BUILDER FOR SENT QUOTES]///
  Future<List<dynamic>> loadSentQuotesData() async {
    try {
      isLoading.value = true;
      final List<dynamic> quotes = await getUserSentQuotes();
      quotes.sort((a, b) => a.customer_name.toLowerCase().compareTo(b.customer_name.toLowerCase()));

      isLoading.value = false;
      filteredSentQuotesList.value = List.from(quotes); 
      print("initState: ${filteredSentQuotesList}");
      return filteredSentQuotesList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }




  /////[GET LOGGED-IN USER'S LIST OF RECEIVED QUOTES]//////
  var receivedQuotesList = <dynamic>[].obs;
  var filteredReceivedQuotesList = <dynamic>[].obs;

  Future<void> filterReceivedQuotes(String query) async {
    if (query.isEmpty) {
      filteredReceivedQuotesList.clear();
      filteredReceivedQuotesList.addAll(receivedQuotesList);
      print("when query is empty: $filteredReceivedQuotesList");
    } 
    else {
      // Clear the previous filtered list
      filteredReceivedQuotesList.clear();
      // Use addAll to add the filtered items to the list
      filteredReceivedQuotesList.addAll(
      receivedQuotesList.where((e) =>
          e.customer_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredReceivedQuotesList");
    }
  }

  Future<List<dynamic>> getUserReceivedQuotes() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "quotes/received-quotes",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user received quotes list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          //final List<ReceivedQuotesResponseModel> finalResult = response.map((e) => ReceivedQuotesResponseModel.fromJson(e)).toList();

          receivedQuotesList.clear();
          receivedQuotesList.addAll(response);  //finalResult
          debugPrint("received quotes list: $receivedQuotesList");

          //Return the list of received quotes
          return receivedQuotesList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user received quotes');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF RECEIVED QUOTES IN THE FUTURE BUILDER FOR RECEIVED QUOTES]///
  Future<List<dynamic>> loadReceivedQuotesData() async {
    try {
      isLoading.value = true;
      final List<dynamic> quotes = await getUserReceivedQuotes();
      quotes.sort((a, b) => a.customer_name.toLowerCase().compareTo(b.customer_name.toLowerCase()));

      isLoading.value = false;
      filteredReceivedQuotesList.value = List.from(quotes); 
      print("initState: ${filteredReceivedQuotesList}");
      return filteredReceivedQuotesList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }




  @override
  void onInit() {
    // TODO: implement onInit
    loadSentQuotesData().then(
      (value) => print("Sent Quotes Loaded into the Widget Tree: $value")
    );
    loadReceivedQuotesData().then(
      (value) => print("Received Quotes Loaded into the Widget Tree: $value")
    );
    super.onInit();
  }

}