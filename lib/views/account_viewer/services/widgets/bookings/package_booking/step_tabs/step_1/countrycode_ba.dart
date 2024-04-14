import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';







class CountryCodeWidgetBA extends StatefulWidget {
  const CountryCodeWidgetBA({super.key});

  @override
  State<CountryCodeWidgetBA> createState() => _CountryCodeWidgetBAState();
}

class _CountryCodeWidgetBAState extends State<CountryCodeWidgetBA> {

  var controller = Get.put(AccViewerServicesController());

  
  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    debugPrint("New Country selected: $countryCode");
    setState(() {
      controller.codeBA.value = countryCode.code.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (val) {
        controller.onCountryChangeBA(val);
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