import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/models/account_owner/more/crm/contact_response_model.dart';
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
        .where((user) => user.client_name.toLowerCase().contains(query)) // == query
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

  ///[CREATE NEW RECEIPT AND SAVE IT TO DB]//
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





  @override
  void dispose() {
    // TODO: implement dispose
    searchContactController.dispose();
    contactEmailController.dispose();
    contactNameController.dispose();
    contactPhoneNumberController.dispose();
    super.dispose();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    getUserContacts().then((value) {
      filteredContactList.value = value;
      print("filtered contacts list: ${filteredContactList}");
    });
    super.onInit();
  }

}