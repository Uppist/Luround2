import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/screen/add_event_screen.dart';
import 'package:luround/views/account_owner/services/widget/retainer/add_service/screen/add_service_screen.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/screen/add_service_screen.dart';
import 'package:luround/views/account_owner/services/widget/one-off/time_based/add_service/screen/add_service_screen.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/channel/choose_service_type_container.dart';






class ChooseServiceTypePage extends StatelessWidget {
  const ChooseServiceTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: const CustomAppBarTitle(text: 'Services',),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
        
            SizedBox(height: 30.h,),
            Text(
              "Choose the type of service",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),
            ),

            //CUSTOM CONTAINER()
            SizedBox(height: 30.h,),
            ServiceTypeContainer(
              text: 'One-off',
              onTap: () {
                Get.to(() => const ChooseOneOffServiceTypePage());
              },
            ),
            SizedBox(height: 30.h,),
            ServiceTypeContainer(
              text: 'Retainer',
              onTap: () {
                Get.to(() => const AddPackageServiceScreen());
              },
            ),
            SizedBox(height: 30.h,),
            ServiceTypeContainer(
              text: 'Program',
              onTap: () {
                Get.to(() => const AddProgramServiceScreen());
              },
            ),
            SizedBox(height: 30.h,),
            ServiceTypeContainer(
              text: 'Event',
              onTap: () {
                Get.to(() => const AddEventScreen());
              },
            ),
          ]
        ),
      ),
    );
  }
}







class ChooseOneOffServiceTypePage extends StatelessWidget {
  const ChooseOneOffServiceTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: const CustomAppBarTitle(text: 'One-off Service',),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
        
            SizedBox(height: 30.h,),
            Text(
              "Choose the type of service",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),
            ),

            //CUSTOM CONTAINER()
            SizedBox(height: 30.h,),
            ServiceTypeContainer(
              text: 'Time-based',
              onTap: () {
                Get.to(() => const AddServiceScreen());
              },
            ),
            SizedBox(height: 30.h,),
            ServiceTypeContainer(
              text: 'Project based',
              onTap: () {
                //Get.to(() => const AddProjectBasedOneoffServiceScreen());
              },
            ),

          ]
        ),
      ),
    );
  }
}