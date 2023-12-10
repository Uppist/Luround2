import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/otp/first_timer/confirm_otp_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/select_country/select_country.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/transfer_screen.dart';






class WithdrawalService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();

  

  ///[CREATE USER PIN]//
  Future<void> createWalletPin({
    required BuildContext context,
    required String wallet_pin,
    }) async {

    isLoading.value = true;

    var body = {
      "wallet_pin": wallet_pin,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/create-wallet-pin", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user wallet pin created");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "wallet pin successfully created"
        );
        getx.Get.to(() => ConfirmOTPPage());
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
          message: "failed to create wallet pin"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


  ///[VERIFY USER PIN]//
  Future<void> verifyWalletPin({
    required BuildContext context,
    required String wallet_pin,
    }) async {

    isLoading.value = true;

    var body = {
      "wallet_pin": wallet_pin,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/verify-wallet-pin", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user wallet pin verified");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "wallet pin successfully verified"
        );
        getx.Get.to(() => SelectCountryPage());
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
          message: "failed to verify wallet pin"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


  ///[CREATE NEW BANK DETAILS]//
  Future<void> createBankDetailsFromAddDetailsButton({
    required BuildContext context,
    required String account_name,
    required String account_number,
    required String bank_name,
    required String country,
    }) async {

    isLoading.value = true;

    var body = {
      "account_name" : account_name,
      "account_number": account_number,
      "bank_name": bank_name,
      "country": country
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/add-bank-details", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
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
      throw const HttpException("Something went wrong");
    }
  }

  ///[CREATE NEW BANK DETAILS]//
  Future<void> createBankDetailsFromAddAccountTab({
    required BuildContext context,
    required String account_name,
    required String account_number,
    required String bank_name,
    required String country,
    }) async {

    isLoading.value = true;

    var body = {
      "account_name" : account_name,
      "account_number": account_number,
      "bank_name": bank_name,
      "country": country
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "wallet/add-bank-details", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user bank details created successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "bank details created successfully"
        );
        getx.Get.to(() => TransferScreen());
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
      throw const HttpException("Something went wrong");
    }
  }











  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}