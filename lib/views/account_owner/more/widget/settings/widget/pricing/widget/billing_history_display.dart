import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class BillingHistoryDisplay extends StatelessWidget {
  const BillingHistoryDisplay({super.key, required this.payment_date, required this.plan_type, required this.amount});
  final String payment_date;
  final String plan_type;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5) ,//withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 0.2,
          )
        ],
        border: Border(
          bottom: BorderSide(
            color: AppColor.mainColor,
            width: 1.5, // Adjust the width as needed
          ),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h,),
          Text(
            payment_date,
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 10.h,),
          Divider(thickness: 0.3, color: Colors.grey,),
          SizedBox(height: 30.h,),
          //2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan_type,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                amount,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}


