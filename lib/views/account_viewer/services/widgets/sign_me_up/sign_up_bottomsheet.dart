import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/border_button.dart';
import 'package:luround/utils/components/reusable_button.dart';
//import 'package:luround/views/account_owner/auth/screen/onboarding/screen/onboarding_screen.dart';
import 'package:luround/views/account_owner/auth/screen/splashscreen/splashscreen_1.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';








///Alert Dialog
Future<void> signMeUpBottomSheet({required BuildContext context}) async{
  showDialog(
    useSafeArea: true,
    context: context,
    barrierDismissible: false, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r)
          )
        ),
        backgroundColor: AppColor.bgColor,
        content: Wrap(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
              decoration: BoxDecoration(
                //image: DecorationImage(image: AssetImage(''),),
                color: AppColor.bgColor,
                /*borderRadius: BorderRadius.all(
                  Radius.circular(20)
                ),*/
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Cancel button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          //Get.back();
                          Get.offAll(() => MainPageAccViewer());
                        }, 
                        icon: Icon(CupertinoIcons.xmark),
                        iconSize: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Text(
                    "Create your own account",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                  SizedBox(height: 20.sp,),
                  Text(
                    "       By setting up your own\naccount, others can schedule\n      and book your services.",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  ReusableButton(
                    onPressed: () {
                      Get.offAll(() => SplashScreen1());
                    },
                    color: AppColor.mainColor,
                    text: 'Sign me up',
                  ),
                  SizedBox(height: 30.h,),
                  BorderButton(
                    onPressed: (){
                      Get.offAll(() => MainPageAccViewer());
                    },
                    text: "Remind me later",
                    textColor: AppColor.mainColor,
                  ),
                  SizedBox(height: 20.h,),
              
                ],
              ),
            ),
          ],
        ),
      );
    }
  );
}