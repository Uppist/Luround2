import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_2/widget/bank_field_flipper_2.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_2/widget/select_bank_screen_for_tab2.dart';






class AddAccountForSettings extends StatefulWidget {
  AddAccountForSettings({super.key,});

  @override
  State<AddAccountForSettings> createState() => _AddAccountForSettingsState();
}

class _AddAccountForSettingsState extends State<AddAccountForSettings> {

  var controller = Get.put(TransactionsController());
  var service = Get.put(WithdrawalService());

  @override
  void initState() {
    // TODO: implement initState
    controller.enterAccountNameController.addListener(() {
      setState(() {
        controller.isButtonActive.value = controller.enterAccountNameController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,

      body: 
          SingleChildScrollView(
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
                BankFieldFlipper2(
                  text: controller.enterBankController.text.isEmpty ? 'Tap to select' : controller.enterBankController.text,
                  onFlip: () {
                    setState(() {
                      controller.isBankSelected2.value = true;
                    });
                    
                    Get.to(() => SelectBankScreen2());

                    setState(() {
                      controller.isBankSelected2.value = false;
                    });
                    
                  },
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
                  onChanged: (p0) {},
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
                  onChanged: (p0) {},
                  hintText: "",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textController: controller.enterAccountNameController,
                ),

                SizedBox(height: 180.h,),
            
                RebrandedReusableButton(
                  textColor: controller.isButtonActive.value ? AppColor.bgColor : AppColor.darkGreyColor,
                  color: controller.isButtonActive.value ? AppColor.mainColor : AppColor.lightPurple, 
                  text: "Next",  //"Save"
                  onPressed: controller.isButtonActive.value ? 
                  () {
                    if(controller.enterBankController.text.isNotEmpty && controller.enterAccountNumberController.text.isNotEmpty && controller.enterAccountNameController.text.isNotEmpty) {
                      service.createBankDetailsForSettingsPage(
                        wallet_balance: 0, //somto will remove this
                        context: context, 
                        account_name: controller.enterAccountNameController.text, 
                        account_number: controller.enterAccountNumberController.text.trim(), 
                        bank_name: controller.enterBankController.text, 
                        country: controller.selectedCountryController.text.isNotEmpty ? controller.selectedCountryController.text : "No Country",
                        bank_code: controller.enterBankCodeController.text, //controller.bankCode.value
                      ).whenComplete(() {
                        controller.enterAccountNameController.clear();
                        controller.enterAccountNumberController.clear();
                        controller.enterBankController.clear(); 
                        controller.selectedCountryController.clear();
                        controller.enterBankCodeController.clear();
                        print("this function will create the bank details lowkey.");

                      });
                    }
                    else if (service.filteredSavedAccounts.length >= 2) {
                      showMySnackBar(
                        context: context,
                        backgroundColor: AppColor.redColor,
                        message: "you can only create a maximum of two bank accounts"
                      );
                    }
                    else {
                      showMySnackBar(
                        context: context,
                        backgroundColor: AppColor.redColor,
                        message: "fields must not be empty"
                      );
                    }
                  }
                  : () {
                    print('nothing');
                  },
                ),
                SizedBox(height: 20.h,),
              ]
            )
          )
        );
  }
}