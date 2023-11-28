import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/models/account_owner/user_bookings/user_bookings_response_model.dart';
import 'package:luround/services/account_owner/base_service/base_service.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as launcher;







class AccOwnerBookingService extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var controller = getx.Get.put(ServicesController());
  final isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();



  /////[GET LOGGED-IN USER'S BOOKINGS LIST]//////

  void filterBookings(String query) {
    // Clear the filteredList
    filterBookingsList.clear();

    // If the search query is empty, display all items
    if (query.isEmpty) {
      filterBookingsList.addAll(dataList);
    } 
    else {
      // Use the search query to filter the items
      filterBookingsList.addAll(dataList.where((item) {
        // Customize this part based on your data structure
        return item['service_name'].toLowerCase().contains(query.toLowerCase());
      }));
    }
  }


  List<Map<String, dynamic>> filterBookingsList = [];
  List<Map<String, dynamic>> dataList = [];

  Future<void> getUserBookings() async {

    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "booking/my-bookings?userID=$userId");
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint("user bookings fetched successfully!!");
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> jsonResponse = json.decode(res.body);

        // Clear existing data and add the new data to the list
        dataList.clear();
        dataList.addAll(jsonResponse.map((data) => data as Map<String, dynamic>));
        print("new list: $dataList");

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