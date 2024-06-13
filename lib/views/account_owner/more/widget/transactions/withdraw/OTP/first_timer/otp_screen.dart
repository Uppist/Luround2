import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/reusable_button.dart';










class InputPinPage extends StatelessWidget {
  InputPinPage({super.key, required this.wallet_balance});
  final int wallet_balance;

  final service = Get.put(WithdrawalService());
  final controller = Get.put(TransactionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Obx(
        () {
          return service.isLoading.value ? const Loader() : SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Header
                /////////////
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColor.blackColor,
                        )
                      ),
                      SizedBox(width: 3.w,),
                      Text(
                        'Withdraw',
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
                /////////
                SizedBox(height: 10.h),
                Container(
                  color: AppColor.greyColor,
                  width: double.infinity,
                  height: 7.h,
                ),
                SizedBox(height: 20.h,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.h),
                          Text(
                            'Set a 4-digit pin for withdrawal',
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            )
                          ),
            
                          SizedBox(height: 60.h),
            
                          Focus(
                            child: OtpTextField(
                              keyboardType: TextInputType.number,
                              cursorColor: AppColor.textGreyColor,
                              numberOfFields: 4,
                              borderColor: AppColor.darkGreyColor,
                              enabledBorderColor: AppColor.textGreyColor,
                              //set to true to show as box or false to show as dash
                              showFieldAsBox: true,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //crossAxisAlignment: CrossAxisAlignment.start, 
                              borderRadius: BorderRadius.circular(5.r),
                              focusedBorderColor: AppColor.mainColor,
                              textStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: AppColor.textGreyColor
                              ),
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                //handle validation or checks here           
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode){
                                controller.firstTimeOTP.value = verificationCode;
                                print("otp 1: ${controller.firstTimeOTP.value}");
                              }, // end onSubmit
                            ),
                          ),
            
                          SizedBox(height: 460.h),
            
                          ReusableButton(
                            color: AppColor.mainColor,
                            text: 'Next',
                            onPressed: () async{
                              service.createWalletPin(
                                wallet_balance: wallet_balance,
                                context: context, 
                                wallet_pin: controller.firstTimeOTP.value,
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                        ]
                      )
                    )
                  )
                )
              ]
            ),
          );
        }
      )
    );
  }
}