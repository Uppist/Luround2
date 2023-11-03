import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/bookings_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/more_screen/coming_soon_dialogue.dart';
import 'package:luround/views/account_owner/more/widget/more_screen/custom_card.dart';
import 'package:luround/views/account_owner/more/widget/more_screen/logout_dialogue.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';







class MorePage extends StatelessWidget {
  MorePage({super.key});

  var controller = Get.put(BookingsController());

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/images/luround_logo.png'),
                      ),
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
            SizedBox(height: 20,),
            ////ROWS HERE///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/integrations.svg",
                        title: "Integrations",
                        onTap: () {
                          comingSoonDialogue(context: context);
                        },
                      ),
                      SizedBox(width: 10,),
                      CustomCard(
                        svgAsset: "assets/svg/finance.svg",
                        title: "Financials",
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  //row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/finance.svg",
                        title: "Transactions",
                        onTap: () {},
                      ),
                      SizedBox(width: 10,),
                      CustomCard(
                        svgAsset: "assets/svg/subscriptions.svg",
                        title: "Subscriptions",
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  //row 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/notification_more.svg",
                        title: "Notifications",
                        onTap: () {},
                      ),
                      SizedBox(width: 10,),
                      CustomCard(
                        svgAsset: "assets/svg/feedback.svg",
                        title: "Feedback",
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  //row 4                   
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        svgAsset: "assets/svg/logout.svg",
                        title: "Logout",
                        onTap: () {
                          logoutDialogue(context: context);
                        },
                      ),
                      SizedBox(width: 225,)
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