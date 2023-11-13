import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/forgot_password.dart';










class PasswordLinkSentPage extends StatefulWidget {
  PasswordLinkSentPage({super.key});

  @override
  State<PasswordLinkSentPage> createState() => _PasswordLinkSentPageState();
}

class _PasswordLinkSentPageState extends State<PasswordLinkSentPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());


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
                      SizedBox(width: MediaQuery.of(context).size.width / 3.8.w,),
                      Image.asset('assets/images/luround_logo.png')
                    ]
                  ),
                ]
              )
            ),
            SizedBox(height: 30.h,),
            //BODY SECTION//
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forgot Password ?",
                    style: GoogleFonts.inter(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "You will receive an email with a link to reset your password. Please check your inbox.",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                ],
              ),
            ),                     
            //SizedBox(height: MediaQuery.of(context).size.height /1.55.h,),
            SizedBox(height: 530.h,),

            //BOTTOM SECTION
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Password reset link will expire in 0:59s",
                  style: GoogleFonts.inter(
                    color: AppColor.redColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 15.sp
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive an email?",
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
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
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.mainColor
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h,),

          ]
        )
      )    
    );
  }
}