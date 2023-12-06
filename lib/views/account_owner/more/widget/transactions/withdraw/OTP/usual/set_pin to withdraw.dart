import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/transfer_success_screen.dart';







class SetPinToWithdrawPage extends StatefulWidget {
  const SetPinToWithdrawPage({super.key, required this.amount, required this.bank, required this.accountName, required this.accountNumber});
  final String amount;
  final String bank;
  final String accountName;
  final String accountNumber;

  @override
  State<SetPinToWithdrawPage> createState() => _SetPinToWithdrawPageState();
}

class _SetPinToWithdrawPageState extends State<SetPinToWithdrawPage> {
  
  var controller = Get.put(TransactionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Confirm Transaction",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: AppColor.darkGreyColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Divider(color: AppColor.textGreyColor, thickness: 0.3,),
              SizedBox(height: 30.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "You are about to withdraw ",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "${widget.amount} ",
                      style: GoogleFonts.inter(
                        color: AppColor.mainColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "from your wallet to ",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "${widget.accountName} - ${widget.accountNumber} - ${widget.bank}",
                      style: GoogleFonts.inter(
                        color: AppColor.mainColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ]
                )
              ),
              SizedBox(height: 40.h,),
              Center(
                child: Text(
                  'Enter your 4-digit pin to confirm',
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
              SizedBox(height: 40.h,),
        
              ///[OTP TEXTFIELD]///
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
                    setState(() {
                      controller.enterTrxPinController.text = verificationCode;
                    });
                    print("result: ${controller.enterTrxPinController.text}");
                  }, // end onSubmit
                ),
              ),
              SizedBox(height: 440.h),
              ReusableButton(
                color: AppColor.mainColor,
                text: 'Withdraw',
                onPressed: () {
                  Get.to(() => TransferFundsSuccessScreen(amount: 'N5000',));
                },
              ),
              SizedBox(height: 20.h),
            ]
          ),
        ) 
      )
    );
  }
}