import 'dart:async';

import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/user_profile/review_response.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;







class AccViewerProfileService extends getx.GetxController {


  var baseService = getx.Get.put(BaseService());
  
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var userEmail = LocalStorage.getUseremail();



  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlLink({required String link}) async{
    //String myPhoneNumber = "+234 07040571471";
    //Uri uri = Uri.parse(myPhoneNumber);
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

  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlEmail({required String email}) async{
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
    }

    Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Enter your mail subject',
        'body': 'Enter you message'
      })
    );
    if(await launcher.canLaunchUrl(emailUri)) {
      launcher.launchUrl(
        emailUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $emailUri');
    }
  }

  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlPhone({required String phone}) async{

    Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if(await launcher.canLaunchUrl(phoneUri)) {
      launcher.launchUrl(
        phoneUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $phoneUri');
    }
  }



  /////[GET USER PROFILE DETAILS]/////
  // Create a StreamController to emit the results
  //final _userProfileStreamController = StreamController<UserModel>();

  // Getter to expose the stream to external widgets
  //Stream<UserModel> get userProfileStream => _userProfileStreamController.stream;

  Future<UserModel> getUserProfileDetails({
    required String userName
  }) async {
    isLoading.value = true;
    print("custom name: $userName");
    //var uri = Uri.https('luround.onrender.com','api/v1/profile/get-user-profile-link?url=${fullURL}');
    //print("url: $uri");
    try {   // await http.get(uri);
      http.Response res = await baseService.httpGet(endPoint: "profile/get-user-profile-link?url=https://www.luround.com/profile/$userName",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        //decode the response body here
        UserModel userModel = UserModel.fromJson(jsonDecode(res.body));
        await LocalStorage.saveUserID(userModel.id);
        // Emit the user profile using the stream controller
        //_userProfileStreamController.add(userModel);
        ////////////
        return userModel;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        throw Exception('Failed to load user data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw HttpException("$e");
    
    }
  }


  ////Calculate the total rating of a user
  String getUserTotalRatings({required double ratings, required int length}) {
    double totalRating = (ratings * length)/length;
    return totalRating.toString();
  }


  /////[GET LOGGED-IN USER'S REVIEW'S LIST]//////  remove service id
  Future<List<ReviewResponse>> getUserReviews() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "reviews/service-reviews?serviceId=6572c7f714b0a81bd0de3c88",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user reviews gotten successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        return response.map((e) => ReviewResponse.fromJson(e)).toList();
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user reviews');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }


  ////[TO MAKE AN EXTERNAL USER WRITE REVIEW]//////// remove service
  Future<void> addReview({
    required BuildContext context,
    required double rating,
    required String comment,
  }) async {

    isLoading.value = true;

    var body = {
      "rating": rating,
      "comment": comment
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "reviews/add-review?serviceId=6572c7f714b0a81bd0de3c88", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user about updated successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "updated successfully"
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
          message: "failed to update"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }





  @override
  void dispose() {
    // TODO: implement dispose
    //_userProfileStreamController.close();
    super.dispose();
  }
}