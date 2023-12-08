import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/password_settings/pword_textfield.dart';







class ChangePINScreen extends StatelessWidget {
  ChangePINScreen({super.key});

  var controller = Get.put(MoreController());

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
        title: CustomAppBarTitle(text: 'Change withdrawal PIN',),
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
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Text(
                    "Current PIN",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor, 
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SettingsPasswordTextField(
                    onChanged: (p0) {},
                    hintText: '',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    textController: controller.currentPINController,
                    isObscured: false,
                  ),
                  SizedBox(height: 40.h,),
                  Text(
                    "New PIN",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor, 
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SettingsPasswordTextField(
                    onChanged: (p0) {},
                    hintText: '',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    textController: controller.newPINController,
                    isObscured: false,
                  ),
                  SizedBox(height: 40.h,),
                  Text(
                    "Confirm New PIN",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor, 
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SettingsPasswordTextField(
                    onChanged: (p0) {},
                    hintText: '',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    textController: controller.confirmNewPINController,
                    isObscured: false,
                  ),
                  SizedBox(height: 390.h),
                  ReusableButton(
                    color: AppColor.mainColor,
                    text: 'Change PIN',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),  
        ]
      )
    );
  }
}