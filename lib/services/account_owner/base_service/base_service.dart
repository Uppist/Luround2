import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:get/get.dart' as getX;







class BaseService extends getX.GetxController {
  
  //General Base URL
  String baseUrl = "https://luround.onrender.com/api/v1/";
  String baseUrlForGoogle = "https://luround.onrender.com/";
  ///HTTP///
  
  //function that sends a GET request for Google Auth (on a soft)
  Future<dynamic> httpGooglePost({required String endPoint, required Map<String, dynamic> body}) async {
    var token = await LocalStorage.getToken();
    Uri url = Uri.parse("$baseUrlForGoogle$endPoint");
    print(url);
    var res = http.post(
      url,
      body: json.encode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      : null
    );
    return res;
  }

  //function that sends a GET request (on a soft)
  Future<dynamic> httpGet({required String endPoint}) async {
    var token = await LocalStorage.getToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    print(url);
    var res = http.get(
      url,
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      : null
    );
    return res;
  }

  //function that sends a POST request (on a soft)
  Future<dynamic> httpPost({required String endPoint, required dynamic body}) async {
    var token = await LocalStorage.getToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    print(url);
    var res = http.post(
      url,
      body: json.encode(body),
      headers: //token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      //: null
    );
    return res;
  }
  
  //function that sends a PUT request (on a soft)
  Future<http.Response> httpPut({required String endPoint, required dynamic body}) async {
    var token = await LocalStorage.getToken();
    Uri url = Uri.parse("$baseUrl$endPoint");
    print(url);
    var res = http.put(
      url,
      body: json.encode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
      : null,
    );
    return res;
  }

  
  //function that sends a DELETE request (on a soft)
  Future<http.Response> httpDelete({required String endPoint, required dynamic body}) async {
    var token = await LocalStorage.getToken();
    var res = http.delete(
      Uri.parse("$baseUrl$endPoint"),
      body: json.encode(body),
      headers: token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
      : null
    );
    return res;
  }


  //function that handles Dio's API calls errors pertaining to internet connection
  dynamic handleError(HttpException error) {

    debugPrint("$error");

    if (error.message.contains('SocketException')) {
      return LuroundSnackBar.noInternet(
        message:
        'We cannot detect internet connection. Seems like you are offline.',
        message2: 'Please retry.',
      );
    }
    if (error.message == HttpStatus.networkConnectTimeoutError.toString()) {
      return LuroundSnackBar.noInternet(
        message: 'Connection timed out. Seems like you are offline.',
        message2: 'Please retry.',
      );
    }
    return LuroundSnackBar.noInternet(
      message: 'Something went wrong.', 
      message2: 'Please try again later'
    );
  }

}


