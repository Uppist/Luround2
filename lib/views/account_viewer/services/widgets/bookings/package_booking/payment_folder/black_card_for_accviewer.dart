import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';



class BlackCardAccViewer extends StatelessWidget {
  const BlackCardAccViewer({super.key, required this.accountName, required this.accountNumber, required this.bank});
  final String accountName;
  final String accountNumber;
  final String bank;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      //height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.blackColor,
        borderRadius: BorderRadius.circular(10.r),
        //gradient: LinearGradient(colors: colors)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //bank
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Bank',
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                bank,
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          SizedBox(height: 60.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Account Number',
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                'Account Name',
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  accountNumber,
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              //wrap with expanded if the text does not over lap
              Text(
                accountName,
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600
                  
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}