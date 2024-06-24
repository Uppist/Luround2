import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/user_services/service_insight.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/extractors.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/services/screen/insight_empty_state..dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/service_insight/filter_button.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/service_insight/filter_date_bottomsheet.dart';







class ServiceInsightPage extends StatefulWidget {
  const ServiceInsightPage({super.key, required this.serviceId});
  final String serviceId;

  @override
  State<ServiceInsightPage> createState() => _ServiceInsightPageState();
}

class _ServiceInsightPageState extends State<ServiceInsightPage> {
  
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  RxInt booking_count = 0.obs;
  
  //GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> fetchData() async {
    try {
      List<InsightInfo> data = await userService.getServiceInsight(serviceId: widget.serviceId, booking_count: booking_count);
      userService.filterServiceInsightList.clear();
      userService.filterServiceInsightList.addAll(data);
      log('refreshed insight list: ${userService.filterServiceInsightList}');

    } catch (error) {
      log("Error fetching data: $error");
    } finally {
      log("done");
    }
  }


  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    await fetchData();
  }

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }
  

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
                  child: Obx(
                    () {
                      if (userService.isLoading.value) {
                        return const Loader();
                      }
                      if (userService.hasError.value) {
                        log("error ? : ${userService.hasError.value}");
                        return InsightEmptyState(
                          onPressed: () {
                            refresh();
                          },
                        );
                      }
                      if (userService.filterServiceInsightList.isEmpty) {
                        return InsightEmptyState(
                          onPressed: () {
                            refresh();
                          },
                        );
                      }
                      return 
                        RefreshIndicator.adaptive(
                          color: AppColor.greyColor,
                          backgroundColor: AppColor.mainColor,
                          key: _refreshKey,
                          onRefresh: () {
                            return refresh();
                          },
                          child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                                          onAlltimePressed: () {
                                            userService.filterInsightByPastDate()
                                            .whenComplete(() => Get.back());
                                          },
                                          onTodayPressed: () {
                                            userService.filterInsightByToday()
                                            .whenComplete(() => Get.back());
                                          },
                                          onYesterdayPressed: () {
                                            userService.filterInsightByYesterday()
                                            .whenComplete(() => Get.back());
                                          },
                                          onLast30daysPressed: () {
                                            userService.filterInsightByLastThirtyDays()
                                            .whenComplete(() => Get.back());
                                          },
                                          onLast7daysPressed: () {
                                            userService.filterInsightByLastSevenDays()
                                            .whenComplete(() => Get.back());
                                          },
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
                                              '-',
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
                                            Obx(
                                              () {
                                                return Text(
                                                  booking_count.value.toString(),
                                                  style: GoogleFonts.inter(
                                                    color: AppColor.blackColor,
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                );
                                              }
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
                                //physics: const BouncingScrollPhysics(),
                                physics: const NeverScrollableScrollPhysics(),
                                //padding: EdgeInsets.symmetric(horizontal: 20.w),
                                separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.3,),
                                itemCount: userService.filterServiceInsightList.length,
                                itemBuilder: (context, index){

                                  final data = userService.filterServiceInsightList[index];

                                  if (userService.filterServiceInsightList.isEmpty) {
                                    return InsightEmptyState(
                                      onPressed: () {
                                        refresh();
                                      },
                                    );
                                  }
                                  
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
                                            getFirstLetter(data.customer_name),
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
                                                convertServerTimeToDate(data.date_booked),
                                                style: GoogleFonts.inter(
                                                  color: AppColor.textGreyColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              SizedBox(height: 10.h,),
                                              Text(
                                                data.customer_name,
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
                                                    data.service_name,
                                                    style: GoogleFonts.inter(
                                                      color: AppColor.redColorOp,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  Text(
                                                    "${currency(context).currencySymbol} ${data.service_amount}",
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
                                                ),
                        );
                    }
                  )
                )
            

          ]
        )
      )
    );
  }
}
        