import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';








///Alert Dialog
Future<void> meetingCancelledBookingDialogueBox({required BuildContext context,}) async{
  showDialog(
    /*isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    backgroundColor: AppColor.bgColor,*/
    //barrierColor: Theme.of(context).colorScheme.background,
    useSafeArea: true,
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r)
          )
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        content: Wrap(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meeting Cancelled"',
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30.h,),
                Text(
                  'This meeting has been cancelled. The other party will be informed of this change.',
                  style: GoogleFonts.poppins(
                    color: AppColor.darkGreyColor,
                    fontSize: 13.sp,
                    //fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30.h,),
                InkWell(
                  onTap: () {
                    Get.back(closeOverlays: true);
                  },
                  child: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    alignment: Alignment.center,
                    height: 50.h,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColor.mainColor
                      )
                    ),
                    child: Text(
                      "Okay",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.bgColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  )
                ),
                SizedBox(height: 10.h,),
        
              ],
            ),
          ],
        ),
      );
    }
  );
}