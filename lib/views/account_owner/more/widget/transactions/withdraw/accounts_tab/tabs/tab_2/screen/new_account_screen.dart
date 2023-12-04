import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_2/widget/bank_field_flipper_2.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_2/widget/select_bank_screen_2.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/transfer_screen.dart';





class AddNewAccount extends StatefulWidget {
  AddNewAccount({super.key});

  @override
  State<AddNewAccount> createState() => _AddNewAccountState();
}

class _AddNewAccountState extends State<AddNewAccount> {

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

      body: Obx(
        () {
          return service.isLoading.value ? const Loader() : SingleChildScrollView(
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
                    //obx will run the reactive state
                    controller.isBankSelected2.value = true;
                    
                    Get.to(() => SelectBankScreen2());
                    //obx will run the reactive state 
                    controller.isBankSelected2.value = false;
                    
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

                SizedBox(height: 210.h,),
            
                RebrandedReusableButton(
                  textColor: controller.isButtonActive.value ? AppColor.bgColor : AppColor.darkGreyColor,
                  color: controller.isButtonActive.value ? AppColor.mainColor : AppColor.lightPurple, 
                  text: "Next", 
                  onPressed: controller.isButtonActive.value ? 
                  () {
                    //save details to db and get to the next screen with inputs from the text controllers
                    service.createBankDetailsFromAddAccountTab(
                      context: context, 
                      account_name: controller.enterAccountNameController.text, 
                      account_number: controller.enterAccountNumberController.text.trim(), 
                      bank_name: controller.enterBankController.text, 
                      country: controller.selectedCountryController.text,
                    ).whenComplete(() => print("this function will create the bank details lowkey but will not clear the controllers because it would be used in the next screen"));
                  }
                  : () {
                    print('nothing');
                  },
                ),
                SizedBox(height: 10.h,),
              ]
            )
          );
        }
      )
    );
  }
}