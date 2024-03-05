import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class NoSavedAccounts extends StatelessWidget {
  const NoSavedAccounts({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColor.bgColor,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(height: 60.h,),
            SvgPicture.asset('assets/svg/no_acc.svg'),
            SizedBox(height: 30.h,),
            Text(
              'No saved account yet',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:'Click on the',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    TextSpan(
                      text:' "Add an account" ',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    TextSpan(
                      text:'\n           button to proceed',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.bold
                        )
                      )
                    ),
                  ]
                )
              ),
            ),
            SizedBox(height: 60.h,),
            //ADD SECTION BUTTON
            InkWell(
              onTap: onPressed,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w,),
                alignment: Alignment.center,
                height: 50.h,
                //width: 350.w,
                decoration: BoxDecoration(
                  color: AppColor. mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColor.mainColor
                  )
                ),
                child: Text(
                  'Add an account',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}