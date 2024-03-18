import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:get/get.dart' as getx;
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';








class PaystackClientService extends getx.GetxController {


  var baseService = getx.Get.put(BaseService());

  String _messageAuth = '';
  String _messageApp = '';



  Future<void> payWithPaystackForAuth({
    required BuildContext context, 
    required int realAmount, 
    //required String eventName,
    required String companyEmail,
  }) async{
    try {
      
      int randNum = Random().nextInt(4000000);
      String trxReference = "PAY_$randNum";
      double chargeFee = 100.00 * 100.00;
      double amount = (realAmount * 100);  //+ (0.015 * (realAmount * 100)) + chargeFee;   //already added transaction charges

      //Charge Call
      final charge = Charge()
      ..email = companyEmail
      ..amount = chargeFee.toInt()  //amount.toInt()
      //..transactionCharge = (0.03 * (realAmount * 100)).toInt()
      //logged in luround user bears paystack charges
      ..bearer = Bearer.SubAccount
      ..reference = trxReference;
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
        _messageAuth = "Successful! Ref: ${res.message}_${res.reference}";
        //call somto rest-api to save the success response
        //Get.to(() => TransactionSuccessfulPage());
        debugPrint("transaction successful: $_messageAuth");
        await verifyPaystackPaymentAuth(
          context: context, 
          trx_ref_number: trxReference
        );
      }
      else{
        _messageAuth = res.message;
        showMySnackBar(
          backgroundColor: AppColor.redColor,
          context: context ,
          message: _messageAuth
        );
        debugPrint("paystack error: $_messageAuth");
      }
    }
    catch (e) {
      debugPrint("error: $e");
    }
    update();
  }


  /////[VERIFY PAYMENT API]//////
  Future<dynamic> verifyPaystackPaymentAuth({
    required String trx_ref_number,
    required BuildContext context,
  }) async {
    
    try {
      http.Response res = await baseService.httpGet(endPoint: "payments/verify-payment?ref_id=$trx_ref_number",);
      if (res.statusCode == 200 || res.statusCode == 201) {

        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("payment verification api went through");
        //decode the response body here
        dynamic data = json.decode(res.body);
      
        showMySnackBar(
          backgroundColor: AppColor.darkGreen,
          context: context ,
          message: "status code: ${res.statusCode} => payment verification successful"
        );
        getx.Get.offAll(() => MainPage());
      }
      else {
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        showMySnackBar(
          backgroundColor: AppColor.redColor,
          context: context ,
          message: "status code: ${res.statusCode} : ${res.body} => payment verification failed"
        );
      }
    } 
    catch (e) {
      showMySnackBar(
        backgroundColor: AppColor.redColor,
        context: context ,
        message: "an error occured: $e"
      );
      throw Exception("$e");
    }
  } 




  



  ///////////////FOR IN-APP PAYMENT/////////////////////

  Future<void> payWithPaystackForApp({
    required BuildContext context, 
    required int realAmount, 
    required String companyEmail,
  }) async{
    try {
      
      int randNum = Random().nextInt(4000000);
      String trxReference = "PAY_$randNum";
      double chargeFee = 100.00 * 100;
      double amount = (realAmount * 100); // + (0.02 * (realAmount * 100)) + chargeFee;   //already added transaction charges

      //Charge Call
      final charge = Charge()
      ..email = companyEmail
      ..amount = chargeFee.toInt() //amount.toInt()
      //..transactionCharge = (0.03 * (realAmount * 100)).toInt()
      //logged in luround user bears paystack charges
      ..bearer = Bearer.SubAccount
      ..reference = trxReference;
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
        _messageApp = "Successful! Ref: ${res.message}_${res.reference}";
        //call somto rest-api to save the success response
        //Get.to(() => TransactionSuccessfulPage());
        debugPrint("transaction successful: $_messageApp");
        await verifyPaystackPaymentApp(
          context: context, 
          trx_ref_number: trxReference
        );
      }
      else{
        _messageApp = res.message;
        showMySnackBar(
          backgroundColor: AppColor.redColor,
          context: context ,
          message: _messageApp
        );
        debugPrint("paystack error: $_messageApp");
      }
    }
    catch (e) {
      debugPrint("error: $e");
    }
    update();
  }

  /////[VERIFY PAYMENT API]//////
  Future<dynamic> verifyPaystackPaymentApp({
    required String trx_ref_number,
    required BuildContext context,
  }) async {
    
    try {
      http.Response res = await baseService.httpGet(endPoint: "payments/verify-payment?ref_id=$trx_ref_number",);
      if (res.statusCode == 200 || res.statusCode == 201) {

        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("payment verification api went through");
        //decode the response body here
        dynamic data = json.decode(res.body);
        showMySnackBar(
          backgroundColor: AppColor.darkGreen,
          context: context ,
          message: "status code: ${res.statusCode} => payment verification successful"
        );
        getx.Get.back();
      }
      else {
        debugPrint('Response status code: ${res.statusCode}');
        debugPrint('this is response reason ==>${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.body}');
        showMySnackBar(
          backgroundColor: AppColor.redColor,
          context: context ,
          message: "status code: ${res.statusCode} : ${res.body} => payment verification failed"
        );
        //getx.Get.back();
      }
    } 
    catch (e) {
      showMySnackBar(
        backgroundColor: AppColor.redColor,
        context: context ,
        message: "an error occured: $e"
      );
      throw Exception("$e");
    }
  } 


}