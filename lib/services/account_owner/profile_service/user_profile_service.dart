import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;









class UserProfileService extends getx.GetxController {


  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  

  /////[GET USER PROFILE DETAILS]//////
  /*Future<UserModel> getUserProfileDetails({required String email}) async {
    
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "profile/get?email=$email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        //decode the response body here
        UserModel userModel = UserModel.fromJson(json.decode(res.body));
        return userModel;
      } else {
        isLoading.value = false;
        debugPrint('this is response reason ==>${res.reasonPhrase}');
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      //rethrow;
    }
  }*/



}