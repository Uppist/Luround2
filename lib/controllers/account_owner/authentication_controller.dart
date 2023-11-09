import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/page/first_page.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/page/second_page.dart';
import 'package:luround/views/account_owner/auth/screen/registration/second_page.dart';
import '../../views/account_owner/auth/screen/onboarding/page/third_page.dart';






class AuthController extends getx.GetxController {

  //ONBOARDING SECTION//
  final List<Widget> pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];

  //REGISTRATION PAGE//
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  var isFirstPageButtonEnabled = false;
  var isSecondPageButtonEnabled = false;

  bool seePassword = false;
  bool seeConfirmPassword = false;
 
  var firstNameError = "".obs;
  var lastNameError = "".obs;
  var emailError = "".obs;
  var passwordError = "".obs;
  var confirmPasswordError = "".obs;
  var isLoading = false.obs;
  
  clearFirstNameError(val) => firstNameError.value = "";
  clearLastNameError(val) => lastNameError.value = "";
  clearEmailError(val) => emailError.value = "";
  clearPasswordError(val) => passwordError.value = "";
  clearConfirmPasswordError(val) => confirmPasswordError.value = "";
  
  //validates first page of the registration section
  void validateFirstPage(BuildContext context) {
    if (GetUtils.isLengthLessThan(firstNameController.text.trim(), 3)) {
      passwordError.value = "First name is too short";
    } 
    else if (GetUtils.isLengthLessThan(lastNameController.text.trim(), 3)) {
      passwordError.value = "Last name is too short";
    } 
    else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = "Please enter a valid email address";
    }
    //finally, sign the user up!!
    else {Get.to(() => RegisterPage2());
      
    }
  }
  
  //validates last page of the registration section
  void validateLastPage(BuildContext context) {
    if (GetUtils.isLengthLessThan(passwordController.text.trim(), 8)) {
      passwordError.value = "Password is too short";
    } 
    else if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      confirmPasswordError.value = "Passwords do not match";
    }
    //finally, sign the user up!!
    else {
      //signUpFunction()
      print("nice one my geee!!!");
    }
  }
 













  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


}