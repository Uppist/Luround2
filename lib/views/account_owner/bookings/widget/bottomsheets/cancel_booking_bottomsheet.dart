import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/meeting_cancelled_dialog.dart';








///Alert Dialog
Future<void> cancelBookingDialogueBox({required BuildContext context, required String serviceName}) async{
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cancel "${serviceName}"',
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 40.h),
                Text(
                  'Are you sure you want to cancel this booking ?',
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 40.h,),
                InkWell(
                  onTap: () {
                    meetingCancelledBookingDialogueBox(context: context);
                  },
                  child: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    alignment: Alignment.center,
                    height: 50.h,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.redColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColor.redColor
                      )
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.bgColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  )
                ),
                SizedBox(height: 25.h),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    alignment: Alignment.center,
                    height: 50.h,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColor.darkGreyColor
                      )
                    ),
                    child: Text(
                      "Do not cancel",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  )
                ),

                //SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      );
    }
  );
}