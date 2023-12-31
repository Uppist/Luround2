import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class AddedServicesTile extends StatelessWidget {
  const AddedServicesTile({super.key, required this.productName, required this.price, required this.duration, required this.onTap});
  final String price;
  final String duration;
  final String productName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: GoogleFonts.inter(
                      color: AppColor.darkGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  SizedBox(height: 10.h,),
                  //rich text
                  RichText(
                    text: TextSpan(
                    children: [
                      //price
                      TextSpan(
                        text: "N$price",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      //duration
                      TextSpan(
                        text: "/$duration",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      //session
                      TextSpan(
                        text: " per session",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ]
                  ),
                )
              ],
            ),
            Icon(
              CupertinoIcons.chevron_forward,
              color: AppColor.blackColor,
            ),
            ],
          ),
          SizedBox(height: 20.h,),
          Divider(thickness: 0.6, color: Colors.grey.withOpacity(0.5),)
        ],
      ),
    );
  }
}