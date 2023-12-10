import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class NoPaymentMethodText extends StatelessWidget {
  const NoPaymentMethodText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "You have not added a payment method",
      style: GoogleFonts.inter(
        color: AppColor.blackColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600
      ),
    );
  }
}