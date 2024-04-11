import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
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




  //for main service screen and the service screen tab
  final TextEditingController searchServiceController = TextEditingController();
  //final searchServicesList = <UserServiceModel>[].obs;
  final filterSearchServicesList = <UserServiceModel>[].obs;
  int activeTabIndex = 0;
  

   


  /////[GET LOGGED-IN USER'S REGULAR SERVICES LIST]//////
  //Method to pass in the search textfield
  Future<void> filterRegularServices(String query) async {
    if (query.isEmpty) {
      filterSearchServicesList.clear();
      filterSearchServicesList.addAll(servicesList);
      print("when query is empty: $filterSearchServicesList");
    } 
    else {
      filterSearchServicesList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filterSearchServicesList.addAll(
        servicesList
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query //.contains(query)
        .toList());
      print("when query is not empty: $filterSearchServicesList");
    }
  }
  //
  final servicesList = <UserServiceModel>[].obs;
  Future<List<UserServiceModel>> getUserRegularServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint:"services/get-services?service_type=Regular",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        var finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.service_provider_details['service_name'].toString().compareTo(b.service_provider_details['service_name'].toString()));
        servicesList.clear();
        servicesList.addAll(finalResult);
        print("user services list: $finalResult");

        return finalResult;
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
  }


  /////[GET LOGGED-IN USER'S PACKAGE SERVICES LIST]//////
  //Method to pass in the search textfield
  Future<void> filterPackageServices(String query) async {
    if (query.isEmpty) {
      filterSearchServicesList.clear();
      filterSearchServicesList.addAll(servicesListPackage);
      print("when query is empty: $filterSearchServicesList");
    } 
    else {
      filterSearchServicesList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filterSearchServicesList.addAll(
        servicesListPackage
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query //.contains(query)
        .toList());
      print("when query is not empty: $filterSearchServicesList");
    }
  }
  //
  final servicesListPackage = <UserServiceModel>[].obs;
  Future<List<UserServiceModel>> getUserPackageServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?service_type=Package",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        var finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.service_provider_details['service_name'].toString().compareTo(b.service_provider_details['service_name'].toString()));
        servicesList.clear();
        servicesList.addAll(finalResult);
        print("user services list: $finalResult");

        return finalResult;
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
  }

  /////[GET LOGGED-IN USER'S PACKAGE SERVICES LIST]//////
  //Method to pass in the search textfield
  Future<void> filterProgramServices(String query) async {
    if (query.isEmpty) {
      filterSearchServicesList.clear();
      filterSearchServicesList.addAll(servicesListProgram);
      print("when query is empty: $filterSearchServicesList");
    } 
    else {
      filterSearchServicesList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filterSearchServicesList.addAll(
        servicesListProgram
        .where((user) => user.service_name.toLowerCase().contains(query.toLowerCase())) // == query //.contains(query)
        .toList());
      print("when query is not empty: $filterSearchServicesList");
    }
  }
  //
  final servicesListProgram = <UserServiceModel>[].obs;
  Future<List<UserServiceModel>> getUserProgramServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?service_type=Program",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        var finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.service_provider_details['service_name'].toString().compareTo(b.service_provider_details['service_name'].toString()));
        servicesList.clear();
        servicesList.addAll(finalResult);
        print("user services list: $finalResult");

        return finalResult;
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
  }


  /*IO.Socket? socket;
  Stream<List<UserServiceModel>> getUserServicesSocket() async* {
    try {
      List<UserServiceModel> servicesListSS = [];
      socket = IO.io(baseService.socketUrl, <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
        "extraHeaders": {HttpHeaders.authorizationHeader: "Bearer $token"}
      });
      socket!.connect();

      socket!.onConnect((_) {
        print('Connection established');
        // Subscribe to the "user-bookings" event after connecting
        socket!.emit('user-services');
      });

      socket!.on('user-services', (data) {
        print("list: $data");
        //get the data
        List<dynamic> response = data; //jsonDecode(data);
        var finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.service_provider_details['service_name'].toString().compareTo(b.service_provider_details['service_name'].toString()));
        servicesListSS.clear();
        servicesListSS.addAll(finalResult);
        print("user socket services list: $servicesList");
      });



      socket!.onDisconnect((e) => print('Connection Disconnected: $e'));
      socket!.onConnectError((err) => print('Connection Error: $err'));
      socket!.onError((err) => print("Error: $err"));
      
      //return the list
      yield servicesListSS;
    }
    on SocketException catch(e, stacktrace) {
      throw SocketException("socket exception: $e => $stacktrace");
    }

    on WebSocketException catch(e, stacktrace) {
      throw SocketException("websocket exception: $e => $stacktrace");
    }

  }*/


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
      throw Exception("$e");
    
    }
  }


  /////[CREATE A SERVICE FOR LOGGED-IN USER]//////
  Future<void> createRegularService({
    required BuildContext context,
    required String service_name,
    required String description,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required String time,
    required String available_days,
    required List<dynamic> links,
    required List<dynamic> available_time_list,
    required String date,

    //NEW UPDATE
    required String service_model,
    required String service_timeline,
    
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
      "date": date,
      "available_time": available_time_list,

      //NEW UPDATE
      "service_type": 'Regular',
      "service_model": service_model,
      "service_timeline": service_timeline
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "services/create", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isServiceCRLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("user service created successfully");
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

  Future<void> createPackageService({
    required BuildContext context,
    required String service_name,
    required String description,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required List<dynamic> links,

    //NEW UPDATE
    required String service_recurrence,
    required String service_timeline,
    required List<dynamic> timeline_days,
    required String start_date,
    required String end_date,
    required String start_time,
    required String end_time
    
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

      //NEW UPDATE
      "service_type": 'Package',
      "service_recurrence": service_recurrence,
      "service_timeline": service_timeline,
      "timeline_days": timeline_days,
      "start_date": start_date,
      "end_date": end_date,
      "start_time": start_time,
      "end_time": end_time
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "services/create", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isServiceCRLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("user service created successfully");
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

  Future<void> createProgramService({
    required BuildContext context,
    required String service_name,
    required String description,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required List<dynamic> links,

    //NEW UPDATE
    required String service_recurrence,
    required String service_timeline,
    required List<dynamic> timeline_days,
    required String start_date,
    required String end_date,
    required String start_time,
    required String end_time,
    required int max_number_of_participants,
    
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

      //NEW UPDATE
      "service_type": 'Package',
      "service_recurrence": service_recurrence,
      "service_timeline": service_timeline,
      "timeline_days": timeline_days,
      "start_date": start_date,
      "end_date": end_date,
      "start_time": start_time,
      "end_time": end_time,
      "max_number_of_participants": max_number_of_participants
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "services/create", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isServiceCRLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("user service created successfully");
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
  Future<void> updateRegularService({
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

    //NEW UPDATE
    required String service_model,
    required String service_timeline,

    
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

      //NEW UPDATE
      "service_type": 'Regular',
      "service_model": service_model,
      "service_timeline": service_timeline,
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

  Future<void> updatePackageService({
    required BuildContext context,
    required String serviceId,
    required String service_name,
    required String description,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required List<dynamic> links,

    //NEW UPDATE
    required String service_recurrence,
    required String service_timeline,
    required List<dynamic> timeline_days,
    required String start_date,
    required String end_date,
    required String start_time,
    required String end_time

    
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

      //NEW UPDATE
      "service_type": 'Package',
      "service_recurrence": service_recurrence,
      "service_timeline": service_timeline,
      "timeline_days": timeline_days,
      "start_date": start_date,
      "end_date": end_date,
      "start_time": start_time,
      "end_time": end_time
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

  Future<void> updateProgramService({
    required BuildContext context,
    required String serviceId,
    required String service_name,
    required String description,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required String duration,
    required List<dynamic> links,

    //NEW UPDATE
    required String service_recurrence,
    required String service_timeline,
    required List<dynamic> timeline_days,
    required String start_date,
    required String end_date,
    required String start_time,
    required String end_time,
    required int max_number_of_participants,

    
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

      //NEW UPDATE
      "service_type": 'Package',
      "service_recurrence": service_recurrence,
      "service_timeline": service_timeline,
      "timeline_days": timeline_days,
      "start_date": start_date,
      "end_date": end_date,
      "start_time": start_time,
      "end_time": end_time,
      "max_number_of_participants": max_number_of_participants
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
      throw Exception("Something went wrong");
    }
  }












  @override
  void onInit() {
    super.onInit();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    //socket!.dispose();
    searchServiceController.dispose();
    super.dispose();
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

}