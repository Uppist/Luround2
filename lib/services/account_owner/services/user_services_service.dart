import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/models/account_owner/ui/dayselection_model.dart';
import 'package:luround/models/account_owner/ui/textcontroller_model.dart';
import 'package:luround/models/account_owner/user_services/service_insight.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:dio/dio.dart' as dio;
import 'package:socket_io_client/socket_io_client.dart' as IO;











class AccOwnerServicePageService extends getx.GetxController {

  final baseService = getx.Get.put(BaseService());
  final controller = getx.Get.put(ServicesController());
  var isLoading = false.obs;
  var hasError = false.obs;
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

  final TextEditingController searchOneoffController = TextEditingController();
  final TextEditingController searchRetainerController = TextEditingController();
  final TextEditingController searchProgramController = TextEditingController();
  final TextEditingController searchEventController = TextEditingController();
  
  //final filterServicesList = <UserServiceModel>[].obs;
  final filterOneoffList = <UserServiceModel>[].obs;
  final filterRetainerList = <UserServiceModel>[].obs;
  final filterProgramList = <UserServiceModel>[].obs;
  final filterEventsList = <UserServiceModel>[].obs;

  int activeTabIndex = 0;


  
 
   


  /////[GET LOGGED-IN USER'S ONE-OFF SERVICES LIST]//////
  //Method to pass in the search textfield
  //
  final servicesList = <UserServiceModel>[].obs;
  Future<void> filterOneOffServices(String query) async {
    if (query.isEmpty) {
      filterOneoffList.clear();
      filterOneoffList.addAll(servicesList);
      print("when query is empty: $filterOneoffList");
    } 
    else {
      filterOneoffList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filterOneoffList.addAll(
        servicesList
        .where((user) => user.serviceName.toLowerCase().contains(query.toLowerCase())) // == query //.contains(query)
        .toList());
      print("when query is not empty: $filterOneoffList");
    }
    update();
  }

