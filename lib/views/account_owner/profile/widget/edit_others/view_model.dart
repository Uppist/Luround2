import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/profile_page_controller.dart';



//Dependency injection
var controller = Get.put(ProfilePageController());

class ViewModel{
  ViewModel({required this.icon, required this.name,});

  final TextEditingController linkController = TextEditingController();
  
  //for mobile textfield
  String countryCode = controller.code.value;

  final String icon;
  final String name;
  //final int index;
}