import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';










class TestController extends getx.GetxController {

  var baseService = getx.Get.put(BaseService());
  var finController = getx.Get.put(FinancialsController());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var user_email = LocalStorage.getUseremail();
  var user_name = LocalStorage.getUsername();


}