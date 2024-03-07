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






class PaystackClientService extends getx.GetxController {


   var baseService = getx.Get.put(BaseService());

  String _message = '';

  //bool hasUserPayed = false;

  Future<void> payWithPaystack({
    required BuildContext context, 
    required int realAmount, 
    //required String eventName,
    required String companyEmail,
    required VoidCallback  onNavigate,
  }) async{
    try {
      
      int randNum = Random().nextInt(4000000);
      String trxReference = "PAY_$randNum";
      double amount = (realAmount * 100) + (0.02 * (realAmount * 100));   //already added transaction charges

      //Charge Call
      final charge = Charge()
      ..email = companyEmail
      ..amount = amount.toInt()
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
        _message = "Successful! Ref: ${res.message}_${res.reference}";
        //call somto rest-api to save the success response
        //Get.to(() => TransactionSuccessfulPage());
        debugPrint("transaction successful: $_message");
        await verifyPaystackPayment(
          onNavigate: onNavigate,
          context: context, 
          trx_ref_number: trxReference
        );
      }
      else{
        _message = res.message;
        showMySnackBar(
          backgroundColor: AppColor.redColor,
          context: context ,
          message: _message
        );
        debugPrint("paystack error: $_message");
      }
    }
    catch (e) {
      debugPrint("error: $e");
    }
    update();
  }

  /////[VERIFY PAYMENT API]////// I.E, FOR SEARCHING OR FILTERING
  Future<dynamic> verifyPaystackPayment({
    required String trx_ref_number,
    required BuildContext context,
    required VoidCallback  onNavigate,
  }) async {
    
    try {
      http.Response res = await baseService.httpGet(endPoint: "payments/verify-payment?ref_id=$trx_ref_number",);
      if (res.statusCode == 200 || res.statusCode == 201) {

        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response body ==>${res.body}');
        debugPrint("payment verification api went through");
        //decode the response body here
        dynamic data = json.decode(res.body);
        //UserServiceModel userServiceModel = UserServiceModel.fromJson(jsonDecode(res.body));
        //return userServiceModel;
        showMySnackBar(
          backgroundColor: AppColor.greenColor,
          context: context ,
          message: "status code: ${res.statusCode} => payment verification successful"
        ).whenComplete(() => onNavigate);
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


}