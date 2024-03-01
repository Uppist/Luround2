import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/more/financials/receipt/receipt_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;






class ReceiptsService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
  var token = LocalStorage.getToken();


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

  /////[GET LIST OF SENT RECEIPTS]//////
  Future<List<ReceiptResponse>>  getUserSentReceipt() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "receipt/receipts",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user sent receipts fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        //debugPrint("$response");
        var finalResult = response.map((e) => ReceiptResponse.fromJson(e)).toList();
        sentReceiptsList.clear();
        sentReceiptsList.addAll(finalResult);
        debugPrint("sent receipts list: $sentReceiptsList");
        return sentReceiptsList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user sent receipts');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("error: $e");
    
    }
  }

  /*IO.Socket? socket;
  Stream<List<ReceiptResponse>> getUserSentReceipt() async* {
    try {

      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-receipts" event after connecting
        socket!.emit('user-receipts');
      });

      socket!.on('user-receipts', (data) {
        List<dynamic> response = data; //json.decode(data);
        var finalResult = response.map((e) => ReceiptResponse.fromJson(e)).toList();
        sentReceiptsList.clear();
        sentReceiptsList.addAll(finalResult);
        debugPrint("sent receipts list: $sentReceiptsList");

      });


      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield sentReceiptsList;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
    }

  }*/



  

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

  
  /////[GET LIST OF Saved RECEIPTS]//////
  Future<List<ReceiptResponse>> getUserDraftedReceipt() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "receipt/saved-receipts",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user saved receipts fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        //debugPrint("$response");
        var finalResult = response.map((e) => ReceiptResponse.fromJson(e)).toList();
        draftedReceiptList.clear();
        draftedReceiptList.addAll(finalResult);  //finalResult
        debugPrint("darfted receipt list: $draftedReceiptList");
        return draftedReceiptList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user saved receipts');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("error: $e");
    
    }
  }


  /*Stream<List<ReceiptResponse>> getUserDraftedReceipt() async* {
    try {

      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-saved-receipts" event after connecting
        socket!.emit('user-saved-receipts');
      });

      socket!.on('user-saved-receipts', (data) {
        List<dynamic> response = data; //json.decode(data);
        var finalResult = response.map((e) => ReceiptResponse.fromJson(e)).toList();
        draftedReceiptList.clear();
        draftedReceiptList.addAll(finalResult);  //finalResult
        debugPrint("darfted receipt list: $draftedReceiptList");

      });


      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield draftedReceiptList;;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
    }

  }*/









  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //socket!.dispose();
    super.dispose();
  }

}