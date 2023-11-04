import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;








class AccViewerServicesController extends getx.GetxController {
  


  //REQUEST QUOTE//////////////////////////(save to db)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  //formKey
  final formKey = GlobalKey();
  //radio widget (saved appointment option to db)
  String apppointment = "selected option";
  //country code picker (append with phone number controller.text and save to db)
  var code = "".obs; 
  void onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    code.value = countryCode.dialCode.toString();
    debugPrint("New Country selected: ${code.value}");
    update();
  }
  //to enable the submit button
  final isButtonEnabled = false.obs; // Initially, the button is disabled
  ////////////////////////////////////////////////////////
  






  ///Book Appointment///////////////////////////////////////////
  //formKey
  final formKeyBA = GlobalKey();
  //(save to db)
  final TextEditingController nameBAController = TextEditingController();
  final TextEditingController emailBAController = TextEditingController();
  final TextEditingController phoneNumberBAController = TextEditingController();
  final TextEditingController serviceNameBAController = TextEditingController();
  final TextEditingController messageBAController = TextEditingController();
  //textcontroller count
  int maxLength = 500;
  //for Stepper widget
  int curentStep = 0;
  //radio widget for bookin an appontment (saved appointment option to db)
  String step1Appointment = "selected option";
  //select date
  var dates = <DateTime?>[];
  //selected index
  int selectedindex = -1; // Initialize to -1 to indicate no selection
  //(save the date below to db)
  String getDate () {
    var result = dates[0].toString();
    var refinedList = result.split(" ")[0];
    //print(refinedList);
    return refinedList;
  }
  /////////////////////////////////////////////////////////////////

  //proceed to pay screen (save to db)
  final TextEditingController cardholderNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  //booleans (very important)
  final isCVVEnabled = false.obs; 
  final isButtonEnabled2 = false.obs; //step1
  final isButtonEnabled3 = false.obs;  //step2
  final isButtonEnabled4 = false.obs;  //step3
  final isButtonEnabled5 = false.obs;  //payment

  ////////////////////
  

  ///service_screen list/// 
  final selectedIndex = 0.obs; //for toggling price of the services list,
  final isVirtual = true.obs;  //boolean to switch between prices in the services list
  //List<String> tabs = ['Virtual', "In-Person"];

  void handleTabTap(int index) {
    isVirtual.value = !isVirtual.value;
    selectedIndex.value = index;
    print("price switch check: ${isVirtual.value}");
    update();
  }
  











  @override
  void dispose() {
    // TODO: implement dispose
    //
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    serviceNameController.dispose();
    messageController.dispose();
    //BA (Book appointment controllers)
    nameBAController.dispose();
    emailBAController.dispose();
    phoneNumberBAController.dispose();
    //serviceNameBAController.dispose();
    messageBAController.dispose();
    //proceed to pay controllers
    cardholderNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    //cvvController.dispose();
    super.dispose();
  }

}