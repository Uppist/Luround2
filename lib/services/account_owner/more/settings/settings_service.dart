import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';











class SettingsService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
  

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
        throw Exception('Failed to load user data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      throw HttpException("$e");
    
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
      throw const HttpException("Something went wrong");
    }
  }



}