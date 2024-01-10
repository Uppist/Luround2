import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class ServiceEmptyState extends StatelessWidget {
  const ServiceEmptyState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 240.h, //240.h
          color: AppColor.bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              //SizedBox(height: 30,),
              SizedBox(height: 60.h,),
              SvgPicture.asset('assets/svg/no_service.svg'),
              SizedBox(height: 60.h,),
              Text(
                'No services yet',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600
                  )
                )
              ),
              SizedBox(height: 15.h,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:'Click on',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    TextSpan(
                      text:' "Add Service" ',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    TextSpan(
                      text:'button to start \n             adding your services',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  ]
                )
              ),
              SizedBox(height: 60.h,),
              //ADD SECTION BUTTON
              InkWell(
                onTap: onPressed,
                child: Container(
                 //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: AppColor. mainColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.mainColor
                    )
                  ),
                  child: Text(
                    'Add Service',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: AppColor.bgColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      )
                    )
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}