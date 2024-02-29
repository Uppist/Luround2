import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/more/financials/quotes/drafted_quotes_response_model.dart';
import 'package:luround/models/account_owner/more/financials/quotes/received_quotes_response.dart';
import 'package:luround/models/account_owner/more/financials/quotes/sent_quotes_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;










class QuotesService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
  var token = LocalStorage.getToken();


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
  

  IO.Socket? socket;
  Stream<List<SentQuotesResponse>>  getUserSentQuotes() async* {
    try {

      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-bookings" event after connecting
        socket!.emit('user-sent-quotes');
      });

      socket!.on('user-sent-quotes', (data) {
        // Extract the "details" list from the first map
        //print("qqqq $data");
        List<dynamic> response = data; //json.decode(data);
        var finalResult = response.map((e) => SentQuotesResponse.fromJson(e)).toList();
        sentQuotesList.clear();
        sentQuotesList.addAll(finalResult);  //finalResult
        print("user sent quotess list: $sentQuotesList");
      });



      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield sentQuotesList;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
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

  Stream<List<ReceivedQuotesResponse>>  getUserReceivedQuotes() async* {
    try {

      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-bookings" event after connecting
        socket!.emit('user-received-quotes');
      });

      socket!.on('user-received-quotes', (data) {
        List<dynamic> response = data; //json.decode(data);
        var finalResult = response.map((e) => ReceivedQuotesResponse.fromJson(e)).toList();
        receivedQuotesList.clear();
        receivedQuotesList.addAll(finalResult); 
        debugPrint("received quotes list: $receivedQuotesList");
      });


      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield receivedQuotesList;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
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
  
  
  Stream<List<DraftedQuotesResponse>>  getUserDraftedQuotes() async* {
    try {

      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-saved-quotes" event after connecting
        socket!.emit('user-saved-quotes');
      });

      socket!.on('user-saved-quotes', (data) {
        List<dynamic> response = data; //json.decode(data);
        var finalResult = response.map((e) => DraftedQuotesResponse.fromJson(e)).toList();
        draftedQuotesList.clear();
        draftedQuotesList.addAll(finalResult);  //finalResult
        debugPrint("drafted quotes list: $draftedQuotesList");

      });


      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield draftedQuotesList;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
    }

  }






  @override
  void dispose() {
    // TODO: implement dispose
    //socket!.dispose();
    super.dispose();
  }


  @override
  void onInit() {
    super.onInit();
  }

}