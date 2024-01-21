import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import 'package:luround/services/account_owner/data_service/base_service/base_service.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';








class InvoicePaymentService extends getx.GetxController {
  
  //inputs
  final TextEditingController amountTextController = TextEditingController();
  getx.RxString payment_method = "Card".obs;
  final listOfModeOfPayments = <String>["Card", "Transfer", "Others"];

  var baseService = getx.Get.put(BaseService());
  var isLoading = false.obs;
  var userId = LocalStorage.getUserID();
  var user_email = LocalStorage.getUseremail();
  var user_name = LocalStorage.getUsername();
  


  ///[ADD INVOICE PAYMENT TO MARK IT AS PAID]//
  Future<void> markInvoiceAsPaid({
    required BuildContext context,
    required String amount_paid,
    required String mode_of_payment,
    }) async {

    isLoading.value = true;

    var body = {
      "amount_paid": amount_paid,
      "payment_method": mode_of_payment
    };

    try {
      http.Response res = await baseService.httpPut(endPoint: "invoice/add-invoice-payment-detail", body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        debugPrint("invoice marked as paid successfully");
        amountTextController.clear();

        //success snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.darkGreen,
          message: "invoice has been marked as 'paid'"
        ).whenComplete(() => getx.Get.back());
      } 
      else {
        isLoading.value = false;
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        amountTextController.clear();
        //failure snackbar
        showMySnackBar(
          context: context,
          backgroundColor: AppColor.redColor,
          message: "failed to mark invoice as 'paid': ${res.body}"
        ).whenComplete(() => getx.Get.back());
      }
    } 
    catch (e) {
      isLoading.value = false;
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }

  




  @override
  void dispose() {
    // TODO: implement dispose
    amountTextController.dispose();
    super.dispose();
  }

}