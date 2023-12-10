import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class MoreSelector  extends StatefulWidget {

  const MoreSelector({super.key, required this.text, required this.onTap, required this.svgAsset});
  final String svgAsset;
  final String text;
  final VoidCallback onTap;

  @override
  State<MoreSelector> createState() => _MoreSelectorState();
}

class _MoreSelectorState extends State<MoreSelector> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(widget.svgAsset),
              SizedBox(width: 10.w,),
              Expanded(
                child: Row(
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
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Divider(thickness: 0.6, color: Colors.grey.withOpacity(0.7),)
        ],
      ),
    );
  }
}