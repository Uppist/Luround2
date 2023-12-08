import 'package:get/get.dart' as getx;
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/transaction_successful_screen.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;







class AccViewerService extends getx.GetxController {


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

  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$userEmail",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        return response.map((e) => UserServiceModel.fromJson(e)).toList();
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw HttpException("$e");
    
    }
  }

  /////[GET A SINGLE SERVICE]////// I.E, FOR SEARCHING OR FILTERING
  Future<UserServiceModel> getSingleService({
    required String serviceId,
  }) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/edit?serviceId=$serviceId",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user service fetched by id successfully!!");
        //decode the response body here
        UserServiceModel userServiceModel = UserServiceModel.fromJson(jsonDecode(res.body));
        return userServiceModel;
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw HttpException("$e");
    
    }
  }


  /////[BOOK USER SERVICE]///// i.e, book and pay for a user's service
  Future<dynamic> bookUserService({
    required BuildContext context,
    required String name,
    required String email,
    required String service_name,
    ////
    required String serviceId,
    required String phone_number,
    required String appointment_type,
    required String date,
    required String time,
    required String duration,
    required String message,
    required String location
  }) async {
    isLoading.value = true;

    var body = {
      "name": name,
      "email": email,
      "service_name": service_name,
      //the above was added by me
      "phone_number": phone_number,
      "appointment_type": appointment_type,
      "date": date,
      "time": time,
      "duration": duration,
      "message": message,
      "location": location
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "booking/book-service?serviceId=$serviceId", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("luround user got booked succesfully");
        //await payWithFlutterwave()
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "you've successfully booked this service"
        ).whenComplete(() => getx.Get.to(() => TransactionSuccesscreen()));
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
          message: "failed to book service"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


}