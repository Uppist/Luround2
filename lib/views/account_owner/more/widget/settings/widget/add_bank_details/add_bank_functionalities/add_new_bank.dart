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
import 'package:luround/views/account_owner/more/widget/settings/widget/add_bank_details/bank_api/select_bank.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/add_bank_details/bank_field_flipper_2.dart';





class AddAccountForSettings extends StatefulWidget {
  const AddAccountForSettings({super.key,});

  @override
  State<AddAccountForSettings> createState() => _AddAccountForSettingsState();
}

class _AddAccountForSettingsState extends State<AddAccountForSettings> {

  final withdrawalService = Get.put(WithdrawalService());
  final service = Get.put(SettingsService());


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
                  text: service.selectedBank.value.isNotEmpty ? service.selectedBank.value : 'Tap to select',
                  onFlip: () {          
                    Get.to(() => SelectBankScreenForSettings());                  
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
                service.enterAccountNumberController.text = p0;
                print("acc number ${service.enterAccountNumberController.text}");
              },
              hintText: "",
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              textController: service.enterAccountNumberController,
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
                service.enterAccountNameController.text = p0;
                print("acc name ${service.enterAccountNameController.text}");
              },
              hintText: "",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              textController: service.enterAccountNameController,
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.20),
            
            Obx(
              () {
                return service.isLoading.value ? Loader2() : RebrandedReusableButton(
                  textColor: AppColor.bgColor,
                  color: AppColor.mainColor,
                  text: "Save",  //"Save"
                  onPressed: () {
                
                    if(service.filteredSavedAccounts.length >= 2) {
                      showMySnackBar(
                        context: context,
                        backgroundColor: AppColor.redColor,
                        message: "you can only create a maximum of two bank accounts"
                      ).whenComplete(() {
                        service.enterAccountNameController.clear();
                        service.enterAccountNumberController.clear();
                        service.enterBankCodeController.clear();
                        service.selectedBank.value = "";
                      });
                    }
                    else {
                      if(service.selectedBank.value.isNotEmpty && service.enterAccountNumberController.text.isNotEmpty && service.enterAccountNameController.text.isNotEmpty) {
                        service.createBankDetails(
                          context: context,
                          account_name: service.enterAccountNameController.text, 
                          account_number: service.enterAccountNumberController.text.trim(), 
                          bank_name: service.selectedBank.value, 
                          country: "No Country",
                          bank_code: service.enterBankCodeController.text,
                        ).whenComplete(() {
                          service.enterAccountNameController.clear();
                          service.enterAccountNumberController.clear();
                          service.enterBankCodeController.clear();
                          service.selectedBank.value = "";
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
                    
                  },
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