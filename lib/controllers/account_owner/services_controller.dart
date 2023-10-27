import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;








class ServicesController extends getx.GetxController {

  //boolean that checks if the user (account owner) currently doesn't have any service
  final isServicePresent = true.obs;

  //add service stepper///////////////////////
  //formKey
  final formKeyBA = GlobalKey();
  //(save to db)
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addLinksController = TextEditingController();
  final TextEditingController inPersonController = TextEditingController();
  final TextEditingController virtualController = TextEditingController();
  //textcontroller count
  int maxLength = 500;
  //for Stepper widget
  int curentStep = 0;
  





  @override
  void dispose() {
    // TODO: implement dispose
    serviceNameController.dispose();
    descriptionController.dispose();
    addLinksController.dispose();
    inPersonController.dispose();
    virtualController.dispose();
    super.dispose();
  }

}