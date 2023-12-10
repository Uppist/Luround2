import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/profile_page_controller.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
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
                  color: AppColor.darkGreyColor, 
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