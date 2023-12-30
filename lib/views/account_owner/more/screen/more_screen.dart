import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/screen/more_screen_selector.dart';
import 'package:luround/views/account_owner/more/widget/feed_back/feedback_screen.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/quotes_screen/sent_qoutes/sent_quote_screen.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/main_screen/main_screen.dart';
import 'package:luround/views/account_owner/more/widget/notifications/notification_settings_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/transactions_screen.dart';
import '../widget/settings/screen/settings_screen.dart';









class MorePage extends StatelessWidget {
  MorePage({super.key});

  var controller = Get.put(MoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor, //.greyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: SvgPicture.asset("assets/svg/notify_active.svg"),
                      ),
                    ]
                  ),*/
                  SizedBox(height: 20.h,), //40
                    Center(
                      child: Text(
                        "More",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                ]
              )
            ),
            SizedBox(height: 10.h,),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 20.h, //7.h
            ),

            ////ROWS HERE//
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h,),
                  MoreSelector(
                    text: 'Transactions',
                    svgAsset: 'assets/svg/transaction_new.svg',
                    onTap: () {
                      Get.to(() => TransactionPage());
                    },
                  ),
                  SizedBox(height: 20.h,),
                  MoreSelector(
                    text: 'Financials',
                    svgAsset: 'assets/svg/financials_new.svg',
                    onTap: () {
                      Get.to(() => FirstScreenForFinancials());
                    },
                  ),
                  SizedBox(height: 20.h,),
                  MoreSelector2(
                    text: 'CRM',
                    svgAsset: 'assets/svg/crm_new.svg',
                    onTap: () {},
                  ),
                  SizedBox(height: 20.h,),
                  MoreSelector(
                    text: 'Notifications',
                    svgAsset: 'assets/svg/notifications_new.svg',
                    onTap: () {
                      Get.to(() => NotificationSettingScreen());
                    },
                  ),
                  SizedBox(height: 20.h,),
                  MoreSelector(
                    text: 'Feedback',
                    svgAsset: 'assets/svg/feedback_new.svg',
                    onTap: () {
                      Get.to(() => FeedbackPage());
                    },
                  ),
                  SizedBox(height: 20.h,),
                  MoreSelector(
                    text: 'Settings',
                    svgAsset: 'assets/svg/settings_new.svg',
                    onTap: () {
                      Get.to(() => SettingsScreen());
                    },
                  ),                
                ],
              ),
            )

          ]
        )
      )
    );
  }
}