import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/more_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/feed_back/feedback_screen.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/financials_screen.dart';
import 'package:luround/views/account_owner/more/widget/integrations/coming_soon_dialogue.dart';
import 'package:luround/views/account_owner/more/widget/more_screen/custom_card.dart';
import 'package:luround/views/account_owner/more/widget/more_screen/logout_dialogue.dart';
import 'package:luround/views/account_owner/more/widget/notification_settings/notification_settings_screen.dart';
import 'package:luround/views/account_owner/more/widget/subscription/subscription_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/transactions_screen.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';









class MorePage extends StatelessWidget {
  MorePage({super.key});

  var controller = Get.put(MoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor, //controller.isServicePresent.value ? AppColor.bgColor : AppColor.greyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  ),
                ]
              )
            ),
            SizedBox(height: 20.h,),
            ////ROWS HERE///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/integrations.svg",
                        title: "Integrations",
                        onTap: () {
                          comingSoonDialogue(context: context);
                        },
                      ),
                      SizedBox(width: 20.w,),
                      CustomCard(
                        svgAsset: "assets/svg/finance.svg",
                        title: "Financials",
                        onTap: () {
                          Get.to(() => FinancialsPage());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  //row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/finance.svg",
                        title: "Transactions",
                        onTap: () {
                          Get.to(() => TransactionPage());
                        },
                      ),
                      SizedBox(width: 20.w,),
                      CustomCard(
                        svgAsset: "assets/svg/subscriptions.svg",
                        title: "Subscriptions",
                        onTap: () {
                          Get.to(() => SubscriptionScreen());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  //row 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/notification_more.svg",
                        title: "Notifications",
                        onTap: () {
                          Get.to(() => NotificationSettingScreen());
                        },
                      ),
                      SizedBox(width: 20.w,),
                      CustomCard(
                        svgAsset: "assets/svg/feedback.svg",
                        title: "Feedback",
                        onTap: () {
                          Get.to(() => FeedbackPage());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  //row 4                   
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/logout.svg",
                        title: "Logout",
                        onTap: () {
                          logoutDialogue(context: context);
                        },
                      ),
                      SizedBox(width: 20.w,),
                      Expanded(child: SizedBox(width: 190.w,))
                    ],
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