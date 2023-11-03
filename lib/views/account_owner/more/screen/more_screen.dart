import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/bookings_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';







class MorePage extends StatelessWidget {
  MorePage({super.key});

  var controller = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor, //controller.isServicePresent.value ? AppColor.bgColor : AppColor.greyColor,
      body: SafeArea(
        child: Container(
          //physics: NeverScrollableScrollPhysics(),
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
              ////
            ]
          )
        )
      )
    );
  }
}