import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/auth/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/forgot_password.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/password_link_expired.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/reset_password.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/textfields/fp_email_textfield.dart';










class PasswordLinkSentPage extends StatefulWidget {
  PasswordLinkSentPage({super.key});

  @override
  State<PasswordLinkSentPage> createState() => _PasswordLinkSentPageState();
}

class _PasswordLinkSentPageState extends State<PasswordLinkSentPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());
  late Timer _timer;
  int _secondsRemaining = 59;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 1) {
          _secondsRemaining--;
        } 
        else {
          // Timer reached 0 seconds, navigate to password expired screen
          timer.cancel(); // Stop the timer
          //Get.offUntil(GetPageRoute(page: () => PasswordLinkExpiredPage()), (route) => true);
          Get.to(() => PasswordLinkExpiredPage());
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          CupertinoIcons.xmark,
                          color: AppColor.blackColor,
                          size: 23,
                        ),
                      ),
                      SizedBox(width: 120.w,),
                      //SizedBox(width: MediaQuery.of(context).size.width / 3.8.w,),
                      Image.asset('assets/images/luround_logo.png')
                    ]
                  ),
                ]
              )
            ),
            SizedBox(height: 30.h,),
            //BODY SECTION//
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password ?",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "You will receive an email with an OTP to reset your password. Please check your inbox.",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGreyColor
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    //OTP TEXTFIELD WITH BUTTON
                    Container(
                      //height: 50.h, //80.h
                      //width: double.infinity,
                      //padding: EdgeInsets.symmetric(horizontal: 10.w),
                      color: AppColor.bgColor,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: FpEmailTextField(
                              validator: (val) {
                                return "HI";
                              },
                              onChanged: (val) {},
                              labelText: 'Enter six digits code',
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              textController: controller.otpController,
                            ),
                          ),
                          SizedBox(width: 20.w,),
                          InkWell(
                            onTap: () {
                              if(controller.otpController.text.isNum && controller.otpController.text.isNotEmpty) {
                                Get.offUntil(GetPageRoute(page: () => ResetPasswordPage()), (route) => false);
                              }
                              print("OTP FIELD IS EMPTY OR ISN'T A DIGIT");
                            },
                            child: Container(
                              //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              alignment: Alignment.center,
                              height: 45.h,
                              width: 100.w,  //double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius: BorderRadius.circular(10.r),
                                /*border: Border.all(
                                  color: AppColor.mainColor,
                                  width: 2.0,
                                )*/
                              ),
                              child: Text(
                                "Submit",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: AppColor.bgColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                )
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                    //SizedBox(height: 30.h,),

                    SizedBox(height: 400.h,),

                    //BOTTOM SECTION
                    Center(
                      child: Text(
                        "Password reset link will expire in ${_secondsRemaining}s",
                        style: GoogleFonts.inter(
                          color: AppColor.redColor,
                          fontStyle: FontStyle.italic,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive an email?",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textGreyColor
                          ),
                        ),
                        //SizedBox(width: 5,),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },             
                          child: Text(
                            "Resend email",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.mainColor
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
            ),

          ]
        )
      )    
    );
  }
}