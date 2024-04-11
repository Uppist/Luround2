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







class OTPPINScreen extends StatelessWidget {
  OTPPINScreen({super.key});

  var controller = Get.put(MoreController());
  var service = Get.put(SettingsService());

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
        title: CustomAppBarTitle(text: 'Forgot withdrawal PIN',),
      ),
      body: Obx(
        () {
          return service.isLoading.value ? Loader() : SafeArea(
            child: Column(
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
                        SizedBox(height: 40.h,),
                        Text(
                          "One Time Passcode (Check your Email)",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor, 
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        SettingsPasswordTextField(
                          onChanged: (p0) {},
                          hintText: 'Enter code',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textController: controller.otpForNewPinController,
                          isObscured: false,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.5),
                        ReusableButton(
                          color: AppColor.mainColor,
                          text: 'Change PIN',
                          onPressed: () {
                            if(controller.otpForNewPinController.text.isNotEmpty) {
                              service.resetUserWalletPIN(
                                context: context, 
                                new_pin: controller.newWithdrawalPINController.text, 
                                otp: controller.otpForNewPinController.text
                              );
                            }
                            else {
                              showMySnackBar(
                                context: context,
                                backgroundColor: AppColor.redColor,
                                message: "otp field must not be empty"
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