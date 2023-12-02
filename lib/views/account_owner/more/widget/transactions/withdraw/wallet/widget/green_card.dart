import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class GreenCard extends StatelessWidget {
  const GreenCard({super.key, required this.walletBalance});
  final String walletBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: [
            AppColor.mainColor,
            AppColor.darkMainColor
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //wallet
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Wallet',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/svg/wallet.svg", width: 48.w, height: 48.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Balance',
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    walletBalance,
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}