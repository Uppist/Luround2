import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/page/first_page.dart';
import 'package:luround/views/account_owner/auth/screen/onboarding/page/second_page.dart';
import 'package:luround/views/account_owner/auth/screen/registration/pages/second_page.dart';
import '../../views/account_owner/auth/screen/onboarding/page/third_page.dart';






class AuthController extends getx.GetxController {

  //ONBOARDING SECTION//
  final List<Widget> pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];

  //REGISTRATION SECTION//
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();


  var isFirstPageButtonEnabled = true;
  var isSecondPageButtonEnabled = true;

  bool seePassword = false;
  bool seeConfirmPassword = false;
  var isLoading = false.obs;


  String? validateFirstName() {
    if (GetUtils.isLengthLessThan(firstNameController.text.trim(), 3)) {
      return "First name is too short";
    } 
    print("nice one my geee!!!");
    return null;
  }

  String? validateLastName() {
    if (GetUtils.isLengthLessThan(lastNameController.text.trim(), 3)) {
      return "Last name is too short";
    }
    print("nice one my geee!!!");
    return null;
  }


  String? validateEmail({required String value}) {
    if (!GetUtils.isEmail(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validatePassword() {
    if (GetUtils.isLengthLessThan(passwordController.text.trim(), 6)) {
      return "Password must be of 6 characters or more";
    } 
    print("nice one my geee!!!");
    return null;
  }

  String? validateConfirmPassword() {
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      return "Passwords do not match";
    }
    print("nice one my geee!!!");
    return null;
  }

  checkFirstPageCredentials() {
    final isValid = formKey1.currentState!.validate();
    if(!isValid) {
      return "Invalid Credentials";
    }
    print("Nice. Credentilas are valid!!");
    Get.to(()=> RegisterPage2());
    return formKey1.currentState!.save();
  }

  checkSecondPageCredentials() {
    final isValid = formKey2.currentState!.validate();
    if(!isValid) {
      return "Invalid Credentials";
    }
    print("Nice. Credentilas are valid!!");
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    return formKey2.currentState!.save();
  }


  //LOGIN SECTION
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  var loginFormKey = GlobalKey<FormState>();

  var isLoginPageButtonEnabled = true;

  bool seeLoginPassword = false;

  String? validateLoginEmail({required String value}) {
    if (!GetUtils.isEmail(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validateLoginPassword() {
    if (GetUtils.isLengthLessThan(loginPasswordController.text.trim(), 6)) {
      return "Password must be of 6 characters or more";
    } 
    print("nice one my geee!!!");
    return null;
  }

  checkLoginCredentials() {
    final isValid = loginFormKey.currentState!.validate();
    if(!isValid) {
      return "Invalid Credentials";
    }
    print("Nice. Credentilas are valid!!");
    loginEmailController.clear();
    loginPasswordController.clear();
    return loginFormKey.currentState!.save();
  }
  
 













  @override
  void onClose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.onClose();
  }


}