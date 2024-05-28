import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/profile/profile_page_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class CustomFieldWidget extends StatelessWidget {
  CustomFieldWidget({super.key, required this.svgAssetName, required this.fieldName, required this.onCancel, required this.fieldWidget,});
  final String svgAssetName;
  final String fieldName;
  final VoidCallback onCancel;
  final Widget fieldWidget;
  //final Key? keyy;


  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Icon
        SvgPicture.asset(svgAssetName), 
        SizedBox(width: 15.w,),
        //expanded column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //textfield
              fieldWidget,
              SizedBox(height: 20.h,),
              //textfield name
              Text(
                fieldName,
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 15.sp,
                  //fontWeight: FontWeight.w500
                )
              ),
              //divider widget
              //SizedBox(height: 4,),
              
            ]
          ),
        ),
        /*SizedBox(width: 5.w,),
        //cancelIcon
        IconButton(
          onPressed: onCancel, 
          icon: Icon(
            CupertinoIcons.xmark,
            color: AppColor.blackColor,
            //size: 24
          )
        ),*/
        /*InkWell(
          onTap: onCancel,
          child: SvgPicture.asset("assets/svg/cancel_icon.svg")
        ),*/
      ],
    );
  }
}