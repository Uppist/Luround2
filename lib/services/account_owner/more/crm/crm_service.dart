import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/models/account_owner/more/crm/client_transaction_model.dart';
import 'package:luround/models/account_owner/more/crm/contact_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';











class CRMService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();

  //to expand the tile
  int selectedIndex = -1;
  
  //for searching for contact and add contact screen
  final TextEditingController searchContactController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController contactPhoneNumberController = TextEditingController();
  
  /////[GET LOGGED-IN USER'S CONTACT LIST]//////
  var contactList = <ContactResponse>[].obs;
  var filteredContactList = <ContactResponse>[].obs;

  //working well
  Future<void> filterContacts(String query) async {
    if (query.isEmpty) {
      filteredContactList.clear();
      filteredContactList.addAll(contactList);
      print("when query is empty: $filteredContactList");
    } 
    else {
      filteredContactList.clear(); // Clear the previous filtered list

      // Use addAll to add the filtered items to the list
      filteredContactList.addAll(contactList
        .where((user) => user.client_name.contains(query)) // == query
        .toList());

      print("when query is not empty: $filteredContactList");
    }
  }
  

  Future<List<ContactResponse>> getUserContacts() async {
    try {

      isLoading.value = true;
      http.Response res = await baseService.httpGet(endPoint: "crm/contacts");

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //debugPrint('this is response body ==>${res.body}');
        debugPrint("user contacts fetched successfully!!");

        List<dynamic> response = json.decode(res.body);
  

        var finalResult = response.map((e) => ContactResponse.fromJson(e)).toList();
        
        contactList.clear();
        contactList.addAll(finalResult);
        print("contactList: $contactList");
        
        //return data list
        return finalResult;
        

      } 
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        throw Exception('Failed to fetch contacts from server');
      }
    }   
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    }
  }


  ///[CREATE NEW CONTACT AND SAVE IT TO DB]//
  Future<void> addNewContact({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    }) async {

    isLoading.value = true;

    var body = {
      ////////////////
      "name": client_name,
      "email": client_email,
      "phone_number": client_phone_number,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "crm/new-contact", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("contact added successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "contact added successfully"
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
          message: "failed to add contact"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }

  ///[DELETE CONTACT FROM DB]//
  Future<void> deleteContact({
    required BuildContext context,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    }) async {

    isLoading.value = true;

    var body = {
      ////////////////
      "name": client_name,
      "email": client_email,
      "phone_number": client_phone_number,
    };

    try {
      http.Response res = await baseService.httpDelete(endPoint: "crm/delete-customer-contact", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("contact deleted successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "contact deleted successfully"
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
          message: "failed to delete contact"
        );
        //.whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }

  









  /////////////////////for searching for client transaction history///////////////////////////
  final TextEditingController searchClientTrxController = TextEditingController();
  /////[GET LOGGED-IN USER'S CONTACT LIST]//////
  var clientTrxList = <ClientTrxHistoryResponse>[].obs;
  var filteredclientTrxList = <ClientTrxHistoryResponse>[].obs;

  //working well
  Future<void> filterClientTrxHistory(String query) async {
    if (query.isEmpty) {
      filteredclientTrxList.clear();
      filteredclientTrxList.addAll(clientTrxList);
      print("when query is empty: $filteredclientTrxList");
    } 
    else {
      filteredclientTrxList.clear();
      // Use addAll to add the filtered items to the list
      filteredclientTrxList.addAll(
        clientTrxList
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query
        .toList()
      );

      print("when query is not empty: $filteredclientTrxList");
    }
  }
  

  Future<List<ClientTrxHistoryResponse>> getClientTrxHistory({required String client_email}) async {
    try {

      isLoading.value = true;
      http.Response res = await baseService.httpGet(endPoint: "crm/customer-transactions?customer_email=$client_email");

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("client trx history fetched successfully!!");

        List<dynamic> response = json.decode(res.body);
        List<ClientTrxHistoryResponse> finalResult = response.map((e) => ClientTrxHistoryResponse.fromJson(e)).toList();
        
        clientTrxList.clear();
        clientTrxList.addAll(finalResult);
        print("client-trx-list: $clientTrxList");
        
        //return data list
        return clientTrxList;
        

      } 
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        throw Exception('Failed to fetch client trx from server');
      }
    }   
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    }
  }





  @override
  void dispose() {
    // TODO: implement dispose
    searchContactController.dispose();
    contactEmailController.dispose();
    contactNameController.dispose();
    contactPhoneNumberController.dispose();
    searchClientTrxController.dispose();
    super.dispose();
  }


  @override
  void onInit() {
    super.onInit();
  }


}