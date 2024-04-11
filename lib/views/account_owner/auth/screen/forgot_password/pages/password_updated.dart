import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/login/page/login_screen.dart';








class PasswordUpdatedPage extends StatelessWidget {
  const PasswordUpdatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: MediaQuery.of(context).size.height /2.5.h,),
              SizedBox(height: 400.h,),
              Text(
                "Password Updated",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
                )
              ),
              SizedBox(height: 20,),
              Text(
                "Your password has been updated",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                )
              ),

              //SizedBox(height: MediaQuery.of(context).size.height /3.1.h,),
              SizedBox(height: 250.h,),
              //
              RebrandedReusableButton(
                textColor: AppColor.bgColor,
                color: AppColor.mainColor, 
                text: "Log in",
                onPressed: (){
                  Get.offAll(() => LoginPage(), transition: Transition.rightToLeft);
                },
              ),
              //SizedBox(height: 20,),
            ]
          ),
        )
      )
    );
  }
}