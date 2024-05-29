import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/filter_trx_button.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/trx_dashboard.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/trx_history_list.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/service_insight/filter_date_bottomsheet.dart';







class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});

  final service = Get.put(WithdrawalService());

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
            SizedBox(height: 10.h,),
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
                    "Transactions",
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
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TRX DASHBOARD
                      TrxDashBoard(),
                      
                      SizedBox(height: 30.h,),

                      //FILTER BUTTON
                      FilterTrxButton(
                        onTap: () {
                          filterByDateBottomSheet(
                            context: context,
                            onAlltimePressed: () {
                              service.filterTrxByPastDate().whenComplete(
                                () => Get.back()
                              );
                            },
                            onTodayPressed: () {
                              service.filterListByToday().whenComplete(
                                () => Get.back()
                              );
                            },
                            onYesterdayPressed: () {
                              service.filterListByYesterday().whenComplete(
                                () => Get.back()
                              );
                            },
                            onLast7daysPressed: () {
                              service.filterListByLastSevenDays().whenComplete(
                                () => Get.back()
                              );
                            },
                            onLast30daysPressed: () {
                              service.filterListByLastThirtyDays().whenComplete(
                                () => Get.back()
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 30.h,),

                      //List of transactions comes here and it's empty state // //Future building will be used here also
                      //TrxEmptyState(onRefresh: () {},),
                      TrxHistoryList(),
                      SizedBox(height: 15.h,),
                    ],
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}