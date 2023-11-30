import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:luround/models/account_owner/auth/google_signin_response_model.dart';
import 'package:luround/models/account_owner/auth/login_respone_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/utils/components/my_snackbar.dart';
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
    required BuildContext context,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    }) async {
    
    isLoading.value = true;

    var body = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "photoUrl": "my_photo",
      "accountCreatedFrom": "LOCAL",
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "sign-up", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        await generateQrLink(urlSlug: email);
        getx.Get.offAll(() => LoginPage());
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "proceed to login"
        );
        
      } else {
        isLoading.value = false;
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==>${res.body}');
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "status: ${res.statusCode} - ${res.body}"
        );
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "something went wrong"
      );
    }
  }

  //to generate unique qrlink slug then login
  Future<void> generateQrLink({
    required String urlSlug
  }) async {

    var body = {
      "slug": urlSlug,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "profile/generate-url", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint('this is response status ==> ${res.statusCode}');
      } 
      else {
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response body ==>${res.body}');
      }
    } 
    catch (e) {
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }

  //to login user locally
  Future<dynamic> loginUser({
    required BuildContext context,
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
        //LocalStorage.saveEmail(email);
        debugPrint("my token: ${LocalStorage.getToken()}");
        //check for existing token
        var token = await LocalStorage.getToken();
        // Decode the JWT token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        // Access the payload
        if (decodedToken != null) {
          print("Token payload: $decodedToken");
          // Access specific claims
          // Replace 'sub' with the actual claim you want
          String userId = decodedToken['sub'];
          String email = decodedToken['email'];
          String displayName = decodedToken['displayName'];
          await LocalStorage.saveUserID(userId);
          await LocalStorage.saveEmail(email);
          await LocalStorage.saveUsername(displayName);
        } 
        else {
          print("Failed to decode JWT token.");
        }
        isLoading.value = false;
        getx.Get.offAll(() => MainPage());
        //LuroundSnackBar.successSnackBar(message: "Welcome Onboard");
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "welcome back",
        );
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==>${res.body}');
        debugPrint('this is response statusCode ==>${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "status: ${res.statusCode} - ${res.body}"
        );
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "something went wrong"
      );
      //debugPrint("$e");
    }
  }


  //to log a user out locally and simultaneously with google
  Future<dynamic> logoutUser() async {
    //isLoading.value = true;
    await LocalStorage.deleteToken();
    await LocalStorage.deleteUserID();
    await LocalStorage.deleteUseremail();
    await LocalStorage.deleteUsername();
    await LocalStorage.deleteCloudinaryUrl();
    await signOutWithGoogle().then((value) {
      getx.Get.offAll(() => LoginPage());
      print('logged out succesfully');
    });
    //isLoading.value = false;
    //getx.Get.offAll(() => LoginPage());
  }


  //SignUp/SignIn with Google
  Future<GoogleSignInAccount?> signInWithGoogleTest() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication  googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );
    print("${credential.token}");
    return googleUser;
  }

  Future<GoogleSignInAccount?> signOutWithGoogle() async {
    final _googleSignIn =  GoogleSignIn(
      //scopes: ['email'],
      //serverClientId: "702921706378-gg7k64d8ukc3m8ngq8ml6eqa2071a0vd.apps.googleusercontent.com",
    );
    return _googleSignIn.signOut();
  }


  //to fetch accessToken when a user SignIn/SignUp with google api and then redirect them back to mainpage.
  Future<dynamic> fetchGoogleJwt({
    required BuildContext context,
    required String email,
    required String displayName,
    required String photoUrl,
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
        
        await LocalStorage.saveToken(response.tokenData);
        await LocalStorage.saveEmail(email);
        await LocalStorage.saveUsername(displayName);
        await generateQrLink(urlSlug: email);
        debugPrint("${LocalStorage.getToken()}");
        debugPrint(email);
        debugPrint(displayName);
        getx.Get.offAll(() => MainPage());
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "Welcom $displayName"
        );
      } 
      else {
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "status: ${res.statusCode} - ${res.body}"
        );
      }
    } 
    on HttpException {
      baseService.handleError(const HttpException("Something went wrong"));
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "something went wrong"
      );
      //debugPrint("$e");
    }
  }


  //RESET PASSWORD//
  //to reset a user password by sending them an OTP
  Future<dynamic> sendResetPasswordOTP({
    required BuildContext context,
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
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "otp sent successfully"
        );
        getx.Get.to(() => PasswordLinkSentPage());
      } else {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "status: ${res.statusCode} - ${res.body}"
        );
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "something went wrong"
      );
    }
  }

  //to fetch accessToken when a user SignIn/SignUp with google api and then redirect them back to mainpage.
  Future<dynamic> resetPassword({
    required BuildContext context,
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
        debugPrint('this is response body ==>${res.body}');
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "status: ${res.statusCode} - ${res.body}"
        );
      }
    } 
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "something went wrong"
      );
    }
  }


  

}