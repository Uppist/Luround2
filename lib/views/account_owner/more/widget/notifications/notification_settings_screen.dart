import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/notifications/custom_switch_cards.dart';
import 'package:luround/views/account_owner/more/widget/notifications/switch_widget.dart';







class NotificationSettingScreen extends StatelessWidget {

  NotificationSettingScreen({super.key});
   
  var controller = Get.put(MoreController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section/////
            /*Container(
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
            /////////////////////////////////////////////
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),*/
        
            //SizedBox(height: 20.h,),
            
            ///Navigation Section/////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w,),
              height: 70.h, //65
              width: double.infinity,
              color: AppColor.bgColor,
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
                    "Notifications",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            
            /////Expanded/////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSwitchCard(
                    title: "Push notification",
                    switchButton: SwitchWidget(isToggled: controller.isToggled),
                  ),
                  SizedBox(height: 30.h,),
                  Text(
                    "Meeting Notifications",
                    style: GoogleFonts.inter(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  CustomSwitchCard(
                    title: "New",
                    switchButton: SwitchWidget(isToggled: controller.isToggled),
                  ),
                  SizedBox(height: 25.h,),
                  CustomSwitchCard(
                    title: "Confirmations",
                    switchButton: SwitchWidget(isToggled: controller.isToggled),
                  ),
                  SizedBox(height: 25.h,),
                  CustomSwitchCard(
                    title: "Rescheduled",
                    switchButton: SwitchWidget(isToggled: controller.isToggled),
                  ),
                  SizedBox(height: 25.h,),
                  CustomSwitchCard(
                    title: "Cancelled",
                    switchButton: SwitchWidget(isToggled: controller.isToggled),
                  ),
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}