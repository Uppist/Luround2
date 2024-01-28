import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/billings/subscription_screen.dart';
import 'package:luround/views/account_owner/more/widget/more_screen/logout_dialogue.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/PIN_settings/pin_management_options.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/add_bank_details/bank_details_page.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/customize_your_url/customize_url.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/password_settings/change_password_screen.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/settings_selector.dart';






class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        title: CustomAppBarTitle(text: 'Settings',),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.h),
          Container(
            color: AppColor.greyColor,
            width: double.infinity,
            height: 7.h,
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SettingsSelector(
                  text: "Change login password",
                  onFlip: () {
                    Get.to(() => ChangePasswordScreen());
                  },
                ),
                /*SizedBox(height: 20.h,),
                SettingsSelector(
                  text: "Withdrawal PIN management",
                  onFlip: () {
                    Get.to(() => PinManagementOptions());
                  },
                ),*/
                SizedBox(height: 20.h,),
                SettingsSelector(
                  text: "Your bank account details",
                  onFlip: () {
                    Get.to(() => BankDetailsPage());
                  },
                ),
                SizedBox(height: 20.h,),
                SettingsSelector(
                  text: "Pricing",
                  onFlip: () {
                    //Get.to(() => SubscriptionScreen());
                  },
                ),
                SizedBox(height: 20.h,),
                SettingsSelector(
                  text: "Customize your URL",
                  onFlip: () {
                    //Get.to(() => CustomizeYourURLPage());
                  },
                ),
                SizedBox(height: 20.h,),
                TextButton(
                  onPressed: () {
                    logoutDialogue(context: context);
                  },
                  child: Text(
                    'Log out',
                    style: GoogleFonts.inter(
                      color: AppColor.redColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  )
                )
              ],
            ),
          )
        ]
      )
    );
  }
}