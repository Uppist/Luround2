import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






///Alert Dialog
Future<void> filterDialogueBox({
  required BuildContext context,
  required VoidCallback onSentFilter,
  required VoidCallback onReceivedFilter,
  required VoidCallback onUpcomingFilter,
  required VoidCallback onPastFilter,
  required VoidCallback onCancelledFilter,
}) async {
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15)
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1
                InkWell(
                  onTap: onSentFilter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/sent.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Sent',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //2
                InkWell(
                  onTap: onReceivedFilter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/received.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Received',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //1
                InkWell(
                  onTap: onUpcomingFilter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/upcoming.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Upcoming',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //1
                InkWell(
                  onTap: onPastFilter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/past.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Past',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                //1
                InkWell(
                  onTap: onCancelledFilter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/cancelled.svg'),
                      SizedBox(width: 20.w),
                      Text(
                        'Cancelled',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                /////
              ],
            ),
          ),
        ],
      );
    }
  );
}