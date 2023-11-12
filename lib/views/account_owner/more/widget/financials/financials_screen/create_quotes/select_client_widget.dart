import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class SelectClientWidget extends StatelessWidget {
  SelectClientWidget({super.key, required this.onTap, required this.clientName});
  final VoidCallback onTap;
  final String clientName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                clientName,
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Icon(
                CupertinoIcons.chevron_down,
                size: 20,
                color: AppColor.blackColor,
              )
            ],
          ),
        ),
        SizedBox(height: 3.h,),
        Divider(color: AppColor.textGreyColor, thickness: 0.5,)
      ],
    );
  }
}