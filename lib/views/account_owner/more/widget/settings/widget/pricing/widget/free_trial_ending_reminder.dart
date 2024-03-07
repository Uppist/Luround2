import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';






///Alert Dialog
Future<void> freeTrialEndsReminder({
  required BuildContext context,
  required String userName,
  required VoidCallback onSelectPlan,
  required VoidCallback onDismiss,
}) async{
  showDialog(
    barrierDismissible: true,
    /*backgroundColor: AppColor.bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r)
      )
    ),*/
    //useSafeArea: true,
    context: context, 
    builder: (context) {
      //"Wrap" can be removed
      return Wrap(
        children: [
          //the main widget for the bottomsheet
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              color: AppColor.navyBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '👋 Hey, $userName',
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600
                  )
                ),
                SizedBox(height: 20.h,),
                Text(
                  'just a friendly reminder that your 30 days free trial expires in 7 days. if you would like to continue to use our services after your trial expires, please update your plan information.',
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  )
                ),
                SizedBox(height: 60.h,),
                RebrandedReusableButton(
                  color: AppColor.bgColor, 
                  text: "Select a Plan", 
                  onPressed: onSelectPlan, 
                  textColor: AppColor.navyBlue,
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: TextButton(
                    onPressed: onDismiss, 
                    child: Text(
                      'Dismiss',
                      style: GoogleFonts.inter(
                        color: AppColor.bgColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.bgColor
                      )
                    ),
                  ),
                )
                      
              ],
            ),
          ),
        ],
      );
    }
  );
}