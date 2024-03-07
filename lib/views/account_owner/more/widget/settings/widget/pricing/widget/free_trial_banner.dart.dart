import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class FreeTrialBanner extends StatefulWidget {
  FreeTrialBanner({super.key, required this.isCancelled});
  bool isCancelled;

  @override
  State<FreeTrialBanner> createState() => _FreeTrialBannerState();
}

class _FreeTrialBannerState extends State<FreeTrialBanner> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45.h, //40.h
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w,),
      color: AppColor.navyBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'You are currently on 30 days free trial plan',
              style: GoogleFonts.inter(
                color: AppColor.bgColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10.w,),
          InkWell(
            onTap: () {
              setState(() {
                widget.isCancelled = !widget.isCancelled;
              });
            },
            child: Icon(
              CupertinoIcons.xmark,
              color: AppColor.bgColor,
              size: 24.r,
            )
          ),
        ],
      ),
    );
  }
}