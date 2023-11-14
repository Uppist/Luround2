import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class TrxEmptyState extends StatelessWidget {
  const TrxEmptyState({super.key, required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h,),
          SvgPicture.asset('assets/svg/no_transaction.svg'),
          SizedBox(height: 30.h,),
          Text(
            'No transactions yet',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 21.h,
                fontWeight: FontWeight.bold
              )
            )
          ),
          SizedBox(height: 15.h,),
          Text(
            "When you get bookingss, they'll\n                 show up here",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: AppColor.darkGreyColor,
                fontSize: 16.h,
                //fontWeight: FontWeight.bold
              )
            )
          ),
          SizedBox(height: 60.h,),
          //Refresh BUTTON
          InkWell(
            onTap: onRefresh,
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                'Refresh',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: AppColor.bgColor,
                    fontSize: 17.sp,
                    //fontWeight: FontWeight.w500
                  )
                )
              ),
            )
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}