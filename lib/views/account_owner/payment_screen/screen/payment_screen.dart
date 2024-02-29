import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/payment_screen/widget/monthly_sub.dart';
import 'package:luround/views/account_owner/payment_screen/widget/yearly_sub.dart';



class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen
  ({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> with SingleTickerProviderStateMixin {
  
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
      backgroundColor: AppColor.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.h,),
          Text(
            "Pricing Plan",
            style: GoogleFonts.inter(
              color: AppColor.bgColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.w), //50.w
                  child: AnimatedContainer(
                    //padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                    padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                    //width: 500.w,
                    height: 70.h,
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
                      MonthlySubscriptionPage(),
                      YearlySubscriptionPage()
                    ]
                  ),
                ),
                SizedBox(height:40.h),
              ]
            )
          )
          //
        ],
      )
    );
  }
}