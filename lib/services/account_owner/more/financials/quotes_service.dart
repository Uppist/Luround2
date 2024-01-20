import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/more/financials/quotes/drafted_quotes_response_model.dart';
import 'package:luround/models/account_owner/more/financials/quotes/received_quotes_response.dart';
import 'package:luround/models/account_owner/more/financials/quotes/sent_quotes_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
//import 'package:luround/utils/colors/app_theme.dart';
//import 'package:luround/utils/components/my_snackbar.dart';










class QuotesService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();


  /////[GET LOGGED-IN USER'S LIST OF SENT QUOTES]//////
  var sentQuotesList = <SentQuotesResponse>[].obs;
  var filteredSentQuotesList = <SentQuotesResponse>[].obs;

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
          e.send_to_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredSentQuotesList");
    }
  }
  

  //get sent quotes
  final StreamController<List<SentQuotesResponse>> streamController = StreamController<List<SentQuotesResponse>>();
  Future<List<SentQuotesResponse>> getUserSentQuotes() async {
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
          final List<SentQuotesResponse> finalResult = response.map((e) => SentQuotesResponse.fromJson(e)).toList();

          sentQuotesList.clear();
          sentQuotesList.addAll(finalResult);  //finalResult
          debugPrint("sent quotes list: $sentQuotesList");
          streamController.add(sentQuotesList); // Simulating a stream with a single event

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
  Future<List<SentQuotesResponse>> loadSentQuotesData() async {
    try {
      isLoading.value = true;
      final List<SentQuotesResponse> quotes = await getUserSentQuotes();
      quotes.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));

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
  var receivedQuotesList = <ReceivedQuotesResponse>[].obs;
  var filteredReceivedQuotesList = <ReceivedQuotesResponse>[].obs;

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
          e.send_to_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredReceivedQuotesList");
    }
  }

  Future<List<ReceivedQuotesResponse>> getUserReceivedQuotes() async {
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
          final List<ReceivedQuotesResponse> finalResult = response.map((e) => ReceivedQuotesResponse.fromJson(e)).toList();

          receivedQuotesList.clear();
          receivedQuotesList.addAll(finalResult);  //finalResult
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
  Future<List<ReceivedQuotesResponse>> loadReceivedQuotesData() async {
    try {
      isLoading.value = true;
      final List<ReceivedQuotesResponse> quotes = await getUserReceivedQuotes();
      quotes.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));

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



  /////[GET LOGGED-IN USER'S LIST OF DRAFTED QUOTES]//////
  var draftedQuotesList = <DraftedQuotesResponse>[].obs;
  var filteredDraftedQuotesList = <DraftedQuotesResponse>[].obs;

  Future<void> filterDraftedQuotes(String query) async {
    if (query.isEmpty) {
      filteredDraftedQuotesList.clear();
      filteredDraftedQuotesList.addAll(draftedQuotesList);
      print("when query is empty: $filteredDraftedQuotesList");
    } 
    else {
      // Clear the previous filtered list
      filteredDraftedQuotesList.clear();
      // Use addAll to add the filtered items to the list
      filteredDraftedQuotesList.addAll(
      draftedQuotesList.where((e) =>
          e.send_to_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredDraftedQuotesList");
    }
  }

  Future<List<DraftedQuotesResponse>> getUserDraftedQuotes() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "quotes/saved-quotes",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user drafted quotes list fetched successfully!!");

        //Decode the response body here
        //Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          final List<DraftedQuotesResponse> finalResult = response.map((e) => DraftedQuotesResponse.fromJson(e)).toList();

          draftedQuotesList.clear();
          draftedQuotesList.addAll(finalResult);  //finalResult
          debugPrint("drafted quotes list: $draftedQuotesList");

          //Return the list of received quotes
          return draftedQuotesList;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user drafted quotes');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");    
    }
  }


  ///[TO LAZY LOAD THE USER LIST OF DRAFTED QUOTES IN THE FUTURE BUILDER FOR DRAFTED QUOTES]///
  Future<List<DraftedQuotesResponse>> loadDraftedQuotesData() async {
    try {
      isLoading.value = true;
      final List<DraftedQuotesResponse> quotes = await getUserDraftedQuotes();
      quotes.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));

      isLoading.value = false;

      filteredDraftedQuotesList.value = List.from(quotes); 
      print("initState: ${filteredDraftedQuotesList}");
      return filteredDraftedQuotesList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      throw Exception("$error => $stackTrace");
    }
  }















  @override
   void dispose() {
    streamController.close();
    super.dispose();
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
    loadDraftedQuotesData().then(
      (value) => print("Drafted Quotes Loaded into the Widget Tree: $value")
    );

    super.onInit();
  }

}