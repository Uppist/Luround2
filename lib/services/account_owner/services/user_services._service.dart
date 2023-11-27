import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;







class AccOwnerServicePageService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ServicesController());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();


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
  Future<ParentServiceModel> getUserServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?email=$email",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        ParentServiceModel userServiceModel = ParentServiceModel.fromJson(jsonDecode(res.body));
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


  /////[CREATE A SERVICE FOR LOGGED-IN USER]//////
  Future<void> createUserService({
    required String service_name,
    required String description,
    required List<dynamic> links,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required String time,
    required String available_days,
    //required String service_type,
    required String date
    
    }) async {

    isLoading.value = true;

    var body = {
      "email": email,
      "service_name": service_name,
      "description": description,
      "links": links,
      "service_charge_in_person": service_charge_in_person,
      "service_charge_virtual": service_charge_virtual,
      "duration": duration,
      "time": time,
      'available_days': available_days,
      //"service_type": service_type,
      "date": date
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "services/create", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user service created succesfully");
        LuroundSnackBar.successSnackBar(message: "Your service has been created.");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.errorSnackBar(message: "failed to create service profile");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  

  /////[UPDATE/EDIT AN EXISTING SERVICE OF LOGGED-IN USER]//////
  Future<void> updateUserService({
    required String serviceId,
    required String service_name,
    required String description,
    required List<dynamic> links,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required String time,
    required String date,
    required String available_days,
    
    }) async {

    isLoading.value = true;

    var body = {
      "email": email,
      "service_name": service_name,
      "description": description,
      "links": links,
      "service_charge_in_person": service_charge_in_person,
      "service_charge_virtual": service_charge_virtual,
      "duration": duration,
      "time": time,
      "date": date,
      'available_days': available_days,
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "services/edit?serviceId=$serviceId", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user service updated by id succesfully");
        LuroundSnackBar.successSnackBar(message: "service updated");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.errorSnackBar(message: "failed to update service");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }
  


  /////[DELETE A SERVICE OF A LOGGED-IN USER]//////
  Future<void> deleteUserService({
    required String id,
  }) async {

    isLoading.value = true;

    var body = {
      "id": id,
    };

    try {
      http.Response res = await baseService.httpDelete(endPoint: "services/delete?id=$id", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user service deleted by id succesfully");
        LuroundSnackBar.successSnackBar(message: "service deleted");
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        LuroundSnackBar.errorSnackBar(message: "failed to delete profile");
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }




  @override
  void onInit() {
    getUserServices();
    super.onInit();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

}