import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/models/account_owner/user_bookings/user_bookings_response_model.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;







class AccOwnerBookingService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ServicesController());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();



  /////[GET LOGGED-IN USER'S BOOKINGS LIST]//////

  //getx.RxList<List<DetailsModel>> filterBookingsList = getx.RxList<List<DetailsModel>>();
  //var filterBookingsList = <List<DetailsModel>>[].obs;
  
  // Convert the list to a Getx RxList
  //getx.RxList<List<DetailsModel>> dataList = getx.RxList<List<DetailsModel>>();
  var dataList = <DetailsModel>[].obs;


  //////////////////////////////////////////////////////////////////////////////////
  //working well
  Future<void> filterBookings(String query) async{
    // Clear the filteredList
    dataList.clear();

    // If the search query is empty, display all items
    if (query.isEmpty) {
      dataList.addAll(dataList);
    } 
    else {
      // Use the search query to filter the items
      dataList.addAll(
        dataList.where((item) {
          if(query.contains(item.serviceDetails.serviceName.toLowerCase())) {
            return true;
          }
          // Customize this part based on your data structure
          /*for (var detail in item) {
            String displayName = detail.bookingUserInfo.displayName.toLowerCase();
            if (displayName.contains(query.toLowerCase())) {
              return true; // If found, include the item in the filtered list
            }
          }*/
          return false; // If not found in any detail, exclude the item
        }),
      );  
      print("Filtered booking list displaying : $dataList");
    }
  }


  Future<void> filterBySent() async{
    // Clear the filteredList so new values can come i n 
    dataList.clear();
    // Use the search query to filter the items
    dataList.addAll(
      dataList.where((item) {
        return item.bookingUserInfo.userId.toLowerCase() == userId;
      }),
    );  
    print("Sent List: $dataList");
    
  }

  Future<void> filterByReceived() async{
    // Clear the filteredList so new values can come i n 
    dataList.clear();
    // Use the search query to filter the items
    dataList.addAll(
      dataList.where((item) {
        return item.bookingUserInfo.userId.toLowerCase() != userId;
      }),
    );
    print("Received List: $dataList");
  }


  Future<void> filterByUpcoming() async{
    // Clear the filteredList so new values can come i n 
    dataList.clear();

    // Use the search query to filter the items
    dataList.addAll(
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
    print("Upcoming List: $dataList");
  }

  Future<void> filterByPast() async{
    // Clear the filteredList so new values can come i n 
    dataList.clear();

    // Use the search query to filter the items
    dataList.addAll(
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
    print("Past List: $dataList");
  }


  Future<void> fiterByCancelled() async{
    // Clear the filteredList so new values can come i n 
    dataList.clear();

    // Use the search query to filter the items
    dataList.addAll(
      dataList.where((item) {
        String booking_status = item.serviceDetails.bookedStatus.toLowerCase();
        if (booking_status == "cancelled") {
          return true; // If found, include the item in the filtered list
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Cancelled $dataList");
  }

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

        return finalResult;
        

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
          message: "failed to delete booking"
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
  }) async {
    
    isLoading.value = true;

    var body = {
      "date": date,
      "time": time
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
          message: "booking resheduled successfully"
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
          message: "failed to reschedule booking"
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