import 'package:flutter/material.dart';


class FieldModel{
  FieldModel({required this.icon, required this.name,});

  final TextEditingController linkController = TextEditingController();
  
  //for mobile textfield
  //String countryCode = controller.code.value;
  final String icon;
  final String name;
  //final int index;
}