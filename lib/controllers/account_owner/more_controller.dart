import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;






class MoreController extends getx.GetxController {
  
  //text controllers
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isSubmit = false;
  //notifications setting scren
  bool isToggled = false;










  @override
  void dispose() {
    // TODO: implement dispose
    //subjectController.dispose();
    //descriptionController.dispose();
    super.dispose();
  }
}
  