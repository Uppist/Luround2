import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;










class BookingsController extends getx.GetxController {
  
  final TextEditingController searchController = TextEditingController();
  final isFieldTapped = false.obs;
  final isExpanded = false.obs;
  int selectedIndex = -1;







  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

}