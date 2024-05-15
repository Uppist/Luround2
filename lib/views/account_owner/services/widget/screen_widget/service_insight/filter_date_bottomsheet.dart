import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








//Bottomsheet Dialog
Future<void> filterByDateBottomSheet({
  required BuildContext context, 
  required VoidCallback onAlltimePressed,
  required VoidCallback onTodayPressed,
  required VoidCallback onYesterdayPressed,
  required VoidCallback onLast7daysPressed,
  required VoidCallback onLast30daysPressed,
}) async {
  
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
            width: double.infinity,
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
                  onTap: onAlltimePressed,
                  child: Text(
                    'All time',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
                SizedBox(height: 30.h,),
                //2
                InkWell(
                  onTap: onTodayPressed,
                  child: Text(
                    'Today',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
                SizedBox(height: 30.h,),
                //3
                InkWell(
                  onTap: onYesterdayPressed,
                  child: Text(
                    'Yesterday',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
                SizedBox(height: 30.h,),
                //4
                InkWell(
                  onTap: onLast7daysPressed,
                  child: Text(
                    'Last 7 days',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
                SizedBox(height: 30.h,),
                //5
                InkWell(
                  onTap: onLast30daysPressed,
                  child: Text(
                    'Last 30 days',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
                SizedBox(height: 30.h,),
              ]
            )
          )
        ]
      );
    }
  );
}