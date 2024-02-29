import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:get/get.dart' as getX;
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:luround/utils/components/my_snackbar.dart';





class PaystackClientService extends getX.GetxController {


  String _message = '';
  //bool hasUserPayed = false;

  Future<void> payWithPaystack({
    required BuildContext context, 
    required int realAmount, 
    required String eventName,
    required String companyEmail,
  }) async{
    try {
      
      int randNum = Random().nextInt(4000000);
      double amount = (realAmount * 100) + (0.02 * (realAmount * 100));   //already added transaction charges

      //Charge Call
      final charge = Charge()
      ..email = companyEmail
      ..amount = amount.toInt()
      //..transactionCharge = (0.03 * (realAmount * 100)).toInt()
      //logged in luround user bears paystack charges
      ..bearer = Bearer.SubAccount
      ..reference = "Ref_${eventName}_$randNum";
      //..account!.bank;
      //..accessCode = 'jetify'

      //CheckOut Response
      final res = await PaystackClient.checkout(
        context, 
        charge: charge,
        fullscreen: false,
        logo: Image.asset('assets/images/luround_logo.png'),
        /*Icon(
          Icons.rocket_launch_outlined, 
          color:AppColor.blackColor,
          size: 40.r,
        ),*/
        hideAmount: false,
        hideEmail: false
      );
      if(res.status) {
        //hasUserPayed = true;
        _message = "Successful! Ref: ${res.message}_${res.reference}";
        //call somto rest-api to save the success response
        //Get.to(() => TransactionSuccessfulPage());
        debugPrint("transaction successful: $_message");
      }
      else{
        _message = res.message;
        showMySnackBar(
          backgroundColor: AppColor.redColor,
          context: context ,
          message: _message
        );
        debugPrint("error: $_message");
      }
    }
    catch (e) {
      debugPrint("error: $e");
    }
    update();
  }


}