import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/delete_account/delete_account_screen_2.dart';








class DeleteAccountScreen1 extends StatelessWidget {
  const DeleteAccountScreen1({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.h,),
            //Header
            /////////////
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
                    "Delete account",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),        
            SizedBox(height: 10.h,),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      //1
                      Text(
                        "Delete account permanently",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "You will permanently lose all your data on our database after deleting your account",
                        style: GoogleFonts.inter(
                          color: AppColor.textGreyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      
        
                      SizedBox(height: MediaQuery.of(context).size.height * 0.66),
                          
                      RebrandedReusableButton(
                        textColor: AppColor.bgColor,
                        color: AppColor.mainColor,
                        text: "Continue", 
                        onPressed: () {
                          Get.to(() => DeleteAccountScreen2());
                        }
                      ),
                              
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
            //
                      
          ]
        ),
      )
    );
  }
}