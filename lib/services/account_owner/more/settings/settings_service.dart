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



}