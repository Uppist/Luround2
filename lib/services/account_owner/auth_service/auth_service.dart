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


  //to log a user out locally
  Future<dynamic> logoutUser() async {
    isLoading.value = true;
    LocalStorage.deleteToken();
    LocalStorage.deleteUserID();
    LocalStorage.deleteUseremail();
    LocalStorage.deleteUsername();
    signOutWithGoogle();
    getx.Get.offAll(() => LoginPage())!.then((value) {isLoading.value = false;});
    //isLoading.value = false;
  }


  /////////////////////////////////////////////////////

  //functions for url_launcher (to launch user socials link)
  Future<void> launchGoogleSignIn() async{
    String link = "https://luround.onrender.com/google-auth";
    Uri linkUri = Uri(
      scheme: 'https',
      path: link.replaceFirst("https://", "")
    );
    if(await launcher.canLaunchUrl(linkUri)) {
      launcher.launchUrl(
        linkUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $linkUri');
    }
  }


  Future<void> fetchJwt() async {
    final response = await http.get(Uri.parse("https://luround.onrender.comapi/v1/google/signIn"));

    if (response.statusCode == 200) {
      // Decode the JWT payload
      Map<String, dynamic> jwtPayload = JwtDecoder.decode(response.body);
      dynamic serverResponse = json.decode(response.body);

      LocalStorage.saveToken(serverResponse['accessToken']);

      // Access user credentials from the JWT payload
      String email = jwtPayload['email'];
      String displayName = jwtPayload['displayName'];
      print(email);
      print(displayName);
    } 
    else {
      throw Exception('Failed to fetch JWT');
    }
  }
  ////////////////////////////////////////////////////////////
  
  
  
  
  
  

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

}