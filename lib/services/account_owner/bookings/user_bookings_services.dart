import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/models/account_owner/user_bookings/user_bookings_response_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/components/converters.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;







class AccOwnerBookingService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ServicesController());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();



  /////[GET LOGGED-IN USER'S BOOKINGS LIST]//////
  List<UserBookingModel> filterBookingsList = [];
  List<UserBookingModel> dataList = [];
  
  //working well
  void filterBookings(String query) {
    // Clear the filteredList
    filterBookingsList.clear();

    // If the search query is empty, display all items
    if (query.isEmpty) {
      filterBookingsList.addAll(dataList);
    } 
    else {
      // Use the search query to filter the items
      filterBookingsList.addAll(
        dataList.where((item) {
          // Customize this part based on your data structure
          for (var detail in item.details) {
            String displayName = detail["booking_user_info"]["displayName"].toLowerCase();
            if (displayName.contains(query.toLowerCase())) {
              return true; // If found, include the item in the filtered list
            }
          }
          return false; // If not found in any detail, exclude the item
        }),
      );  
      print("Filtered list displaying : $dataList");
    }
  }


  void filterBySent() {
    // Clear the filteredList so new values can come i n 
    filterBookingsList.clear();

    // Use the search query to filter the items
    filterBookingsList.addAll(
      dataList.where((item) {
        return item.userBooked == false;
      }),
    );  
    print("Filtered list displaying");
    
  }

  void filterByReceived() {
    // Clear the filteredList so new values can come i n 
    filterBookingsList.clear();

    // Use the search query to filter the items
    filterBookingsList.addAll(
      dataList.where((item) {
        return item.userBooked == true;
      }),
    );  
    print("Filtered list displaying");
  }


  void filterByUpcoming() {
    // Clear the filteredList so new values can come i n 
    filterBookingsList.clear();

    // Use the search query to filter the items
    filterBookingsList.addAll(
      dataList.where((item) {
        // Customize this part based on your data structure
        for (var detail in item.details) {
          String server_date = detail["service_details"]["date"].toLowerCase();
          DateTime convertedDate = convertStringToDateTime(server_date);
          print('Converted Date: $convertedDate');
          checkDateProximity(convertedDate);
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Filtered list displaying");
  }

  void filterByPast() {
    // Clear the filteredList so new values can come i n 
    filterBookingsList.clear();

    // Use the search query to filter the items
    filterBookingsList.addAll(
      dataList.where((item) {
        // Customize this part based on your data structure
        for (var detail in item.details) {
          String server_date = detail["service_details"]["date"].toLowerCase();
          DateTime convertedDate = convertStringToDateTime(server_date);
          print('Converted Date: $convertedDate');
          checkDateDistance(convertedDate);
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Filtered list displaying");
  }

  void fiterByCancelled() {
    // Clear the filteredList so new values can come i n 
    filterBookingsList.clear();

    // Use the search query to filter the items
    filterBookingsList.addAll(
      dataList.where((item) {
        for (var detail in item.details) {
          String booking_status = detail["service_details"]["booked_status"].toLowerCase();
          if (booking_status == "cancelled") {
            return true; // If found, include the item in the filtered list
          }
        }
        return false; // If not found in any detail, exclude the item
      }),
    );  
    print("Filtered list displaying");
  }


  Future<List<UserBookingModel>> getUserBookings() async {

  isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "booking/my-bookings?userID=$userId");
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user bookings fetched successfully!!");
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> jsonResponse = json.decode(res.body);
        debugPrint("res_list${jsonResponse}");
        return jsonResponse.map((e) => UserBookingModel.fromJson(e)).toList();

        // Clear existing data and add the new data to the list
        //dataList.clear();
        //dataList.addAll(jsonResponse.map((data) => data as Map<String, dynamic>));
        //print("new list: $dataList");

        // Now you can use the 'dataList' to display data in your Flutter app
        // For example, update your UI or call a method to rebuild the widget
        // that displays the data.
      } else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        throw Exception('Failed to load user services data');
      }
    } catch (e) {
      isLoading.value = false;
      throw HttpException("$e");
    }
  }


}