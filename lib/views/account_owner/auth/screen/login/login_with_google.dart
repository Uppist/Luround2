import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class LoginWithGoogleWidget extends StatelessWidget {
  const LoginWithGoogleWidget({super.key, required this.onGoogleSignIn, required this.onTextButton, required this.firstText, required this.lastText});
  final VoidCallback onGoogleSignIn;
  final VoidCallback onTextButton;
  final String firstText;
  final String lastText;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Or
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                width: 200.w,  // Adjust the width as needed
                child: Divider(
                  color: Colors.grey.withOpacity(0.6),
                  thickness: 0.5,
                ),
              ),
            ),
            SizedBox(width: 30.w,),
            Text(
              "OR",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.darkGreyColor,
              ),
            ),
            SizedBox(width: 30.w,),
            Expanded(
              child: SizedBox(
                width: 200.w,  // Adjust the width as needed
                child: Divider(
                  color: Colors.grey.withOpacity(0.6),
                  thickness: 0.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 60.h,),
        //Google button
        InkWell(
          onTap: onGoogleSignIn,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            alignment: Alignment.center,
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: AppColor.darkGreyColor
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/g_icon.png"),
                SizedBox(width: 15.w,),
                Text(
                  "Login with Google",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      //fontWeight: FontWeight.w500
                    )
                  )
                ),
              ],
            ),
          )
        ),
        SizedBox(height: 20.h,),
        //Row or text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              firstText,
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              )
            ),
            //SizedBox(width: 5),
            TextButton(
              onPressed: onTextButton,
              child: Text(
                lastText,
                style: GoogleFonts.inter(
                  color: AppColor.mainColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                )
              ),
            ),
          ],
        ),
      ],
    );
  }
}