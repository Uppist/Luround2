import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/password_settings/pword_textfield.dart';







class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final controller = Get.put(MoreController());
  final service = Get.put(SettingsService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      /*appBar: AppBar(
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
        title: CustomAppBarTitle(text: 'Change Password',),
      ),*/
      body: Obx(
        () {
          return service.isLoading.value ? Loader() : SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        'Change Password',
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
              
                SizedBox(height: 10.h),
                Container(
                  color: AppColor.greyColor,
                  width: double.infinity,
                  height: 7.h,
                ),
                SizedBox(height: 10.h,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Text(
                          "Current Password",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor, 
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SettingsPasswordTextField(
                          onChanged: (p0) {},
                          hintText: 'Current password',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          textController: controller.currentPasswordController,
                          isObscured: false,
                        ),
                        SizedBox(height: 40.h,),
                        Text(
                          "New Password",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor, 
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SettingsPasswordTextField(
                          onChanged: (p0) {},
                          hintText: 'New password',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          textController: controller.newPasswordController,
                          isObscured: false,
                        ),
                        SizedBox(height: 40.h,),
                        Text(
                          "Confirm New Password",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor, 
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SettingsPasswordTextField(
                          onChanged: (p0) {},
                          hintText: 'Confirm new password',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          textController: controller.confirmNewPasswordController,
                          isObscured: false,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.40),
                        ReusableButton(
                          color: AppColor.mainColor,
                          text: 'Change password',
                          onPressed: () {
                            if(controller.currentPasswordController.text.isNotEmpty && controller.newPasswordController.text.isNotEmpty && controller.confirmNewPasswordController.text.isNotEmpty) {
                              if(controller.newPasswordController.text == controller.confirmNewPasswordController.text) {
                                service.changeUserLuroundPassword(
                                  context: context, 
                                  old_password: controller.currentPasswordController.text, 
                                  new_password: controller.newPasswordController.text
                                );
                              }
                              else {
                                showMySnackBar(
                                  context: context,
                                  backgroundColor: AppColor.redColor,
                                  message: "password mis-match, please re-check"
                                );
                              }
                            }
                            else{
                              showMySnackBar(
                                context: context,
                                backgroundColor: AppColor.redColor,
                                message: "fields must not be empty"
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),  
              ]
            ),
          );
        }
      )
    );
  }
}