import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/models/account_owner/auth/login_respone_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/views/account_owner/auth/screen/login/login_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';







class AuthService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;

  //to register user locally
  Future<dynamic> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String password
    }) async {
    
    isLoading.value = true;

    var body = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "accountCreatedFrom": "LOCAL"
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "sign-up", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        LocalStorage.saveEmail(email);
        getx.Get.offAll(() => LoginPage());
      } else {
        isLoading.value = false;
        debugPrint('this is response reason ==>${res.reasonPhrase}');
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      //debugPrint("$e");
    }
  }


  //to login user locally
  Future<dynamic> loginUser({
    required String email,
    required String password
    }) async {
    
    isLoading.value = true;

    var body = {
      "email": email,
      "password": password,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "auth/login", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        LoginResponse response = LoginResponse.fromJson(json.decode(res.body));
        LocalStorage.saveToken(response.tokenData);
        LocalStorage.saveEmail(email);
        debugPrint("${LocalStorage.getToken()}");
        LuroundSnackBar.successSnackBar(message: "Welcome back");
        isLoading.value = false;
        getx.Get.offAll(() => MainPage());
      } else {
        isLoading.value = false;
        debugPrint('this is response reason ==>${res.reasonPhrase}');
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      //debugPrint("$e");
    }
  }


  //to log a user out locally
  Future<dynamic> logoutUser() async {
    isLoading.value = true;
    LocalStorage.deleteToken();
    LocalStorage.deleteUserID();
    LocalStorage.deleteUseremail();
    LocalStorage.deleteUsername();
    getx.Get.offAll(() => LoginPage());
    isLoading.value = false;
  }


  //to sign in / sign up a user with google
  Future<dynamic> signInWithGoogle() async {
    isLoading.value = true;
  }


}