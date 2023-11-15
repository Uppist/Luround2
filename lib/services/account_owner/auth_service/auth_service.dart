import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:luround/models/account_owner/auth/google_signin_response_model.dart';
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


  //to log a user out locally
  Future<dynamic> logoutUser() async {
    isLoading.value = true;
    LocalStorage.deleteToken();
    LocalStorage.deleteUserID();
    LocalStorage.deleteUseremail();
    LocalStorage.deleteUsername();
    getx.Get.offAll(() => LoginPage())!.then((value) {isLoading.value = false;});
    //isLoading.value = false;
  }


  //to sign in / sign up a user with google
  Future<dynamic> signInWithGoogle() async {

    isLoading.value = true;

    /*var body = {
      "email": email,
      "displayName": displayName,
      "accountCreatedFrom": "REMOTE"
    };*/

    try {
      http.Response res = await baseService.httpGetGoogle(endPoint: "google-auth",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        GoogleSigninResponse response = GoogleSigninResponse.fromJson(json.decode(res.body));
        LocalStorage.saveToken(response.tokenData);
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



  ////////////////////TEST/////////////////
  Future<Map<String, dynamic>?> signInWithGoogleTest() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    // The user canceled the sign-in process
    return null;
  }

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Exchange the Google Sign-In authentication code for an access token
  final response = await http.post(
    Uri.parse("https://oauth2.googleapis.com/token"),
    body: {
      'code': googleAuth.serverAuthCode,
      'client_id': '702921706378-p1p9ubud1fbh319urre24j6coj2fb9fj.apps.googleusercontent.com',
      'client_secret': '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',
      //'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob', // Use the appropriate redirect URI
      'grant_type': 'authorization_code',
    },
  );

  if (response.statusCode == 200) {
    // Decode the access token
    Map<String, dynamic> tokenInfo = json.decode(response.body);

    // Access user credentials from the access token info
    String accessToken = tokenInfo['access_token'];
    String idToken = tokenInfo['id_token'];

    // You can use the access token or id token as needed
    print("toke : $accessToken");
    return {'access_token': accessToken, 'id_token': idToken};
  } else {
    // Handle error
    print('Failed to exchange code for access token. Status code: ${response.statusCode}');
    return null;
  }
}


}