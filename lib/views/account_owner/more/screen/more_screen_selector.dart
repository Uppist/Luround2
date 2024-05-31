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
              SizedBox(width: 20.w,),
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





class MoreSelector2  extends StatefulWidget {

  const MoreSelector2({super.key, required this.text, required this.onTap, required this.svgAsset});
  final String svgAsset;
  final String text;
  final VoidCallback onTap;

  @override
  State<MoreSelector2> createState() => _MoreSelector2State();
}

class _MoreSelector2State extends State<MoreSelector2> {

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
              SizedBox(width: 20.w,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor, 
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Image.asset("assets/images/c_s.png", filterQuality: FilterQuality.high,)
                        /*Container(
                          //height: 15.h,
                          decoration: BoxDecoration(
                            color: AppColor.redColor,
                            borderRadius: BorderRadius.circular(5.r)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5.w,),
                          alignment: Alignment.center,
                          child: Text(
                            'coming soon',
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor, 
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),*/
                      ],
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