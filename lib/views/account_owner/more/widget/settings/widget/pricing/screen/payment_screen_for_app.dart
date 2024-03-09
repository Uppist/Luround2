import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/monthly_sub.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/yearly_sub.dart';










class SubscriptionScreenInApp extends StatefulWidget {
  const SubscriptionScreenInApp({super.key,});

  @override
  State<SubscriptionScreenInApp> createState() => _SubscriptionScreenInAppState();
}

class _SubscriptionScreenInAppState extends State<SubscriptionScreenInApp> with SingleTickerProviderStateMixin {
  
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,  //darkMainColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            SizedBox(height: 10.h,),
            //navigation button
            Center(
              child: GestureDetector(
                onTap: () {
                  //Navigator.pop(context);
                  Get.back();
                },
                child: Icon(
                  CupertinoIcons.xmark_circle,
                  color: AppColor.bgColor,
                  size: 36.r,
                ),
              ),
            ),
            
            SizedBox(height: 10.h,),
            
            Center(
              child: Text(
                "Pricing Plan",
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
        
            SizedBox(height: 15.h),
            
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.w), //50.w
                    child: AnimatedContainer(
                      //padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                      //width: 500.w,
                      //height: 70.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.bgColor,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: AppColor.navyBlue)
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Column(
                        children: [
                          //added
                          TabBar(                    
                            physics: const BouncingScrollPhysics(),
                            indicatorPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                            indicatorColor: AppColor.navyBlue,
                            indicatorSize: TabBarIndicatorSize.tab,
                            //indicatorWeight: 0.1,
                            labelStyle: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.bgColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            unselectedLabelColor: AppColor.darkGreyColor,
                            labelColor: AppColor.bgColor,
                            //padding: EdgeInsets.symmetric(horizontal: 10),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: AppColor.navyBlue,
                              shape: BoxShape.rectangle,
                            ),
                            controller: tabController,
                            isScrollable: false,
                            tabs: const [
                              Tab(text: 'Monthly',),
                              Tab(text: 'Yearly',),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  SizedBox(height:20.h),
                    
                  //tabbar content here //wrap with future builder
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        MonthlySubscriptionPageApp(),
                        YearlySubscriptionPageApp()
                      ]
                    ),
                  ),
                  SizedBox(height:40.h),
                ]
              )
            )
            //
          
          ],
        ),
      )
    );
  }
}