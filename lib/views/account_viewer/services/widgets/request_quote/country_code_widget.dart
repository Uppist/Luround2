import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';







class CountryCodeWidget extends StatefulWidget {
  const CountryCodeWidget({super.key});

  @override
  State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
}

class _CountryCodeWidgetState extends State<CountryCodeWidget> {

  var controller = Get.put(AccViewerServicesController());

  

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (val) {
        controller.onCountryChange(val);
      }, //_onCountryChange,
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'NG',
      favorite: const ['NG'],
      // optional. Shows only country name and flag
      //showCountryOnly: false,
      // optional. Shows only country name and flag when popup is closed.
      //showOnlyCountryWhenClosed: false,
      // optional. aligns the flag and the Text left
      //alignLeft: true,
      //showDropDownButton: true,
      //showFlag: true,
    );
  }
}