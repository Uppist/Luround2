import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/models/account_owner/more/transactions/saved_banks_response.dart';
import 'package:luround/models/account_owner/user_profile/review_response.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/models/account_viewer/booking/bookimg_response.dart';
import 'package:luround/models/account_viewer/request_quote/request_quote_response.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/transaction_successful_screen.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;









class AccViewerService extends getx.GetxController {

  var controller = getx.Get.put(AccViewerServicesController());
  var withdrawalService = getx.Get.put(WithdrawalService());
  var baseService = getx.Get.put(BaseService());
  var authService = getx.Get.put(AuthService());
  final isLoading = false.obs;
  //var userId = LocalStorage.getUserID();
  //var userEmail = LocalStorage.getUseremail();



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

  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlEmail({required String email}) async{
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
    }

    Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Enter your mail subject',
        'body': 'Enter you message'
      })
    );
    if(await launcher.canLaunchUrl(emailUri)) {
      launcher.launchUrl(
        emailUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $emailUri');
    }
  }

  //functions for url_launcher (to launch user socials link)
  Future<void> launchUrlPhone({required String phone}) async{

    Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if(await launcher.canLaunchUrl(phoneUri)) {
      launcher.launchUrl(
        phoneUri,
        mode: launcher.LaunchMode.inAppWebView
      );
    }
    else {
      throw Exception('Can not launch uri: $phoneUri');
    }
  }


  






  /////[GET LOGGED-IN USER'S SERVICES LIST]//////
  Future<List<UserServiceModel>> getUserServices({required String userName}) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "services/get-user-services?url=https://www.luround.com/profile/$userName",);
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
      throw Exception("$e");
    
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
      throw Exception("$e");
    
    }
  }


  /////[BOOK USER SERVICE]///// i.e, book and pay for a user's service
  Future<dynamic> bookUserService({
    required BuildContext context,
    required String name,
    required String email,
    required String service_name,
    //
    required String serviceId,
    required String phone_number,
    required String appointment_type,
    required String date,
    required String file,
    required String time,
    required String duration,
    required String message,
    required String location,
  }) async {
    isLoading.value = true;

    var body = {
      "email": email,
      "displayName": name,
      "payment_proof": file,
      "phone_number": phone_number,
      "appointment_type": appointment_type,
      "date": date,
      "time": time,
      "duration": duration,
      "message": message,
      "location": location,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "booking/book-service?serviceId=$serviceId", body: body);  //remove somto's service id later
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("luround user got booked succesfully");
        BookServiceResponseModel response = BookServiceResponseModel.fromJson(jsonDecode(res.body));
        /////////////
        print("bookings response here: $response");
        
        //send push notification to the service_proider
        authService.sendPushNotification(
          fcm_token: response.user_nToken,
          userID: response.userId,
          noti_title: "New Booking Alert", 
          noti_body: "you have just been booked by $name"
        );


        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "you've successfully booked this service"
        ).whenComplete(() {
          //clear the controllers
          controller.nameBAController.clear();
          controller.emailBAController.clear();
          controller.phoneNumberBAController.clear();
          controller.messageBAController.clear();

          getx.Get.to(() => TransactionSuccesscreen(
            servie_provider_name: 'this service provider',
            service_name: service_name,
          ));
          
        });

        //await launchUrlLink(link: response.payment_link)
  
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //clear the controllers
        controller.nameBAController.clear();
        controller.emailBAController.clear();
        controller.phoneNumberBAController.clear();
        controller.messageBAController.clear();
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to book service",
        ).whenComplete(() {
          getx.Get.offAll(() => MainPageAccViewer());
        });
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }


  ////Calculate the total rating of a user
  String getUserTotalRatings({required double ratings, required int length}) {
    double totalRating = (ratings * length)/length;
    return totalRating.toString();
  }

  /////[GET LOGGED-IN USER'S REVIEW'S LIST]//////  remove service id
  Future<List<ReviewResponse>> getUserReviews({
    required String userID
  }) async {
    isLoading.value = true;
    try {
      http.Response res = await baseService.httpGet(endPoint: "reviews/user-reviews?userId=$userID",);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("user reviews gotten successfully!!");
        //decode the response body here
        final List<dynamic> response = jsonDecode(res.body);
        debugPrint("$response");
        return response.map((e) => ReviewResponse.fromJson(e)).toList();
      }
      else {
        isLoading.value = false;
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response body ==> ${res.body}');
        throw Exception('Failed to load user reviews');
      }
    } 
    catch (e) {
      isLoading.value = false;
      //debugPrint("Error net: $e");
      throw Exception("$e");
    
    }
  }


  ////[TO MAKE AN EXTERNAL USER WRITE REVIEW]//////// remove service
  Future<void> addReview({
    required BuildContext context,
    required double rating,
    required String comment,
    //required String user_name,
  }) async {

    isLoading.value = true;

    var body = {
      //"user_name": user_name,
      "rating": rating,
      "comment": comment
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "reviews/add-review", body: body);  //?serviceId=6572c7f714b0a81bd0de3c88
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("review sent successfully");
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "review sent successfully"
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
          message: "failed to send review"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }



  ////[TO MAKE AN EXTERNAL USER REQUEST QUOTE]//////// 
  Future<void> requestQuote({
    required BuildContext context,
    required String service_id,
    required String offer,
    required String uploaded_file,
    required String appointment_type,
    required String client_name,
    required String client_email,
    required String client_phone_number,
    required String client_note,

  }) async {

    isLoading.value = true;

    var body = {
      "user_email": client_email,
      "full_name": client_name,
      "phone_number": client_phone_number,
      "appointment_type": appointment_type,
      "budget": offer,
      "file": uploaded_file,
      "note": client_note

    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "quotes/request-quote?serviceId=$service_id", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("this is response body ==> ${res.body}");

        RequestQuoteResponseModel response = RequestQuoteResponseModel.fromJson(jsonDecode(res.body));
        /////////////
        print("bookings response here: $response");
        
        //send push notification to the service_proider
        authService.sendPushNotification(
          fcm_token: response.user_nToken,
          userID: response.userId,
          noti_title: "New Quote Alert", 
          noti_body: "you received a quote from $client_name"
        );

        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "your request has been sent successfully"
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
          message: "failed to send quote request"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }
  






  //user list of bank accounts from backend
  var userBankAccountList = <SavedBanks>[].obs;










  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


}