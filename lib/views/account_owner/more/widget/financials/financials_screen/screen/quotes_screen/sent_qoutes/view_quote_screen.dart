import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class ViewQuoteScreen extends StatelessWidget {
  const ViewQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            ///Navigation Section////////////////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w,),
              //height: 70, //65
              width: double.infinity,
              color: AppColor.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),                   
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          CupertinoIcons.xmark,
                          color: AppColor.blackColor,
                        )
                      ),
                      SizedBox(width: 100.w,),
                      Text(
                        "Quote Preview",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),                                
                ],
              ),
            ),
            ////////////////////////////////////////////////
            //SizedBox(height: 20.h,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SENDER'S CONTAINER
                    Container(
                      //alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      width: double.infinity,
                      color: AppColor.bgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sent from:",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            "Japhet Alvin",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            "jay@gmail.com",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor.withOpacity(0.5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),

                    //RECEIVER'S CONTAINER
                    Container(
                      //alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      width: double.infinity,
                      color: AppColor.bgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sent to:",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          /*Text(
                            "Japhet Alvin",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),*/
                          //SizedBox(height: 10.h,),
                          Text(
                            "jaydddd@gmail.com",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor.withOpacity(0.5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h,),

                    //QUOTES DETAILS CONTAINER
                    Container(
                      //alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      width: double.infinity,
                      color: AppColor.bgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quote Details",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 60.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: AppColor.navyBlue,
                                  borderRadius: BorderRadius.circular(7.r)
                                ),
                                child: Text(
                                  'SENT',
                                  style: GoogleFonts.inter(
                                    color: AppColor.bgColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                              ),                    
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quote number:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                '#00000001',
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Valid till:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                '2023-04-112',
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand total:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                'N24,000',
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                              
                            ],
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}