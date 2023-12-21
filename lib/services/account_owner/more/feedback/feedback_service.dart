import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/more_controller.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';











class FeedbackService extends getx.GetxController {
  
  var controller = getx.Get.put(MoreController());
  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var email = LocalStorage.getUseremail();

  ///[SEND FEEDBACK]//
  Future<void> sendFeedback({
    required BuildContext context,
    required String description,
    required String subject,
    }) async {

    isLoading.value = true;

    var body = {
      "description": description,
      "subject": subject,
    };

    try {
      http.Response res = await baseService.httpPost(endPoint: "feedbacks/add", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint("user feedback sent successfully");
        controller.subjectController.clear();
        controller.descriptionController.clear();
        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "feedback sent successfully"
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
          message: "failed to send feedback"
        );
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }

}