import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/profile_page_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';


class TextfieldFlipper extends StatefulWidget {
  const TextfieldFlipper({super.key, required this.text, required this.onFlip});
  final String text;
  final VoidCallback onFlip;

  @override
  State<TextfieldFlipper> createState() => _TextfieldFlipperState();
}

class _TextfieldFlipperState extends State<TextfieldFlipper> {

  var controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor, 
                fontSize: 14.sp
              ),
            ),
            InkWell(
              onTap: widget.onFlip,
              child: controller.isSuffixIconTapped2.value ? Icon(
                CupertinoIcons.chevron_up, 
                color: AppColor.textGreyColor, 
                size: 20,
              ) 
              :Icon(
                CupertinoIcons.chevron_down, 
                color: AppColor.textGreyColor, 
                size: 20,
              )
            )
          ],
        ),
        SizedBox(height: 13.h,),
        Divider(thickness: 0.8, color: AppColor.darkGreyColor,)
      ],
    );
  }
}