import 'package:flutter/material.dart';



class ViewModel{
  ViewModel({required this.icon, required this.name, required this.index});
  final TextEditingController linkController = TextEditingController();
  final String icon;
  final String name;
  final int index;
}