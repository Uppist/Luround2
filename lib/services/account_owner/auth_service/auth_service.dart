import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:luround/models/account_owner/auth/google_signin_response_model.dart';
import 'package:luround/models/account_owner/auth/login_respone_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/password_link_sent_screen.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/password_updated.dart';
import 'package:luround/views/account_owner/auth/screen/login/login_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;









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
        LocalStorage.saveUsername("$firstName $lastName");
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
        LuroundSnackBar.successSnackBar(message: "Welcome Onboard");
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


  //to log a user out locally and simultaneously with google
  Future<dynamic> logoutUser() async {
    //isLoading.value = true;
    LocalStorage.deleteToken();
    LocalStorage.deleteUserID();
    LocalStorage.deleteUseremail();
    LocalStorage.deleteUsername();
    signOutWithGoogle();
    //isLoading.value = false;
    getx.Get.offAll(() => LoginPage());
  }


  //SignUp/SignIn with Google
  Future<GoogleSignInAccount?> signInWithGoogleTest() async {
    final _googleSignIn = GoogleSignIn(
      //scopes: ['email'],
      //serverClientId: "702921706378-gg7k64d8ukc3m8ngq8ml6eqa2071a0vd.apps.googleusercontent.com",
    );
    return _googleSignIn.signIn();
  }

  Future<GoogleSignInAccount?> signOutWithGoogle() async {
    final _googleSignIn = GoogleSignIn(
      //scopes: ['email'],
      //serverClientId: "702921706378-gg7k64d8ukc3m8ngq8ml6eqa2071a0vd.apps.googleusercontent.com",
    );
    return _googleSignIn.signOut();
  }


  //to fetch accessToken when a user SignIn/SignUp with google api and then redirect them back to mainpage.
  Future<dynamic> fetchGoogleJwt({
    required String email,
    required String? displayName,
    required String? photoUrl,
    required String google_user_id,
    }) async {

    var body = {
      "email": email,
      "displayName": displayName,
      "photoUrl": photoUrl,
      "google_user_id": google_user_id
    };

    try {
      http.Response res = await baseService.httpGooglePost(endPoint: "google/signIn", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
        GoogleSigninResponse response = GoogleSigninResponse.fromJson(jsonDecode(res.body));
        LocalStorage.saveToken(response.tokenData);
        LocalStorage.saveEmail(email);
        LocalStorage.saveUsername(displayName!);
        debugPrint("${LocalStorage.getToken()}");
        LuroundSnackBar.successSnackBar(message: "Welcome Onboard");
        getx.Get.offAll(() => MainPage());
      } 
      else {
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
      }
    } 
    on HttpException {
      baseService.handleError(const HttpException("Something went wrong"));
      //debugPrint("$e");
    }
  }


  //RESET PASSWORD//
  //to reset a user password by sending them an OTP
  Future<dynamic> sendResetPasswordOTP({
    required String email,
    }) async {
    
    isLoading.value = true;

    var body = {
      "email": email,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "send-reset-password-otp", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        getx.Get.to(() => PasswordLinkSentPage());
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

  //to fetch accessToken when a user SignIn/SignUp with google api and then redirect them back to mainpage.
  Future<dynamic> resetPassword({
    required String email,
    required String new_password,
    required int otp,
    }) async {
    
    isLoading.value = true;

    var body = {
      "email": email,
      "new_password": new_password,
      "otp": otp,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "reset-password", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        isLoading.value = false;
        getx.Get.offAll(() => PasswordUpdatedPage());
      } else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      //debugPrint("$e");
    }
  }


  

}