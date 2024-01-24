import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key, required this.onPressed,});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: AppColor.greyColor,
            width: double.infinity,
            height: 7.h,
          ),
          SizedBox(height: 110.h,),
          SvgPicture.asset('assets/svg/profile_empty.svg'),
          SizedBox(height: 30.h,),
          Text(
            'Page not found',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600
              )
            )
          ),
          SizedBox(height: 15.h,),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:"      Append /profile/'username' to the domain",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
                TextSpan(
                  text:' to "Redirect" ',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
                TextSpan(
                  text:'back to your\n          luround profile',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              ]
            )
          ),
          SizedBox(height: 70.h,),
          //ADD SECTION BUTTON
          /*InkWell(
            onTap: onPressed,
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              alignment: Alignment.center,
              height: 50.h,
              width: 350.w,
              decoration: BoxDecoration(
                color: AppColor. mainColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.mainColor
                )
              ),
              child: Text(
                'Refesh',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.bgColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  )
                )
              ),
            )
          )*/
        ],
      ),
    );
  }
}