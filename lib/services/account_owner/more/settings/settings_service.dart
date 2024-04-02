import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/models/account_owner/more/pricing/billing_history_model.dart';
import 'package:luround/models/account_owner/more/transactions/saved_banks_response.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/PIN_settings/otp_confirmation_screen.dart';











class SettingsService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
  var controller = getx.Get.put(MoreController());
  

  /////[GET USER PROFILE DETAILS]/////
  Future<UserModel> getUserProfileDetails() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "profile/get?email=$email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //decode the response body here
        UserModel userModel = UserModel.fromJson(jsonDecode(res.body));
        await LocalStorage.saveUserID(userModel.id);
        /////////////
        return userModel;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user credentials or information');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    
    }
  }
  

  ///[UPDATE USER'S Luround URL BY CUSTOMIZATION]//
  Future<void> customizeUserURL({
    required BuildContext context,
    required String slug,
    }) async {

    isLoading.value = true;

    var body = {
      "slug": slug
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/generate-custom-url", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        //debugPrint('this is response body ==> ${res.body}');
        debugPrint("user luround url customized succesfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "profile url customized successfully"
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
          message: "failed to customize profile url"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong $e");
    }
  }

  ///[UPDATE USER'S Luround Account password]//
  Future<void> changeUserLuroundPassword({
    required BuildContext context,
    required String old_password,
    required String new_password,
    }) async {

    isLoading.value = true;

    var body = {
      "old_password": old_password,
      "new_password": new_password,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "change-password", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        //debugPrint('this is response body ==> ${res.body}');
        debugPrint("user luround account password successfully changed");
        controller.currentPasswordController.clear();
        controller.newPasswordController.clear();
        controller.confirmNewPasswordController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "your account password has been updated"
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
          message: "failed to update account password"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong $e");
    }
  }

  ///[UPDATE USER'S Luround Wallet PIN]//
  Future<void> resetUserWalletPIN({
    required BuildContext context,
    required String new_pin,
    required String otp,
    }) async {

    isLoading.value = true;

    var body = {
      "new_pin": new_pin,
      "otp": int.parse(controller.otpForNewPinController.text),
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "wallet/forgot-wallet-pin", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        //debugPrint('this is response body ==> ${res.body}');
        debugPrint("user luround wallet pin successfully updated");
        controller.newWithdrawalPINController.clear();
        controller.confirmNewWithdrawalPINController.clear();
        controller.otpForNewPinController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "wallet pin successfully updated"
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
          message: "failed to reset wallet pin"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong $e");
    }
  }

  ///[UPDATE USER'S Luround Wallet PIN]//
  Future<void> changeUserWalletPIN({
    required BuildContext context,
    required String old_pin,
    required String new_pin,
    }) async {

    isLoading.value = true;

    var body = {
      "old_pin": old_pin,
      "new_pin": new_pin
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "wallet/reset-wallet-pin", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        //debugPrint('this is response body ==> ${res.body}');
        debugPrint("user luround wallet pin successfully changed");
        controller.currentPINController.clear();
        controller.newPINController.clear();
        controller.confirmNewPINController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "wallet pin successfully changed"
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
          message: "failed to change wallet pin"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong: $e");
    }
  }

  /////[GET USER OTP FOR RESETING WALLET PIN]/////
  Future<dynamic> getUserOTPForResetingWalletPIN({required BuildContext context}) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "wallet/send-wallet-pin-reset-otp",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //decode the response body here
        //UserModel userModel = UserModel.fromJson(jsonDecode(res.body));
        dynamic response = json.decode(res.body);
        debugPrint("$response");
        getx.Get.to(() => OTPPINScreen());
        /////////////
        //return userModel;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to fetch otp from server [${res.statusCode} <=> ${res.reasonPhrase}]"
        );
        throw Exception('Failed to FETCH otp from backend for reseting wallet pin : [${res.statusCode} <=> ${res.reasonPhrase}]');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    
    }
  }

  










  //filter list for select_bank_screen2
  var bankList = [].obs;
  var filteredBankList = [].obs;
  var selectedIndex = 0.obs; // Initialize with the default selected index

  //GET REQUEST TO CALL THE LIST OF BANKS API
  Future<List<dynamic>> getBanksApi() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "wallet/get-banks",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Update loading state within the success block
        isLoading.value = false;

        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('List of banks fetched successfully!');
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> jsonResponse = json.decode(res.body);

        // Access the "data" key and assume its value is a list
        List<dynamic> dataList = jsonResponse['data'];

        bankList.clear();
        bankList.addAll(dataList);
        print("list of banks fetched: $bankList");
        
        //return data list
        return bankList;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load available banks');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }
  //search functionality for searching through the "FETCH BANKS API"
  Future<void> filterForSelectBankScreen(String query) async {
    if (query.isEmpty) {
      filteredBankList.clear();
      filteredBankList.addAll(bankList);
      print("when query is empty: $bankList");
    } 
    else {
      filteredBankList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredBankList.addAll(
        bankList.where((user) => user['name'].toString().toLowerCase().contains(query.toLowerCase()))  //.contains(query)
      .toList());
      print("when query is not empty: $filteredBankList");
    }
  }


  ///[TO LAZY LOAD THE LIST OF BANKS API ]///
  Future<List<dynamic>> loadFetchedBank() async {
    try {
      isLoading.value = true;
      final List<dynamic> banks = await getBanksApi();
      banks.sort((a, b) => a["name"].toString().toLowerCase().compareTo(b["name"].toString().toLowerCase()));

      isLoading.value = false;
      filteredBankList.value = List.from(banks);
      print("loaded fetched banks: ${filteredBankList}");
      return filteredBankList;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      print("Error loading data: $error");
      //print("Error loading data: $error");
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }
  

  /////[GET LOGGED-IN USER'S LIST OF Saved Banks]//////
  var savedAccounts = <SavedBanks>[].obs;
  var filteredSavedAccounts = <SavedBanks>[].obs;

  Future<void> filterSavedBank(String query) async {
    if (query.isEmpty) {
      filteredSavedAccounts.clear();
      filteredSavedAccounts.addAll(savedAccounts);
      print("when query is empty: $filteredSavedAccounts");
    } 
    else {
      filteredSavedAccounts.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filteredSavedAccounts.addAll(
      savedAccounts.where((user) =>
          user.account_name.toLowerCase().contains(query.toLowerCase()))
      .toList());
      print("when query is not empty: $filteredSavedAccounts");
    }
  }
  //GET REQUEST TO FETCH USER'S BANK DETAILS
  Future<List<SavedBanks>> getUserSavedAccounts() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "wallet/get-saved-banks?userId=$userId",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //debugPrint('this is response body ==>${res.body}');
        debugPrint("user saved accounts fetched successfully!!");
        //decode the response body here
        // Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          final List<SavedBanks> finalResult = response.map((e) => SavedBanks.fromJson(e)).toList();

          savedAccounts.clear();
          savedAccounts.addAll(finalResult);
          debugPrint("$savedAccounts");

          // Return saved bank account list
          return savedAccounts;
        } else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        throw Exception('Failed to fetch user saved banks');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }

  ///[TO LAZY LOAD THE USER LIST OF SAVED BANKS IN THE FUTURE BUILDER FOR WITHDRAWAL SCREEN]///
  Future<List<SavedBanks>> loadSavedBanksData() async {
    try {
      isLoading.value = true;
      final List<SavedBanks> banks = await getUserSavedAccounts();
      banks.sort((a, b) => a.account_name.toLowerCase().compareTo(b.account_name.toLowerCase()));

      isLoading.value = false;
      filteredSavedAccounts.clear();
      filteredSavedAccounts.addAll(banks);
      print("loaded: ${filteredSavedAccounts}");
      return filteredSavedAccounts;
  
    } 
    catch (error, stackTrace) {
      isLoading.value = false;
      print("Error loading data: $error");
      //print("Error loading data: $error");
      throw Exception("$error => $stackTrace");
      // Handle error as needed, e.g., show an error message to the user
    }
  }
  

  ///[CREATE NEW BANK DETAILS]//
  Future<void> createBankDetails({
    required BuildContext context,
    required String account_name,
    required String account_number,
    required String bank_name,
    required String bank_code,
    required String country,
    }) async {

    isLoading.value = true;

    var body = {
      "account_name" : account_name,
      "account_number": account_number,
      "bank_name": bank_name,
      "bank_code": bank_code,
      "country": country,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/add-bank-details", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("user bank details created successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "bank details created successfully"
        );
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
          message: "failed to create bank details"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong: $e");
    }
  }

  
  ///[DELETE BANK DETAILS]//
  Future<void> deleteBankDetails({
    required BuildContext context,
    required String account_name,
    required String account_number,
    required String bank_name,
    required String bank_code,
    required String country,
    }) async {

    isLoading.value = true;

    var body = {
      "account_name" : account_name,
      "account_number": account_number,
      "bank_name": bank_name,
      "bank_code": bank_code,
      "country": country,
    };


    try {
      dio.Response res = await baseService.deleteRequestWithBodyDio(endPoint: "wallet/delete-bank-detail", data: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        debugPrint("user bank details created successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "bank detail deleted successfully"
        );
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.statusMessage}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to delete bank detail"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("$e");
    }
  }




 
  //TextControllers for inputing bank details
  //final enterBankController = TextEditingController();
  final enterBankCodeController = TextEditingController();
  final enterAccountNameController = TextEditingController();
  final enterAccountNumberController = TextEditingController();
  //TextController for searching for available banks
  final searchBankController = TextEditingController();
  //reactive string to check if a bank is selected
  getx.RxString selectedBank = ''.obs;













  /////////PRICING STUFFS///////////////////////////
  var isBillingHistoryActive = false.obs;
  /////[GET LOGGED-IN USER'S PAYMENT HISTORY LIST]//////
  var billingHistoryList = <BillingHistoryResponse>[].obs;
  Future<List<BillingHistoryResponse>> getUserBillingHistory() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "payments/payment-history",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user billing history fetched successfully!!");
        //decode the response body here
        // Check if the response body is not null
        if (res.body != null) {
          final List<dynamic> response = jsonDecode(res.body);
          final List<BillingHistoryResponse> finalResult = response.map((e) => BillingHistoryResponse.fromJson(e)).toList();

          //billingHistoryList.clear();
          //billingHistoryList.addAll(finalResult);
          debugPrint("$finalResult");

          // Return saved bank account list
          return finalResult;
        } 
        else {
          throw Exception('Response body is null');
        }
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response bosy ==> ${res.body}');
        throw Exception('Failed to fetch user billing history');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }




  @override
  void dispose() {
    // TODO: implement dispose
    enterAccountNameController.dispose();
    enterAccountNameController.dispose();
    enterBankCodeController.dispose();
    super.dispose();
  }
  
  @override
  void onInit() {
    // TODO: implement onInit
    //loadSavedBanksData();
    loadFetchedBank();
    super.onInit();
  }


}