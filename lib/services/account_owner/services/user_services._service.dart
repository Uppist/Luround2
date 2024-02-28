import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/services/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:dio/dio.dart' as dio;
import 'package:socket_io_client/socket_io_client.dart' as IO;







class AccOwnerServicePageService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ServicesController());
  
  var isLoading = false.obs;
  var isServiceCRLoading = false.obs;
  var isServiceEDLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();
  var token = LocalStorage.getToken();

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
  /*Future<List<UserServiceModel>> getUserServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services",);
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
      throw Exception("error: $e");
    
    }
  }*/

  
  IO.Socket? socket;
  Stream<List<UserServiceModel>> getUserServices() async* {
    try {
      List<UserServiceModel>  servicesList = [];
      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-bookings" event after connecting
        socket!.emit('user-service');
      });

      socket!.on('user-service', (data) {
        // Handle data received for "user-bookings" event
        //print('Received user-services event: $data');
        // Extract the "details" list from the first map
        List<dynamic> response = jsonDecode(data);
        var finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        servicesList.clear();
        servicesList.addAll(finalResult);
        print("user services list: $servicesList");
      });



      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));

      yield servicesList;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
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
    required BuildContext context,
    required String service_name,
    required String description,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required String time,
    required String available_days,
    //required String service_type,
    required List<dynamic> links,
    required List<dynamic> available_time_list,
    required String date
    
    }) async {

    isServiceCRLoading.value = true;

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
      "date": date,
      "available_time": available_time_list,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "services/create", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isServiceCRLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("user service created succesfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "Your service has been created successfully"
        );
      } 
      else {
        isServiceCRLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to create service: ${res.statusCode} || ${res.body}"
        );
      }
    } 
    catch (e) {
      isServiceCRLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong: $e");
    }
  }
  

  /////[UPDATE/EDIT AN EXISTING SERVICE OF LOGGED-IN USER]//////
  Future<void> updateUserService({
    required BuildContext context,
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
    required List<dynamic> available_time,
    
    }) async {

    isServiceEDLoading.value = true;

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
      "available_time": available_time,
      //"service_type": service_type
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "services/edit?serviceId=$serviceId", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isServiceEDLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user service updated by id succesfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "service updated successfully"
        );
      } 
      else {
        isServiceEDLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to update service: ${res.statusCode} || ${res.body} "
        );
      }
    } 
    catch (e) {
      isServiceEDLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong $e");
    }
  }
  


  /////[DELETE A SERVICE OF A LOGGED-IN USER]//////
  Future<void> deleteUserService({
    required BuildContext context,
    required String id,
    //service provider details below
    required String userId,
    required String email,
    required String displayName,
  }) async {

    isLoading.value = true;

    var body = {
      "_id": id,
      "service_provider_details": {
        "userId": userId,
        "email": email,
        "displayName": displayName,
      }
    };

    try {
      http.Response res = await baseService.httpDelete(endPoint: "services/delete?serviceId=$id", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user service deleted by id succesfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "service deleted"
        );
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
          message: "failed to delete service: ${res.statusCode} || ${res.body}"
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