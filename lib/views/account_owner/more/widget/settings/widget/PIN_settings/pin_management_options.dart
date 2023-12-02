import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/PIN_settings/change_PIN_screen.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/PIN_settings/forgot_PIN_screen.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/settings_selector.dart';




class PinManagementOptions extends StatelessWidget {
  const  PinManagementOptions({super.key});

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
        title: CustomAppBarTitle(text: 'PIN Management',),
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
                  text: "Change withdrawal PIN",
                  onFlip: () {
                    Get.to(() => ChangePINScreen());
                  },
                ),
                SizedBox(height: 20.h,),
                SettingsSelector(
                  text: "Forgot  withdrawal PIN",
                  onFlip: () {
                    Get.to(() => ForgotPINScreen());
                  },
                ),
              ],
            ),
          )
        ]
      )
    );
  }
}