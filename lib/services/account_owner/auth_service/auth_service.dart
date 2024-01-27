import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as diomygee;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:luround/models/account_owner/auth/create_account_response.dart';
import 'package:luround/models/account_owner/auth/google_signin_response_model.dart';
import 'package:luround/models/account_owner/auth/login_respone_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/utils/components/extractors.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/password_link_sent_screen.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/password_updated.dart';
import 'package:luround/views/account_owner/auth/screen/login/page/login_screen.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;









class AuthService extends getx.GetxController {


  var baseService = getx.Get.put(BaseService());
  var FCMToken = LocalStorage.getFCMToken();
  var isLoading = false.obs;
  
  //to check if the token is expired
  bool isTokenExpired(int serverTimestamp) {
    // Convert the server timestamp to a DateTime object
    DateTime tokenExpDate = DateTime.fromMillisecondsSinceEpoch(serverTimestamp * 1000);

    // Get today's date
    DateTime currentDate = DateTime.now();

    // Check if the token expiration date is equal to today's date
    bool isExpired = tokenExpDate.year == currentDate.year &&
    tokenExpDate.month == currentDate.month &&
    tokenExpDate.day == currentDate.day;
    print("is token expired ${isExpired}");
    return isExpired;
  }

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
      "user_nToken": FCMToken,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "sign-up", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        RegisterResponse response = RegisterResponse.fromJson(json.decode(res.body));
        //save access token
        await LocalStorage.saveToken(response.tokenData);
        //check for existing token
        var token = await LocalStorage.getToken();
        //show the saved token
        debugPrint("my token: $token");
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
          int expDate = decodedToken['exp'];
          await LocalStorage.saveTokenExpDate(expDate);
          await LocalStorage.saveUserID(userId);
          await LocalStorage.saveEmail(email);
          await LocalStorage.saveUsername(displayName);
          await generateQrLink(urlSlug: email);
          //isLoading.value = false;
          getx.Get.offAll(() => MainPage());
          showMySnackBar(
            context: context,
            backgroundColor: AppColor.darkGreen,
            message: "account created successfully"
          );
        } 
        else {
          print("Failed to decode JWT token.");
        }
        //
        /*isLoading.value = false;
        getx.Get.offAll(() => MainPage());
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "account created successfully"
        );*/

        
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
      "user_nToken": FCMToken,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "auth/login", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        LoginResponse response = LoginResponse.fromJson(json.decode(res.body));
        await LocalStorage.saveToken(response.tokenData);
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
          int expDate = decodedToken['exp'];
          await LocalStorage.saveTokenExpDate(expDate);
          await LocalStorage.saveUserID(userId);
          await LocalStorage.saveEmail(email);
          await LocalStorage.saveUsername(displayName);
        } 
        else {
          print("Failed to decode JWT token.");
        }
        //
        await generateQrLink(urlSlug: email);
        //
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
    isLoading.value = true;
    await LocalStorage.deleteToken();
    await LocalStorage.deleteUserID();
    await LocalStorage.deleteUseremail();
    await LocalStorage.deleteUsername();
    await LocalStorage.deleteCloudinaryUrl();
    await LocalStorage.deleteCompanyLogoUrl();
    await signOutWithGoogle();
    /*.then((value) {
      getx.Get.offAll(() => LoginPage());
      print('logged out succesfully');
    });*/
    isLoading.value = false;
    getx.Get.offAll(() => LoginPage());
  }


  //Login or Sign Up with Google
  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']); // Add desired scopes
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        print("Google fetched user successfully");
        // User signed in successfully
        // You can also fetch additional information if needed
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        );
        
        /*UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        print("${userCredential.user!.displayName}");
        print("${userCredential.user!.email}");*/
        
        /*await decodeJWTWithDio(
          context: context, 
          email: userCredential.user!.email!, 
          firstName: getFirstName(fullName: userCredential.user!.displayName!), 
          lastName: getLastName(fullName: userCredential.user!.displayName!), 
          photoUrl: "photoUrl", 
          google_user_id: userCredential.user!.uid
        );*/

        await decodeJWTWithDio(
          context: context, 
          email: googleUser.email, 
          firstName:getFirstName(fullName: googleUser.displayName!), 
          lastName: getLastName(fullName: googleUser.displayName!), 
          photoUrl: "my_photo", 
          google_user_id: googleUser.id
        );

      } 
      else {
        // User cancelled the sign-in process
        print("Google Sign-In cancelled by the user");
      }

    }
    on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        print(e.code);
        String errorMessage = "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: errorMessage
        );
      }
      else if (e.code == GoogleSignIn.kSignInCanceledError) {
        // User cancelled the sign-in process
        print("Google Sign-In cancelled by the user");
        print(e.code);
        // Handle errors gracefully
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "Sign-In process terminated or cancelled"
        );
      }
      else if (e.code == GoogleSignIn.kSignInFailedError) {
        // User cancelled the sign-in process
        print(e.code);
        // Handle errors gracefully
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "Sign-In process failed"
        );
      }
      else {        
        String errorMessage = "Something went wrong.";
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: errorMessage
        );
      }
    }
    catch (e) {
      print("Error during Google Sign-In: $e");
      // Handle errors gracefully
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "Error during Google Sign-In: $e"
      );
    }
  }


  Future<void> decodeJWTWithDio({
    required BuildContext context,
    required String email,
    required String firstName,
    required String lastName,
    required String photoUrl,
    required String google_user_id,
  }) async {
    isLoading.value = true;
    try {

      //dio instance
      diomygee.Dio dio = diomygee.Dio();
      
      //body to be encoded by dio
      var body = {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "photoUrl": photoUrl,
        "google_user_id": google_user_id,
        "user_nToken": FCMToken,
      };

      //define or state your headers
      diomygee.Options options = diomygee.Options(
        headers: {
          // Your headers
          "Content-Type": "application/json",
          "Connection": "keep-alive",
          "Accept": "*/*",
          // Add any other headers as needed
         },
      );
    
      //make your POST request
      var res = await dio.post(
        'https://luround.onrender.com/google/signIn', 
        /* other parameters */
        data: body,
        options: options,
      );

      //if/else check to make sure everything goes smooth
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;

        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.data}');
        
        //decode response from the server
        //GoogleSigninResponse jsonResponse = GoogleSigninResponse.fromJson(json.decode(res.data)); 
        
        Map<String, dynamic> jsonResponse = res.data;
        // Access the "accessToken" from the response
        String accessToken = jsonResponse["accessToken"];

        await LocalStorage.saveToken(accessToken);
        var token = await LocalStorage.getToken();
        print(token);
        
        // Decode the JWT token with the awesome package {JWT Decoder}
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        //Access the payload
        if (decodedToken != null) {
          print("Token payload: $decodedToken");
          // Access specific claims
          // Replace 'sub' with the actual claim you want
          String userId = decodedToken['sub'];
          String email = decodedToken['email'];
          String displayName = decodedToken['displayName'];
          int expDate = decodedToken['exp'];
          await LocalStorage.saveTokenExpDate(expDate);
          await LocalStorage.saveUserID(userId);
          await LocalStorage.saveEmail(email);
          await LocalStorage.saveUsername(displayName);
        } 
        else {
          print("Failed to decode JWT token.");
        }
        //generate grlink
        await generateQrLink(urlSlug: email);
        //move with agility to the next page
        getx.Get.offAll(() =>  MainPage());  //MainPage()  MainPageAccViewer()
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "welcome onboard"
        );

      } 
      else {
        isLoading.value = false;
        debugPrint('this is response body ==>${res.data}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response extra ==> ${res.extra}');
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed => ${res.statusCode} - ${res.data}"
        );
      }

    }
    on FormatException catch(e, stackTrace){
      isLoading.value = false;
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "$e"
      );
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
    }
    on HttpException {
      isLoading.value = false;
      baseService.handleError(const HttpException("Something went wrong"));
      showMySnackBar(
        context: context,
        backgroundColor: AppColor.redColor,
        message: "connection timed out"
      );
    }
    on Exception catch(e, stackTrace){
      // Handle errors
      print('Error occurred: $e \n$stackTrace');
    }
  }

  
  //Log out / Sign Out from Google
  Future<GoogleSignInAccount?> signOutWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    return googleUser;
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
      http.Response res = await baseService.httpPutAuth(endPoint: "send-reset-password-otp", body: body);
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
      http.Response res = await baseService.httpPutAuth(endPoint: "reset-password", body: body);
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