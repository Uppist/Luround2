import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/widget/bank_field_flipper.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/widget/select_bank_screen.dart';





class AddAccountPageFromButton extends StatefulWidget {
  AddAccountPageFromButton({super.key});

  @override
  State<AddAccountPageFromButton> createState() => _AddAccountPageFromButtonState();
}

class _AddAccountPageFromButtonState extends State<AddAccountPageFromButton> {

  var controller = Get.put(TransactionsController());
  var service = Get.put(WithdrawalService());

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
        title: CustomAppBarTitle(text: 'Withdraw',),
      ),
      body: Obx(
        () {
          return service.isLoading.value ? const Loader() : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.h),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              SizedBox(height: 20.h,),

              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //SizedBox(height: 30.h),
                        Text(
                          'Input or Select Bank*',
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          )
                        ),
                        SizedBox(height: 50.h,),
                        BankFieldFlipper(
                          text: controller.inputBankController.text.isEmpty ? 'Tap to select' : controller.inputBankController.text,
                          onFlip: () {

                            //obx will handle the reactive state
                            controller.isBankSelected.value = true;
                            
                            Get.to(() => SelectBankScreen());

                            //obx will handle the reactive state
                            controller.isBankSelected.value = false;
                            
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
                          textController: controller.inputAccountNumberController,
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
                          textController: controller.inputAccountNameController,
                        ),
                        
                        SizedBox(height: 300.h,),

                        ReusableButton(
                          color: AppColor.mainColor,
                          text: 'Save account',
                          onPressed: () {
                            service.createBankDetailsFromAddDetailsButton(
                              context: context, 
                              account_name: controller.inputAccountNameController.text, 
                              account_number: controller.inputAccountNumberController.text.trim(), 
                              bank_name: controller.inputBankController.text.isEmpty ? "Kuda Bank" : controller.inputBankController.text, 
                              country: controller.selectedCountryController.text,
                            ).whenComplete(() {
                              controller.inputAccountNameController.clear(); 
                              controller.inputAccountNumberController.clear();
                              controller.inputBankController.clear();
                              controller.selectedCountryController.clear();
                              Get.back();
                            });
                          },
                        ),
                        SizedBox(height: 10.h,),

                      ]
                    )
                  )
                )
              )

            ]
          );
        }
      )
    );
  }
}