  Future<List<UserServiceModel>> getUserOneOffServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint:"services/get-services?service_type=One-Off",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        final finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.serviceName.toString().compareTo(b.serviceName.toString()));
        //log('$servicesList');
        servicesList.clear();
        servicesList.addAll(finalResult);
        log('$servicesList');
        print("user one-off services list: $finalResult");

        return servicesList;
      }
      else {
        isLoading.value = false;
        hasError.value = true;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      hasError.value = true;
      //debugPrint("Error net: $e");
      throw Exception("error: $e");
    
    }
  }


  /////[GET LOGGED-IN USER'S RETAINER SERVICES LIST]//////
  //Method to pass in the search textfield
  //
  final servicesListRetainer = <UserServiceModel>[].obs;
  Future<void> filterRetainerServices(String query) async {
    if (query.isEmpty) {
      filterRetainerList.clear();
      filterRetainerList.addAll(servicesListRetainer);
      print("when query is empty: $filterRetainerList");
    } 
    else {
      filterRetainerList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filterRetainerList.addAll(
        servicesListRetainer
        .where((user) => user.serviceName.toLowerCase().contains(query.toLowerCase())) // == query //.contains(query)
        .toList());
      print("when query is not empty: $filterRetainerList");
    }
    update();
  }

  Future<List<UserServiceModel>> getUserRetainerServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?service_type=Retainer",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        var finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.serviceName.toString().compareTo(b.serviceName.toString()));
        servicesListRetainer.clear();
        servicesListRetainer.addAll(finalResult);
        //filterRetainerList.clear();
        //filterRetainerList.addAll(finalResult);
        print("user retainer services list: $finalResult");

        return servicesListRetainer;
      }
      else {
        isLoading.value = false;
        hasError.value = true;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      hasError.value = true;
      //debugPrint("Error net: $e");
      throw Exception("error: $e"); 
    }
  }

  /////[GET LOGGED-IN USER'S PROGRAM SERVICES LIST]//////
  //Method to pass in the search textfield
  //
  final servicesListProgram = <UserServiceModel>[].obs;
  Future<void> filterProgramServices(String query) async {
    if (query.isEmpty) {
      filterProgramList.clear();
      filterProgramList.addAll(servicesListProgram);
      print("when query is empty: $filterProgramList");
    } 
    else {
      filterProgramList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filterProgramList.addAll(
        servicesListProgram
        .where((user) => user.serviceName.toLowerCase().contains(query.toLowerCase())) // == query //.contains(query)
        .toList());
      print("when query is not empty: $filterProgramList");
    }
    update();
  }
  
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
        finalResult.sort((a, b) => a.serviceName.toString().compareTo(b.serviceName.toString()));
        servicesListProgram.clear();
        servicesListProgram.addAll(finalResult);
        //filterProgramList.clear();
        //filterProgramList.addAll(finalResult);
        print("user program services list: $finalResult");

        return servicesListProgram;
      }
      else {
        isLoading.value = false;
        hasError.value = true;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      hasError.value = true;
      //debugPrint("Error net: $e");
      throw Exception("error: $e");
    }
  }

  /////[GET LOGGED-IN USER'S EVENT SERVICES LIST]//////
  //Method to pass in the search textfield
  //
  final servicesListEvent = <UserServiceModel>[].obs;
  Future<void> filterEventServices(String query) async {
    if (query.isEmpty) {
      filterEventsList.clear();
      filterEventsList.addAll(servicesListEvent);
      print("when query is empty: $filterEventsList");
    } 
    else {
      filterEventsList.clear(); // Clear the previous filtered list
      // Use addAll to add the filtered items to the list
      filterEventsList.addAll(
        servicesListEvent
        .where((user) => user.serviceName.toLowerCase().contains(query.toLowerCase())) // == query //.contains(query)
        .toList());
      print("when query is not empty: $filterEventsList");
    }
    update();
  }
  
  Future<List<UserServiceModel>> getUserEventServices() async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-services?service_type=Event",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user services fetched successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        final finalResult = response.map((e) => UserServiceModel.fromJson(e)).toList();
        finalResult.sort((a, b) => a.serviceName.toString().compareTo(b.serviceName.toString()));
        servicesListEvent.clear();
        servicesListEvent.addAll(finalResult);
        //filterEventsList.clear();
        //filterEventsList.addAll(finalResult);
        print("user event services list: $finalResult");

        return servicesListEvent;
      }
      else {
        isLoading.value = false;
        hasError.value = true;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } 
    catch (e) {
      isLoading.value = false;
      hasError.value = true;
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

  /////[GET A SERVICE INSIGHT]////// I.E, FOR FETCHING DATA ANALYTICS ABOUT A PARTICULAR SERVICE
  final serviceInsightList = <InsightInfo>[].obs;
  final filterServiceInsightList = <InsightInfo>[].obs;

  //FILTER FUNCTIONALITIES////////
  Future<void> filterInsightByPastDate() async{
    // Clear the filteredList so new values can come i n 
    filterServiceInsightList.clear();

    // Use the search query to filter the items
    filterServiceInsightList.addAll(
      serviceInsightList.where((item) {
        String server_date = convertServerTimeToDate(0);  //item.bookings_list[index]['createdAt']
        DateTime convertedDate = convertStringToDateTime(server_date);
        print('Converted Date: $convertedDate');
        // Check if the date is in the past
        if (isDateInPast(convertedDate)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("All time Service Insight List: $filterServiceInsightList");
  }

  Future<void> filterInsightByToday() async{
    DateTime today = DateTime.now();
    //DateTime todayAgo = today.subtract(Duration(days: 0));

    // Clear the filteredList so new values can come i n 
    filterServiceInsightList.clear();

    // Use the search query to filter the items
    filterServiceInsightList.addAll(
  
      serviceInsightList.where((item) {
        String serverDate = convertServerTimeToDate(0); //item.serviceDetails.createdAt
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is today
        if (convertedDate.isAfter(today.subtract(Duration(days: 1)))) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );

    print("booking List from today: $filterServiceInsightList");
  }

  Future<void> filterInsightByYesterday() async{
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));

    // Clear the filteredList so new values can come i n 
    filterServiceInsightList.clear();

    // Use the search query to filter the items
    filterServiceInsightList.addAll(
  
      serviceInsightList.where((item) {
        String serverDate = convertServerTimeToDate(0); //item.serviceDetails.createdAt
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is exactly equal to yesterday
        // return convertedDate.isAtSameMomentAs(yesterday);
        // Check if the date is within yesterday
        return convertedDate.year == yesterday.year &&
          convertedDate.month == yesterday.month &&
          convertedDate.day == yesterday.day;
        }),
      );

    print("Bookings List from yesterday: $filterServiceInsightList");
  }


  Future<void> filterInsightByLastSevenDays() async{
    DateTime today = DateTime.now();
    DateTime sevenDaysAgo = today.subtract(Duration(days: 7));

    // Clear the filteredList so new values can come i n 
    filterServiceInsightList.clear();

    // Use the search query to filter the items
    filterServiceInsightList.addAll(
      serviceInsightList.where((item) {
        String serverDate = convertServerTimeToDate(0); //item.serviceDetails.createdAt
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is within the last seven days
        if (convertedDate.isAfter(sevenDaysAgo)) {
          return true; // Include the item in the filtered list
        }

        return false; // If not found in any detail, exclude the item
      }),
    );

    print("bookings List from the last seven days: $serviceInsightList");
  }

  Future<void> filterInsightByLastThirtyDays() async{
    DateTime today = DateTime.now();
    DateTime thirtyDaysAgo = today.subtract(Duration(days: 30));

    // Clear the filteredList so new values can come i n 
    filterServiceInsightList.clear();

    // Use the search query to filter the items
    filterServiceInsightList.addAll(
      serviceInsightList.where((item) {
        String serverDate = convertServerTimeToDate(0);  //item.serviceDetails.createdAt
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is within the last seven days
        if (convertedDate.isAfter(thirtyDaysAgo)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );

    print("booking List from the last thirty days: $filterServiceInsightList");
  }
  ////////////////////////////////////

  Future<List<InsightInfo>> getServiceInsight({
    required String serviceId,
    required RxInt booking_count,
  }) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(
        endPoint: "insights/get?service_id=$serviceId",
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user service insight fetched by id successfully!!");
        
        final List<dynamic> response = jsonDecode(res.body);

        int result = response[0]['booking_count'];
        booking_count.value = result;

        List<dynamic> result2 = response[1]['bookings'];
        final finalResult = result2.map((e) => InsightInfo.fromJson(e)).toList();
        //finalResult.sort((a, b) => a.bookings_list[index].customer_name .toString().compareTo(b.bookings_list[index].customer_name.toString()));
        serviceInsightList.clear();
        serviceInsightList.addAll(finalResult);

        //decode the response body here
        //UserServiceInsightModel userServiceInsightModel = UserServiceInsightModel.fromJson(jsonDecode(res.body));
        return serviceInsightList;
      }
      else {
        isLoading.value = false;
        hasError.value = true;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load this service insight');
      }
    } 
    catch (e) {
      isLoading.value = false;
      hasError.value = true;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }

  
  /////[SUSPEND A SERVICE OF A LOGGED-IN USER]//////
  Future<void> suspendUserService({
    required BuildContext context,
    required String serviceId,
  }) async {

    isLoading.value = true;

    var body = {};
    //acts as both a suspension and unsuspension api
    try {
      http.Response res = await baseService.httpPut(endPoint: "services/suspend-user-service?service_Id=$serviceId", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("user service suspended by id succesfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "service suspended"
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
          message: "failed to suspend service: ${res.statusCode} || ${res.body}"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }


  /////[CREATE A SERVICE FOR LOGGED-IN USER]//////
  Future<void> createOneOffService({
    required BuildContext context,
    required String service_name,
    required String description,
    required String virtual_meeting_link,
    required List<PricingInfo> pricing,
    required List<DaySelectionModel> availability_schedule,
    
    }) async {

    isServiceCRLoading.value = true;

    try {
      
      //PRICING LOOP
      final List<dynamic> pricingList = [];
      for (PricingInfo data in pricing) {
        final String time_allocation = data.time_allocation;
        final String virtual = data.virtual_pricing;
        final String in_person = data.in_person_pricing;

        // Check if required fields are not empty or undefined
        if (time_allocation.isNotEmpty && virtual.isNotEmpty && in_person.isNotEmpty) {
          final Map<String, dynamic> map = {
            "time_allocation": time_allocation,
            "virtual_pricing": virtual,
            "in_person_pricing": in_person,
          };
          pricingList.add(map);
          log("pricing_list: $pricingList");

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceCRLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
          //log("empty list");
        }
      }

      //DaySelectionModel LOOP
      final List<dynamic> availability_scheduleList = [];
      for (DaySelectionModel data in availability_schedule) {
        final String day = data.day;
        final String from_time = data.startTime!;
        final String to_time = data.stopTime!;

        // Check if required fields are not empty or undefined
        if (day.isNotEmpty && from_time.isNotEmpty && to_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "availability_day": day,
            "from_time": from_time,
            "to_time": to_time,
          };
          availability_scheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceCRLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
          //log('empty list');
        }
      }


      var body = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "One-Off",
        "virtual_meeting_link": virtual_meeting_link,
        "pricing": pricingList,
        "availability_schedule": availability_scheduleList
      };

      http.Response res = await baseService.httpPost(endPoint: "services/create", body: body);
      
      if (res.statusCode == 200 || res.statusCode == 201) {
        isServiceCRLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("One-Off service created successfully");
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

  Future<void> createRetainerService({
    required BuildContext context,
    required String service_name,
    required String description,
    required String virtual_meeting_link,
    required List<PricingInfo> pricing,
    required List<DaySelectionModel> availability_schedule,
    required List<dynamic> coreFeatures,
  
    
    }) async {

    isServiceCRLoading.value = true;

    try {

      //PRICING LOOP
      final List<dynamic> pricingList = [];
      for (PricingInfo data in pricing) {
        final String time_allocation = data.time_allocation;
        final String virtual = data.virtual_pricing;
        final String in_person = data.in_person_pricing;

        // Check if required fields are not empty or undefined
        if (time_allocation.isNotEmpty && virtual.isNotEmpty && in_person.isNotEmpty) {
          final Map<String, dynamic> map = {
            "time_allocation": time_allocation,
            "virtual_pricing": virtual,
            "in_person_pricing": in_person,
          };
          pricingList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceCRLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }

      //DaySelectionModel LOOP
      final List<dynamic> availability_scheduleList = [];
      for (DaySelectionModel data in availability_schedule) {
        final String day = data.day;
        final String from_time = data.startTime!;
        final String to_time = data.stopTime!;

        // Check if required fields are not empty or undefined
        if (day.isNotEmpty && from_time.isNotEmpty && to_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "availability_day": day,
            "from_time": from_time,
            "to_time": to_time,
          };
          availability_scheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceCRLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }


      var body = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "Retainer",
        "virtual_meeting_link": virtual_meeting_link,
        "pricing": pricingList,
        "availability_schedule": availability_scheduleList,
        "core_features": coreFeatures,
      };


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
    required String start_date,
    required String end_date,
    required String duration,
    required String program_recurrence,
    required int max_number_of_participants,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required List<DaySelectionModel> availability_schedule,
    }) async {

    isServiceCRLoading.value = true;

    try {

      //DaySelectionModel LOOP
      final List<dynamic> availability_scheduleList = [];
      for (DaySelectionModel data in availability_schedule) {
        final String day = data.day;
        final String from_time = data.startTime!;
        final String to_time = data.stopTime!;

        // Check if required fields are not empty or undefined
        if (day.isNotEmpty && from_time.isNotEmpty && to_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "availability_day": day,
            "from_time": from_time,
            "to_time": to_time,
          };
          availability_scheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceCRLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }

      var body = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "Program",
        "start_date": start_date,
        "end_date": end_date,
        'duration': duration,
        "service_recurrence": program_recurrence,
        "max_number_of_participants": max_number_of_participants,
        "in_person_event_fee": service_charge_in_person,
        "virtual_event_fee": service_charge_virtual,
        "availability_schedule": availability_scheduleList,
      };


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

  Future<void> createEventService({
    required BuildContext context,
    required String service_name,
    required String description,
    required String virtual_meeting_link,
    required String physical_location,
    required String event_schedule,
    required String date,
    required String start_time,
    required String end_time,
    required String inpersonFee,
    required String virtualFee,
    required List<Map<String, dynamic>> schedule,

    
    }) async {

    isServiceCRLoading.value = true;

    try {

      //EVENT DATA LOOP
      final List<dynamic> eventScheduleList = [];
      for (Map<String, dynamic> data in schedule) {
        final String date = data['date'];
        final String start_time = data['start_time'];
        final String stop_time = data['stop_time'];

        // Check if required fields are not empty or undefined
        if (date.isNotEmpty && start_time.isNotEmpty && stop_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "date": date,
            "time": start_time,
            "end_time": stop_time,
          };
          eventScheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          /*isServiceCRLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request*/
          log('empty list');
        }
      }

      
      var body1 = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "Event",
        "virtual_meeting_link": virtual_meeting_link,
        "physical_location": physical_location,
        "event_type": event_schedule,

        "date": date,
        "start_time": start_time,
        "end_time": end_time,
        "in_person_event_fee": inpersonFee,
        "virtual_event_fee": virtualFee,
      };

      var body2 = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "Event",
        "virtual_meeting_link": virtual_meeting_link,
        "physical_location": physical_location,
        "event_type": event_schedule,
        "in_person_event_fee": inpersonFee,
        "virtual_event_fee": virtualFee,
        "event_schedule": eventScheduleList,
      };


      http.Response res = await baseService.httpPost(
        endPoint: "services/create", 
        body: event_schedule == "Single date" ? body1 : body2
      );
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
  Future<void> updateOneOffService({
    required BuildContext context,
    required String serviceId,
    required String service_name,
    required String description,
    required String virtual_meeting_link,
    required List<PricingInfo> pricing,
    required List<DaySelectionModel> availability_schedule,

    
    }) async {

    isServiceEDLoading.value = true;

    try {

      //PRICING LOOP
      final List<dynamic> pricingList = [];
      for (PricingInfo data in pricing) {
        final String time_allocation = data.time_allocation;
        final String virtual = data.virtual_pricing;
        final String in_person = data.in_person_pricing;

        // Check if required fields are not empty or undefined
        if (time_allocation.isNotEmpty && virtual.isNotEmpty && in_person.isNotEmpty) {
          final Map<String, dynamic> map = {
            "time_allocation": time_allocation,
            "virtual_pricing": virtual,
            "in_person_pricing": in_person,
          };
          pricingList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceEDLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }

      //DaySelectionModel LOOP
      final List<dynamic> availability_scheduleList = [];
      for (DaySelectionModel data in availability_schedule) {
        final String day = data.day;
        final String from_time = data.startTime!;
        final String to_time = data.stopTime!;

        // Check if required fields are not empty or undefined
        if (day.isNotEmpty && from_time.isNotEmpty && to_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "availability_day": day,
            "from_time": from_time,
            "to_time": to_time,
          };
          availability_scheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceEDLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }


      var body = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "One-Off",
        "virtual_meeting_link": virtual_meeting_link,
        "pricing": pricingList,
        "availability_schedule": availability_scheduleList
      };

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

  Future<void> updateRetainerService({
    required BuildContext context,
    required String serviceId,
    required String service_name,
    required String description,
    required String virtual_meeting_link,
    required List<PricingInfo> pricing,
    required List<DaySelectionModel> availability_schedule,
    required List<String> coreFeatures,

    
    }) async {

    isServiceEDLoading.value = true;

    try {

      //PRICING LOOP
      final List<dynamic> pricingList = [];
      for (PricingInfo data in pricing) {
        final String time_allocation = data.time_allocation;
        final String virtual = data.virtual_pricing;
        final String in_person = data.in_person_pricing;

        // Check if required fields are not empty or undefined
        if (time_allocation.isNotEmpty && virtual.isNotEmpty && in_person.isNotEmpty) {
          final Map<String, dynamic> map = {
            "time_allocation": time_allocation,
            "virtual_pricing": virtual,
            "in_person_pricing": in_person,
          };
          pricingList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceEDLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }

      //DaySelectionModel LOOP
      final List<dynamic> availability_scheduleList = [];
      for (DaySelectionModel data in availability_schedule) {
        final String day = data.day;
        final String from_time = data.startTime!;
        final String to_time = data.stopTime!;

        // Check if required fields are not empty or undefined
        if (day.isNotEmpty && from_time.isNotEmpty && to_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "availability_day": day,
            "from_time": from_time,
            "to_time": to_time,
          };
          availability_scheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceEDLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }


      var body = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "Retainer",
        "virtual_meeting_link": virtual_meeting_link,
        "pricing": pricingList,
        "availability_schedule": availability_scheduleList,
        "core_features": coreFeatures,
      };

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
    required String start_date,
    required String end_date,
    required String duration,
    required String program_recurrence,
    required int max_number_of_participants,
    required String service_charge_in_person,
    required String service_charge_virtual,
    required List<DaySelectionModel> availability_schedule,
    
    }) async {

    isServiceEDLoading.value = true;

    try {

      //DaySelectionModel LOOP
      final List<dynamic> availability_scheduleList = [];
      for (DaySelectionModel data in availability_schedule) {
        final String day = data.day;
        final String from_time = data.startTime!;
        final String to_time = data.stopTime!;

        // Check if required fields are not empty or undefined
        if (day.isNotEmpty && from_time.isNotEmpty && to_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "availability_day": day,
            "from_time": from_time,
            "to_time": to_time,
          };
          availability_scheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          //isServiceEDLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request
        }
      }

      var body = {
        //"email": email,
        "service_type": "Program",
        "service_name": service_name,
        "description": description,
        "start_date": start_date,
        "end_date": end_date,
        'duration': duration,
        "service_recurrence": program_recurrence,
        "max_number_of_participants": max_number_of_participants,
        "in_person_event_fee": service_charge_in_person,
        "virtual_event_fee": service_charge_virtual,
        "availability_schedule": availability_scheduleList,
      };

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

  Future<void> updateEventService({
    required BuildContext context,
    required String serviceId,
    required String service_name,
    required String description,
    required String virtual_meeting_link,
    required String physical_location,
    required String event_schedule,
    required String date,
    required String start_time,
    required String end_time,
    required String inpersonFee,
    required String virtualFee,
    required List<Map<String, dynamic>> schedule,

    
    }) async {

    isServiceEDLoading.value = true;

    try {

      //EVENT DATA LOOP
      final List<dynamic> eventScheduleList = [];
      for (Map<String, dynamic> data in schedule) {
        final String date = data['date'];
        final String start_time = data['start_time'];
        final String stop_time = data['stop_time'];

        // Check if required fields are not empty or undefined
        if (date.isNotEmpty && start_time.isNotEmpty && stop_time.isNotEmpty) {
          final Map<String, dynamic> map = {
            "date": date,
            "time": start_time,
            "end_time": stop_time,
          };
          eventScheduleList.add(map);

        } 
        else {
          // Handle case where required fields are empty or undefined
          /*isServiceCRLoading.value = false;
          debugPrint("Error: Required fields are empty or undefined");
          return; // Stop processing this request*/
          log('empty list');
        }
      }

      
      
      var body1 = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "Event",
        "virtual_meeting_link": virtual_meeting_link,
        "physical_location": physical_location,
        "event_type": event_schedule,
        "date": date,
        "start_time": start_time,
        "end_time": end_time,
        "in_person_event_fee": inpersonFee,
        "virtual_event_fee": virtualFee,
      };

      var body2 = {
        //"email": email,
        "service_name": service_name,
        "description": description,
        "service_type": "Event",
        "virtual_meeting_link": virtual_meeting_link,
        "physical_location": physical_location,
        "event_type": event_schedule,
        "in_person_event_fee": inpersonFee,
        "virtual_event_fee": virtualFee,
        "event_schedule": eventScheduleList,
      };


      http.Response res = await baseService.httpPut(
        endPoint: "services/edit?serviceId=$serviceId", 
        body: event_schedule == "Single date" ? body1 : body2
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        isServiceEDLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("user Event service updated successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "Your service has been updated successfully"
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
          message: "failed to create service: ${res.statusCode} || ${res.body}"
        );
      }
    } 
    catch (e) {
      isServiceEDLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong: $e");
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
        debugPrint('this is response body ==> ${res.body}');
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

    searchOneoffController.dispose();
    searchRetainerController.dispose();
    searchProgramController.dispose();
    searchEventController.dispose();
   
    super.dispose();
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

}