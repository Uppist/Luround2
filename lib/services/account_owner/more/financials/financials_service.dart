import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';










class FinancialsService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();



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
  }
  

  ///[CREATE QUOTES SCREEN]
  getx.RxList<UserServiceModel> selectedProducts = <UserServiceModel>[].obs;

  void toggleProductSelection(UserServiceModel product) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }
  }

  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$email",);
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
    }
  }
  

  ///[CREATE INVOICE SCREEN]
  getx.RxList<UserServiceModel> selectedProductsForInvoice = <UserServiceModel>[].obs;

  void toggleProductSelectionForInvoice(UserServiceModel product) {
    if (selectedProductsForInvoice.contains(product)) {
      selectedProductsForInvoice.remove(product);
    } else {
      selectedProductsForInvoice.add(product);
    }
  }

  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServicesForInvoice() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$email",);
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
        return dataListForInvoice;
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
      filteredListForReceipt.addAll(dataListForInvoice);
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
  }
  

  ///[CREATE INVOICE SCREEN]
  getx.RxList<UserServiceModel> selectedProductsForReceipt = <UserServiceModel>[].obs;

  void toggleProductSelectionForReceipt(UserServiceModel product) {
    if (selectedProductsForReceipt.contains(product)) {
      selectedProductsForReceipt.remove(product);
    } else {
      selectedProductsForReceipt.add(product);
    }
  }

  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServicesForReceipt() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$email",);
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
    });
    
    //FOR INVOICE
    getUserServicesForInvoice().then((List<UserServiceModel> list) {
      filteredListForInvoice.clear();
      filteredListForInvoice.addAll(list);  //service.dataList
      print("initState FOR INVOICE: $filteredListForInvoice");
    });

    //FOR RECEIPT
    getUserServicesForReceipt().then((List<UserServiceModel> list) {
      filteredListForReceipt.clear();
      filteredListForReceipt.addAll(list);  //service.dataList
      print("initState FOR RECEIPT: $filteredListForReceipt");
    });
  }

}