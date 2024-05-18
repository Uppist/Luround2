import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/service_insight/filter_button.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/service_insight/filter_date_bottomsheet.dart';







class ServiceInsightPage extends StatelessWidget {
  const ServiceInsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[  
            //Header
            /////////////
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.blackColor,
                    )
                  ),
                  SizedBox(width: 3.w,),
                  Text(
                    "Service insight",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            ////////
            
            SizedBox(height: 20.h,),
        
            /////HERE/////////
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //FILTER BUTTON
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilterBookingButton(
                            onPressed: () {
                              filterByDateBottomSheet(
                                context: context,
                                onAlltimePressed: () {},
                                onTodayPressed: () {},
                                onYesterdayPressed: () {},
                                onLast30daysPressed: () {},
                                onLast7daysPressed: () {},
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //1
                          Expanded(
                            child: Container(
                              //height: 60.h,
                              //width: 200.w, //150.w
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.warningLightRedColor,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColor.warningLightRedColor
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '100',
                                    style: GoogleFonts.inter(
                                      color: AppColor.blackColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 30.h,),
                                  Text(
                                    'Clicks',
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ), 
                          ),
                          SizedBox(width: 20.w),
                          //2
                          Expanded(
                            child: Container(
                              //height: 60.h,
                              //width: 200.w, //150.w
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.warningDarkRedColor,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColor.warningDarkRedColor
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '10',
                                    style: GoogleFonts.inter(
                                      color: AppColor.blackColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 30.h,),
                                  Text(
                                    'Booked',
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ), 
                          ),
                                      
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'Booking History',
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Divider(color: AppColor.textGreyColor, thickness: 0.3,),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                    //list of bookings made for this particular service
                    ListView.separated( 
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      //padding: EdgeInsets.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.3,),
                      itemCount: 5,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //HEADER
                              CircleAvatar(
                                radius: 35.r,
                                backgroundColor: AppColor.mainColor,
                                child: Text(
                                  "A",
                                  style: GoogleFonts.inter(
                                    color: AppColor.bgColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.w,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "May 23, 2023",
                                      style: GoogleFonts.inter(
                                        color: AppColor.textGreyColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      "Anderson Trello",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blackColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Personal Training",
                                          style: GoogleFonts.inter(
                                            color: AppColor.redColorOp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          "${currency(context).currencySymbol} 3500",
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ]
                                    ),
                                  ],
                                ),
                              )
                            ]
                          ),
                        );
                      },
                    )
                  ]
                )
              )
            )

          ]
        )
      )
    );
  }
}
        