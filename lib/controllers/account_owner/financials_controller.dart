import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;










class FinancialsController extends getx.GetxController {
  
  final isFieldTapped = false.obs;
  final TextEditingController searchController = TextEditingController();

  void isFieldTappedFunc() {
    isFieldTapped.value = !isFieldTapped.value;
    update();
  }



  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}