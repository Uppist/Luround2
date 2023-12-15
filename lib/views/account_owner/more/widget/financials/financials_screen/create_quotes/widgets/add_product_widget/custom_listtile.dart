import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class ServicesTile extends StatelessWidget {
  const ServicesTile({super.key, required this.leading, required this.productName});
  final Widget leading;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            leading,
            SizedBox(width: 5.w,),
            Text(
              productName,
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              )
            ),
          ],
        ),
        SizedBox(height: 5.h,),
        Divider(thickness: 0.6, color: Colors.grey.withOpacity(0.5),)
      ],
    );
  }
}