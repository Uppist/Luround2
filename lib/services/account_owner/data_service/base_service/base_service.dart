import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioG;
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:get/get.dart' as getX;






class BaseService extends getX.GetxController {
  

  //General Base URL
  String socketUrl = "ws://luround-api-7ad1326c3c1f.herokuapp.com/";
  String baseUrl = "https://luround-api-7ad1326c3c1f.herokuapp.com/api/v1/"; //"https://luround.onrender.com/";
  String baseUrlForGoogle = "https://luround-api-7ad1326c3c1f.herokuapp.com/api/v1/"; //"https://luround.onrender.com/";



  //DIO (DELETE REQUEST)
  Future<dynamic> deleteRequestWithDio({required String endPoint}) async {
    try {
      var token = await LocalStorage.getToken();
      // Create Dio instance
      dioG.Dio dio = dioG.Dio();

      // Optionally, you can configure additional options like headers, etc.
      dio.options.headers = token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      : null;

      // Perform the DELETE request
      dioG.Response response = await dio.delete("$baseUrl$endPoint");

      // Handle the response as needed
      print('DELETE Request Status Code: ${response.statusCode}');
      print('DELETE Request Response Data: ${response.data}');
      return response;
    } catch (e) {
      // Handle errors
      print('Error during DELETE request: $e');
      Exception('Error during DELETE request: $e');
    }
  }

   //DIO (DELETE REQUEST) WITH BODY
  Future<dynamic> deleteRequestWithBodyDio({required String endPoint, required dynamic data}) async {
    try {
      var token = await LocalStorage.getToken();
      // Create Dio instance
      dioG.Dio dio = dioG.Dio();

      // Optionally, you can configure additional options like headers, etc.
      dio.options.headers = token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      : null;

      // Perform the DELETE request
      dioG.Response response = await dio.delete("$baseUrl$endPoint", data: data);

      // Handle the response as needed
      print('DELETE Request Status Code: ${response.statusCode}');
      print('DELETE Request Response Data: ${response.data}');
      return response;
    } catch (e) {
      // Handle errors
      print('Error during DELETE request: $e');
      Exception('Error during DELETE request: $e');
    }
  }
  
  //POST REQUEST WITH Dio
  Future<dynamic> putRequestWithDio({ 
    required String endPoint, 
    required dynamic data
  }) async {
    try {
      var token = await LocalStorage.getToken();
      // Create Dio instance
      dioG.Dio dio = dioG.Dio();

      // Optionally, you can configure additional options like headers, etc.
      dio.options.headers = token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      : null;

      // Perform the POST request
      dioG.Response response = await dio.put(
        "$baseUrl$endPoint",
        data: data,
      );
      // Handle the response as needed
      print('PUT Request Status Code: ${response.statusCode}');
      print('PUT Request Response Data: ${response.data}');
      return response;
    } catch (e) {
      // Handle errors
      print('Error during PUT request: $e');
    }
  }

  //POST REQUEST WITH Dio
  Future<dynamic> postRequestWithDio({ 
    required String endPoint, 
    required dynamic data
  }) async {
    try {
      var token = await LocalStorage.getToken();
      // Create Dio instance
      dioG.Dio dio = dioG.Dio();

      // Optionally, you can configure additional options like headers, etc.
      dio.options.headers = token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      : null;

      // Perform the POST request
      dioG.Response response = await dio.post(
        "$baseUrl$endPoint",
        data: data,
      );
      // Handle the response as needed
      print('POST Request Status Code: ${response.statusCode}');
      print('POST Request Response Data: ${response.data}');
      return response;
    } catch (e) {
      // Handle errors
      print('Error during POST request: $e');
    }
  }

  //GET REQUEST WITH Dio
  Future<dioG.Response> getRequestWithDio({ 
    required String endPoint, 
  }) async{
    try {
      var token = LocalStorage.getToken();
      // Create Dio instance
      dioG.Dio dio = dioG.Dio();

      // Optionally, you can configure additional options like headers, etc.
      dio.options.headers = token != null ? 
      {
        'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      } 
      : null;

      // Perform the Get request
      dioG.Response response = await dio.get(
        "$baseUrl$endPoint",
        //data: data,
      );
      // Handle the response as needed
      print('GET Request Status Code: ${response.statusCode}');
      print('GET Request Response Data: ${response.data}');
      return response;
    } catch (e) {
      // Handle errors
      throw Exception('Error during GET request: $e');
    }
  }

  

  ///HTTP/// 
  //function that sends a GET request for Google Auth (on a soft)
  Future<dynamic> httpGooglePost({required String endPoint, required dynamic body}) async {
    //var token = await LocalStorage.getToken();
    Uri url = Uri.parse("$baseUrlForGoogle$endPoint");
    print(url);
    var res = http.post(
      url,
      body: json.encode(body),
      headers: //token != null ? 
      {
        //'Authorization': 'Bearer $token',
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
      //: null
    );
    return res;
  }

  //function that sends a PUT request  for resetting password (on a soft)
  Future<http.Response> httpPutAuth({required String endPoint, required dynamic body}) async {
    Uri url = Uri.parse("$baseUrl$endPoint");
    print(url);
    var res = http.put(
      url,
      body: json.encode(body),
      headers:
      {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      } 
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


