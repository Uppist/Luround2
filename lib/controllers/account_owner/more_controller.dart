import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';










class MoreController extends getx.GetxController {
  
  //text controllers
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isSubmit = false;









  @override
  void dispose() {
    // TODO: implement dispose
    //subjectController.dispose();
    //descriptionController.dispose();
    super.dispose();
  }
}
  