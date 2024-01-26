import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';





class TrxDisplay extends StatelessWidget {
  const TrxDisplay({super.key, required this.service_id, required this.service_name, required this.amount, required this.affliate_user, required this.transaction_status, required this.transaction_ref, required this.transaction_date, required this.transaction_time});
  final String service_id;
  final String service_name;
  final String amount;
  final String affliate_user;
  final String transaction_status;
  final String transaction_ref;
  final int transaction_date;
  final String transaction_time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h,),
        //1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              service_name,
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "N$amount",
              style: GoogleFonts.inter(
                color: transaction_status == "SENT"
                ?AppColor.darkGreen
                :AppColor.redColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h,),
        //2
        Text(
          transaction_status == "SENT"
          ?"$transaction_ref | Received from $affliate_user"  //via LuroundPay
          :"$transaction_ref | Sent to $affliate_user",
          style: GoogleFonts.inter(
            color: AppColor.darkGreyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h,),
        Text(
          "${convertServerTimeToDate(transaction_date)} $transaction_time",   //17:30
          style: GoogleFonts.inter(
            color: AppColor.textGreyColor,
            fontSize: 14.sp,
            //fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}