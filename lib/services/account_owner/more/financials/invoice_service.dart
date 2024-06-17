import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:luround/models/account_owner/more/financials/invoice/invoice_respose_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;










class InvoicesService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
  var token = LocalStorage.getToken();


  /////[GET LOGGED-IN USER'S LIST OF PAID INVOICES]//////
  var paidInvoiceList = <InvoiceResponse>[].obs;
  var filteredPaidInvoiceList = <InvoiceResponse>[].obs;

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
          e.send_to_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredPaidInvoiceList");
    }
  }
  

  /////[GET LIST OF PAID INVOICES]//////
  Future<List<InvoiceResponse>>  getUserPaidInvoice() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "invoice/paid-invoices",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user paid invoices fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        //debugPrint("$response");
        var finalResult = response.map((e) => InvoiceResponse.fromJson(e)).toList();
        paidInvoiceList.clear();
        paidInvoiceList.addAll(finalResult);
        debugPrint("paid invoice list: $paidInvoiceList");
        return paidInvoiceList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch user paid invoices');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("error: $e");
    
    }
  }
  

  /*IO.Socket? socket;
  Stream<List<InvoiceResponse>>  getUserPaidInvoice() async* {
    try {

      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-paid-invoices" event after connecting
        socket!.emit('user-paid-invoices');
      });

      socket!.on('user-paid-invoices', (data) {
        List<dynamic> response = data; //json.decode(data);
        var finalResult = response.map((e) => InvoiceResponse.fromJson(e)).toList();
        paidInvoiceList.clear();
        paidInvoiceList.addAll(finalResult);
        debugPrint("paid invoice list: $paidInvoiceList");

      });


      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield paidInvoiceList;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
    }

  }*/
  



  /////[GET LOGGED-IN USER'S LIST OF UNPAID INVOICES]//////
  var unpaidInvoiceList = <InvoiceResponse>[].obs;
  var filteredUnpaidInvoiceList = <InvoiceResponse>[].obs;
  var filteredDueInvoiceList = <InvoiceResponse>[].obs;
  

  //check if today's date is exactly 3 days before the unpaid invoice

  bool isDueInThreeDays(InvoiceResponse invoice) {
    try {
      // Get the current date
      DateTime currentDate = DateTime.now();

      // Convert the due date string to a DateTime object
      DateTime dueDate = DateTime.parse(invoice.due_date);

      // Calculate the difference in days
      int differenceInDays = dueDate.difference(currentDate).inDays;

      // Check if today is exactly 3 days before the due date
      return differenceInDays == 3;
    } 
    catch (e, stackTrace) {
      // Handle if invoice.due_date is not in the expected format
      log('Error parsing due date format: $e - $stackTrace');
      return false;
    }
  }


  //check if an invoice is due
  Future<void> hasDueItems() async{
    // Loop through the user list and check if each object is due
    for (InvoiceResponse invoice in unpaidInvoiceList) {
      if (isDueInThreeDays(invoice)) {
        filteredDueInvoiceList.clear();
        filteredDueInvoiceList.add(invoice);
      }
    }

    // Print the due list
    log("Due List: $filteredDueInvoiceList");
    update();
  }


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
          e.send_to_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredUnpaidInvoiceList");
    }
  }

  /////[GET LIST OF UNPAID INVOICES]//////
  Future<List<InvoiceResponse>> getUserUnpaidInvoice() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "invoice/unpaid-invoices",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user unpaid invoices fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        //debugPrint("$response");
        var finalResult = response.map((e) => InvoiceResponse.fromJson(e)).toList();
        unpaidInvoiceList.clear();
        unpaidInvoiceList.addAll(finalResult);  //finalResult
        debugPrint("unpaid invoice list: $unpaidInvoiceList");
        return unpaidInvoiceList;
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
      //debugPrint("Error net: $e");
      throw Exception("error: $e");
    
    }
  }


  /*Stream<List<InvoiceResponse>> getUserUnpaidInvoice() async* {
    try {

      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-unpaid-invoices" event after connecting
        socket!.emit('user-unpaid-invoices');
      });

      socket!.on('user-unpaid-invoices', (data) {
        List<dynamic> response = data; //json.decode(data);
        var finalResult = response.map((e) => InvoiceResponse.fromJson(e)).toList();
        unpaidInvoiceList.clear();
        unpaidInvoiceList.addAll(finalResult);  //finalResult
        debugPrint("unpaid invoice list: $unpaidInvoiceList");

      });


      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield unpaidInvoiceList;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
    }

  }*/



  /////[GET LOGGED-IN USER'S LIST OF DUE INVOICES]//////
  var dueInvoiceList = <InvoiceResponse>[].obs;

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
      dueInvoiceList.where((e) => e.send_to_name.toLowerCase().contains(query.toLowerCase())).toList());
      print("when query is not empty: $filteredDueInvoiceList");
    }
  }






  @override
  void onInit() {
    hasDueItems().then(
      (value) {
        print("Due Invoices List Loaded into the Widget Tree: $filteredDueInvoiceList");
      }
    );
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //socket!.dispose();
    super.dispose();
  }

}