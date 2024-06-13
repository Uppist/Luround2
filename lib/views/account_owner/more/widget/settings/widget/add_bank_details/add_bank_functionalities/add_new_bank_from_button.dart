import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/add_bank_details/bank_api/select_bank.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/add_bank_details/bank_field_flipper_2.dart';






class AddAccountForSettings2 extends StatefulWidget {
  const AddAccountForSettings2({super.key,});

  @override
  State<AddAccountForSettings2> createState() => _AddAccountForSettings2State();
}

class _AddAccountForSettings2State extends State<AddAccountForSettings2> {

  //var controller = Get.put(TransactionsController());
  var service = Get.put(SettingsService());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Account details',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
        
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              
              RebrandedReusableButton(
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
              ),
              SizedBox(height: 20.h,),
            ]
          )
        ),
      )
    );
  }
}