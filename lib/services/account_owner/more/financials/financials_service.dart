import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/user_profile/user_model.dart';
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

  var dataList = <UserServiceModel>[].obs;
  var filteredList = <UserServiceModel>[].obs;

  //////////////////////////////////////////////////////////////////////////////////
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
        .where((user) => user.service_name.contains(query)) // == query
        .toList());

      /*filteredList.where((user) => user.serviceDetails.serviceName.toLowerCase() == query)
        .toList();*/

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
        debugPrint("$response");
        return response.map((e) => UserServiceModel.fromJson(e)).toList();
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
      throw HttpException("$e");
    
    }
  }



  @override
  void onInit() {
    super.onInit();
    //service.filteredList.addAll(service.dataList);
    //print("initState: ${service.filteredList}");

    getUserServices().then((List<UserServiceModel> list) {
      filteredList.clear();
      filteredList.addAll(list);  //service.dataList
      print("initState: $filteredList");
    });
  }

}