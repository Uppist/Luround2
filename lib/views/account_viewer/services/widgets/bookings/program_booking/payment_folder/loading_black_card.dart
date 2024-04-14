import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';



class LoadingBlackCardAccViewer extends StatelessWidget {
  const LoadingBlackCardAccViewer({super.key,});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      height: 250.h,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.blackColor,
        borderRadius: BorderRadius.circular(10.r),
        //gradient: LinearGradient(colors: colors)
      ),
      child: Loader()
    );
  }
}