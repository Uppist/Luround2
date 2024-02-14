import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/services/services_controller.dart';
import 'package:luround/models/account_owner/user_bookings/user_bookings_response_model.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/meeting_cancelled_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;







class AccOwnerBookingService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var authService = getx.Get.put(AuthService());
  var controller = getx.Get.put(ServicesController());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();



  /////[GET LOGGED-IN USER'S BOOKINGS LIST]//////
  var dataList = <DetailsModel>[].obs;
  var filteredList = <DetailsModel>[].obs;

  //FILTER FUNCTIONALITIES////////
  Future<void> filterTrxByPastDate() async{
    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        String server_date = convertServerTimeToDate(item.serviceDetails.createdAt);
        DateTime convertedDate = convertStringToDateTime(server_date);
        print('Converted Date: $convertedDate');
        // Check if the date is in the past
        if (isDateInPast(convertedDate)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Past bookings List: $filteredList");
  }

  Future<void> filterListByToday() async{
    DateTime today = DateTime.now();
    DateTime todayAgo = today.subtract(Duration(days: 0));

    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
  
      dataList.where((item) {
        String serverDate = convertServerTimeToDate(item.serviceDetails.createdAt);
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is within the last seven days
        if (convertedDate.isAfter(todayAgo)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );

    print("bookings List from today: $filteredList");
  }

  Future<void> filterListByYesterday() async{
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));

    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
  
      dataList.where((item) {
        String serverDate = convertServerTimeToDate(item.serviceDetails.createdAt);
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is within the last seven days
        if (convertedDate.isAfter(yesterday)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );

    print("Bookings List from yesterday: $filteredList");
  }


  Future<void> filterListByLastSevenDays() async{
    DateTime today = DateTime.now();
    DateTime sevenDaysAgo = today.subtract(Duration(days: 7));

    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        String serverDate = convertServerTimeToDate(item.serviceDetails.createdAt);
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is within the last seven days
        if (convertedDate.isAfter(sevenDaysAgo)) {
          return true; // Include the item in the filtered list
        }

        return false; // If not found in any detail, exclude the item
      }),
    );

    print("bookings List from the last seven days: $filteredList");
  }

  Future<void> filterListByLastThirtyDays() async{
    DateTime today = DateTime.now();
    DateTime thirtyDaysAgo = today.subtract(Duration(days: 30));

    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        String serverDate = convertServerTimeToDate(item.serviceDetails.createdAt);
        DateTime convertedDate = convertStringToDateTime(serverDate);

        // Check if the date is within the last seven days
        if (convertedDate.isAfter(thirtyDaysAgo)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );

    print("booking List from the last thirty days: $filteredList");
  }
  ////////////////////////////////////







  //////////////////////////////////////////////////////////////////////////////////
  //working well
  Future<void> filterBookings(String query) async {
    if (query.isEmpty) {
      filteredList.clear();
      filteredList.addAll(dataList);
      print("when query is empty: $filteredList");
    } 
    else {

      filteredList.clear(); // Clear the previous filtered list

      // Use addAll to add the filtered items to the list
      filteredList.addAll(
        dataList
        .where((user) => user.bookingUserInfo.displayName.contains(query)) // == query
        .toList());

      /*filteredList.where((user) => user.serviceDetails.serviceName.toLowerCase() == query)
        .toList();*/

      print("when query is not empty: $filteredList");
    }
  }



  /*Future<void> filterBySent() async{
    // Clear the filteredList so new values can come i n 
    filteredList.clear();
    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        return item.bookingUserInfo.userId.toLowerCase() == userId;
      }),
    );  
    print("Sent List: $filteredList");
    
  }

  Future<void> filterByReceived() async{
    // Clear the filteredList so new values can come i n 
    filteredList.clear();
    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        return item.bookingUserInfo.userId.toLowerCase() != userId;
      }),
    );
    print("Received List: $filteredList");
  }


  Future<void> filterByUpcoming() async{
    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        // Customize this part based on your data structure
        String server_date = item.serviceDetails.date.toLowerCase();
        DateTime convertedDate = convertStringToDateTime(server_date);
        print('Converted Date: $convertedDate');
        //checkDateProximity(convertedDate);
        // Check if the date is in the future only
        if (isDateInFuture(convertedDate)) {
          return true; // Include the item in the filtered list for future dates
        }   
        return false; // If not found in any detail, exclude the item

      }),
    );  
    print("Upcoming List: $filteredList");
  }

  Future<void> filterByPast() async{
    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        // Customize this part based on your data structure
        //for (var detail in item) {
        String server_date = item.serviceDetails.date.toLowerCase();
        DateTime convertedDate = convertStringToDateTime(server_date);
        print('Converted Date: $convertedDate');
        //checkDateDistance(convertedDate);
        // Check if the date is in the past
        if (isDateInPast(convertedDate)) {
          return true; // Include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Past List: $filteredList");
  }


  Future<void> fiterByCancelled() async{
    // Clear the filteredList so new values can come i n 
    filteredList.clear();

    // Use the search query to filter the items
    filteredList.addAll(
      dataList.where((item) {
        String booking_status = item.serviceDetails.bookedStatus;
        if (booking_status == "CANCELLED") {
          return true; // If found, include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Cancelled $filteredList");
  }*/

  /////////////////////////////////////////////////////////////////////////////////

  Future<List<DetailsModel>> getUserBookings() async {
    try {

      isLoading.value = true;
      http.Response res = await baseService.httpGet(endPoint: "booking/my-bookings");

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user bookings fetched successfully!!");

        List<dynamic> jsonData = json.decode(res.body);
        
        // Extract the "details" list from the first map
        List<dynamic> result = jsonData[0]['details'];
        List<dynamic> result2 = jsonData[1]['details'];

        result.addAll(result2);

        print("new_arr[0]: $result");

        var finalResult = result.map((e) => DetailsModel.fromJson(e)).toList();
        
        dataList.clear();
        dataList.addAll(finalResult);
        print("dataList: $dataList");
        
        //return data list
        return dataList;
        

      } else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user details');
      }
    }   
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    }
  }
  
  //confirm booking
  Future<dynamic> confirmBooking({
    required BuildContext context,
    required String bookingId
  }) async {
    try {

      isLoading.value = true;
      http.Response res = await baseService.httpGet(endPoint: "booking/confirm-booking?bookingId=$bookingId");

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("booking confirmed");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "booking successfully confirmed"
        ).whenComplete(() {
          //send push notification and store in db
          authService.sendPushNotification(
            noti_title: "Booking confirmed", 
            noti_body: "your booking with the id: $bookingId \n has been confirmed successfully"
          );
        });
        

      } else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to confirm booking: ${res.statusCode} | ${res.body}"
        );
        throw Exception('failed to confirm booking');
      }
    }   
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    }
  }

  //cancel booking
  Future<dynamic> cancelBooking({
    required BuildContext context,
    required String bookingId
  }) async {
    try {

      isLoading.value = true;
      http.Response res = await baseService.httpGet(endPoint: "booking/cancel?bookingId=$bookingId");

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("booking cancelled nicely");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "booking successfully cancelled"
        ).whenComplete(() {
          //send push notification and store in db
          authService.sendPushNotification(
            noti_title: "Booking cancelled", 
            noti_body: "your booking with the id: $bookingId \n has been cancelled successfully"
          );
          //show meeting cancelled dialog
          meetingCancelledBookingDialogueBox(context: context);
        });
        

      } else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to cancel booking: ${res.statusCode} | ${res.body}"
        );
        throw Exception('failed to cancel booking: ${res.statusCode} | ${res.body}');
      }
    }   
    catch (e) {
      isLoading.value = false;
      throw Exception("$e");
    }
  }

  

  Future<void> deleteBooking({
    required BuildContext context,
    required String bookingId,
  }) async {
    
    isLoading.value = true;

    var body = {};

    try {
      http.Response res = await baseService.httpDelete(endPoint: "booking/delete?bookingId=$bookingId", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user booking deleted succesfully");
         //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "booking deleted successfully"
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
          message: "failed to delete booking: ${res.statusCode} | ${res.body}"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw const HttpException("Something went wrong");
    }
  }


  Future<void> rescheduleBooking({
    required BuildContext context,
    required String bookingId, //important
    required String date,
    required String time,
    required String duration,
  }) async {
    
    isLoading.value = true;

    var body = {
      "date": date,
      "time": time,
      "duration": duration
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "booking/reschedule?bookingId=$bookingId", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user booking rescheduled succesfully");
         //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "booking rescheduled successfully"
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
          message: "failed to reschedule booking: ${res.statusCode} | ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong: $e");
    }
  }
  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserBookings().then(
      (value) => debugPrint("bookings inserted into the widget tree: $value")
    );
  }

}