import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class SettingsSelector extends StatefulWidget {

  const SettingsSelector({super.key, required this.text, required this.onFlip});
  final String text;
  final VoidCallback onFlip;

  @override
  State<SettingsSelector> createState() => _SettingsSelectorState();
}

class _SettingsSelectorState extends State<SettingsSelector> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFlip,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor, 
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ),
              ),    
              Icon(
                CupertinoIcons.forward, 
                color: AppColor.blackColor, 
                size: 25,
              ) 
            ],
          ),
          SizedBox(height: 20.h,),
          Divider(thickness: 0.6, color: Colors.grey.withOpacity(0.7),)
        ],
      ),
    );
  }
}


//for customize url screen
class SettingsSelector2 extends StatefulWidget {

  const SettingsSelector2({super.key, required this.text, required this.onFlip});
  final String text;
  final VoidCallback onFlip;

  @override
  State<SettingsSelector2> createState() => _SettingsSelector2State();
}

class _SettingsSelector2State extends State<SettingsSelector2> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFlip,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor, 
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  /////////COMING SOON//////////////
                  SizedBox(width: 20.w,),
                  Image.asset("assets/images/c_s.png", filterQuality: FilterQuality.high,)
                  /*Container(
                    //padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 110.w, //130.w
                    decoration: BoxDecoration(
                      color: AppColor.redColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      'coming soon',
                      style: GoogleFonts.inter(
                        color: AppColor.bgColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),*/
                  ////////////////////////////////////////
                  
                ],
              ),    
              Icon(
                CupertinoIcons.forward, 
                color: AppColor.blackColor, 
                size: 25,
              ) 
            ],
          ),
          SizedBox(height: 20.h,),
          Divider(thickness: 0.6, color: Colors.grey.withOpacity(0.7),)
        ],
      ),
    );
  }
}