import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;






class MoreController extends getx.GetxController {
  
  //[FEED BACK]//
  //text controllers
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isSubmit = false;
  //notifications setting screen
  bool isToggled = false;
  

  //[SETTINGS]//
  //change password
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  //change withdrawal pin
  final TextEditingController currentPINController = TextEditingController();
  final TextEditingController newPINController = TextEditingController();
  final TextEditingController confirmNewPINController = TextEditingController();
  //forgot withdrawal pin
  final TextEditingController newWithdrawalPINController = TextEditingController();
  final TextEditingController confirmNewWithdrawalPINController = TextEditingController();
  final TextEditingController otpForNewPinController = TextEditingController();











  @override
  void dispose() {
    // TODO: implement dispose
    subjectController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    currentPINController.dispose();
    newPINController.dispose();
    confirmNewPINController.dispose();
    newWithdrawalPINController.dispose();
    confirmNewWithdrawalPINController.dispose();
    otpForNewPinController.dispose();
    //descriptionController.dispose();
    super.dispose();
  }


}
  