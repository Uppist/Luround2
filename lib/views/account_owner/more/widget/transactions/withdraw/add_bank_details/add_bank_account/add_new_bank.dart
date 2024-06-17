import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/add_bank_details/bank_api/fetch_banks.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/add_bank_details/bank_field_flipper_2.dart';









class AddAccountForTrx extends StatefulWidget {
  const AddAccountForTrx({super.key, required this.wallet_balance,});
  final int wallet_balance;

  @override
  State<AddAccountForTrx> createState() => _AddAccountForTrxState();
}

class _AddAccountForTrxState extends State<AddAccountForTrx> {

  final controller = Get.put(TransactionsController());
  final service = Get.put(SettingsService());
  final withdrawalService = Get.put(WithdrawalService());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              'Input or Select Bank*',
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              )
            ),
            SizedBox(height: 50.h,),
            Obx(
              () {
                return BankFieldFlipper2(
                  text: controller.selectedBank.value.isNotEmpty ? controller.selectedBank.value : 'Tap to select',
                  onFlip: () {          
                    Get.to(() => SelectBankScreenForTrx());                  
                  },
                );
              }
            ),
            SizedBox(height: 50.h),
            Text(
              'Account Number',
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              )
            ),
            //SizedBox(height: 50.h,),
            UtilsTextField(
              onChanged: (p0) {
                controller.enterAccountNumberController.text = p0;
                log("acc number ${controller.enterAccountNumberController.text}");
              },
              hintText: "",
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              textController: controller.enterAccountNumberController,
            ),
            SizedBox(height: 30.h),
            Text(
              'Account Name',
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              )
            ),
            //SizedBox(height: 50.h,),
            UtilsTextField(
              onChanged: (p0) {
                controller.enterAccountNameController.text = p0;
                log("acc name ${controller.enterAccountNameController.text}");
              },
              hintText: "",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              textController: controller.enterAccountNameController,
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.22),

            Obx(
              () {
                return withdrawalService.isLoading.value ? Loader2() : RebrandedReusableButton(
                  textColor: AppColor.bgColor,
                  color: AppColor.mainColor, 
                  text: "Next",  //"Save"
                  onPressed:() {
                    if(service.filteredSavedAccounts.length > 2) {
                      showMySnackBar(
                        context: context,
                        backgroundColor: AppColor.redColor,
                        message: "you can only create a maximum of two bank accounts"
                      ).whenComplete(() {
                        controller.enterAccountNameController.clear();
                        controller.enterAccountNumberController.clear();
                        controller.enterBankCodeController.clear();
                        controller.selectedBank.value = "";
                      });
                    }
                    else{
                      if(controller.selectedBank.value.isNotEmpty && controller.enterAccountNumberController.text.isNotEmpty && controller.enterAccountNameController.text.isNotEmpty) {
                        withdrawalService.createBankDetailsFromAddAccountTab(
                          wallet_balance: widget.wallet_balance,
                          context: context, 
                          account_name: controller.enterAccountNameController.text, 
                          account_number: controller.enterAccountNumberController.text.trim(), 
                          bank_name: controller.selectedBank.value, 
                          country: controller.selectedCountryController.text.isNotEmpty ? controller.selectedCountryController.text : "No Country",
                          bank_code: controller.enterBankCodeController.text, //controller.bankCode.value
                        ).whenComplete(() {
                          controller.enterAccountNameController.clear();
                          controller.enterAccountNumberController.clear();
                          controller.enterBankController.clear(); 
                          controller.selectedCountryController.clear();
                          controller.enterBankCodeController.clear();
                          controller.selectedBank.value = '';
                          log("this function will create the bank details lowkey.");
                
                        });
                      }
                      else {
                        showMySnackBar(
                          context: context,
                          backgroundColor: AppColor.redColor,
                          message: "fields must not be empty"
                        );
                      }
                    }
                    
                  }
                          
                
                );
              }
            ),
            SizedBox(height: 20.h,),
          ]
        )
      )
    );
  }
}