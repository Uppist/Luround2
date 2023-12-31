import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/qoutes/requested_quotes/requested_quotes_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class ViewRequestedQuoteScreen extends StatelessWidget {
  ViewRequestedQuoteScreen({super.key});

  var controller = Get.put(RequestedQuotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: Container(
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
                            "Sent from:",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
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
                          SizedBox(height: 10.h,),
                          Text(
                            "+234 7040571471",
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
                              color: AppColor.darkGreyColor,
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
                                width: 70.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: AppColor.navyBlue,
                                  borderRadius: BorderRadius.circular(7.r)
                                ),
                                child: Text(
                                  'REQUEST',
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
                                "Service name:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                'Django Course',
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
                                "Appointment type:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                'In-Person',
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
                                "Budget/offer:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                'N60,000',
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
                    SizedBox(height: 20.h,),

                    //UPLOADED FILE
                    Container(
                      //alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      width: double.infinity,
                      color: AppColor.bgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Uploaded File",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          //TODO: FIND A PDF PACKAGE THAT CAN Display & READ PDF LINK GOTTEN FROM SERVER
                          //E.G CLOUDINARY PDF URL
                        ]
                      )
                    ),
   
                    SizedBox(height: 20.h,),

                    //VIEW NOTE CONTAINER
                    Obx(
                      () {
                        return InkWell(
                          onTap: () {
                            controller.isNoteTapped.value = !controller.isNoteTapped.value;
                          },
                          child: Container(
                            //alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                            width: double.infinity,
                            color: AppColor.bgColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Note",
                                      style: GoogleFonts.inter(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    controller.isNoteTapped.value
                                    ?Icon(
                                      CupertinoIcons.chevron_down,
                                      color: AppColor.blackColor,
                                    )
                                    :Icon(
                                      CupertinoIcons.chevron_forward,
                                      color: AppColor.blackColor,
                                    )
                                  ],
                                ),
                                //Note text
                                controller.isNoteTapped.value 
                                ?Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    Text(
                                      "gfhghchgchgjgj",
                                      style: GoogleFonts.inter(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                )
                                :SizedBox(),
                              ]
                            )
                          )
                        );
                      }
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