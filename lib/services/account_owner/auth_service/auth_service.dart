import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/models/account_owner/auth/login_respone_model.dart';
import 'package:luround/models/account_owner/auth/register_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:get/get.dart' as getX;
import 'package:luround/views/account_owner/auth/screen/login/login_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';







class AuthService extends getX.GetxController {

  var baseService = getX.Get.put(BaseService());

  //to register user locally
  Future<dynamic> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String password
    }) async {

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
        print('this is response status ==>${res.statusCode}');
        //LuroundSnackBar.successSnackBar(message: "Login $firstName");
        LocalStorage.saveEmail(email);
        getX.Get.offAll(() => LoginPage());
      } else {
        print('this is response reason ==>${res.reasonPhrase}');
        LuroundSnackBar.errorSnackBar(message: "Something went wrong.");
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  //to login user locally
  Future<dynamic> loginUser({
    required String email,
    required String password
    }) async {

    var body = {
      "email": email,
      "password": password,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "auth/login", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        print('this is response status ==>${res.statusCode}');
        LoginResponse response = LoginResponse.fromJson({"accessToken": res.body});
        LocalStorage.saveToken(response.accessToken);
        LocalStorage.saveEmail(email);
        print("${LocalStorage.getToken()}");
        LuroundSnackBar.successSnackBar(message: "Welcome back");
        getX.Get.offAll(() => MainPage());
      } else {
        print('this is response reason ==>${res.reasonPhrase}');
        LuroundSnackBar.errorSnackBar(message: "Something went wrong.");
      }
    } catch (e) {
      debugPrint("$e");
    }
  }


}