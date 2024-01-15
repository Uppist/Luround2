import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/PIN_settings/otp_confirmation_screen.dart';











class CRMService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
  //var controller = getx.Get.put(MoreController());
  
  /////[GET LOGGED-IN USER'S BOOKINGS LIST]//////
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
        .where((user) => user.contact_name.toLowerCase().contains(query)) // == query
        .toList());

      print("when query is not empty: $filteredContactList");
    }
  }
  

  Future<List<ContactResponse>> getUserBookings() async {
    try {

      isLoading.value = true;
      http.Response res = await baseService.httpGet(endPoint: "crm/contacts");

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user contacts fetched successfully!!");

        List<dynamic> response = json.decode(res.body);
  

        var finalResult = response.map((e) => ContactResponse.fromJson(e)).toList();
        
        contactList.clear();
        contactList.addAll(finalResult);
        print("contactList: $contactList");
        
        //return data list
        return finalResult;
        

      } else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to fetch contacts from server');
      }
    }   
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    }
  }

}