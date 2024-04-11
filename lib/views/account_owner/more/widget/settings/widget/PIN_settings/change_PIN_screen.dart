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







class ChangePINScreen extends StatelessWidget {
  ChangePINScreen({super.key});

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
        title: CustomAppBarTitle(text: 'Change withdrawal PIN',),
      ),
      body: Obx(
        () {
          return service.isLoading.value ? Loader() : Column(
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
                        hintText: 'Current PIN',
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
                        hintText: 'New PIN',
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
                        hintText: 'Confirm new PIN',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        textController: controller.confirmNewPINController,
                        isObscured: false,
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.3),


                      ReusableButton(
                        color: AppColor.mainColor,
                        text: 'Change PIN',
                        onPressed: () {
                          if(controller.currentPINController.text.isNotEmpty && controller.confirmNewPINController.text.isNotEmpty && controller.newPINController.text.isNotEmpty) {
                            if(controller.newPINController.text == controller.confirmNewPINController.text) {
                              service.changeUserWalletPIN(
                                context: context, 
                                old_pin: controller.currentPINController.text.trim(), 
                                new_pin: controller.newPINController.text.trim(),
                              ).whenComplete(() {
                                controller.currentPINController.clear();
                                controller.newPINController.clear();
                                controller.confirmNewPINController.clear();
                              });
                            }
                            else{
                              showMySnackBar(
                                context: context,
                                backgroundColor: AppColor.redColor,
                                message: "pin mis-match, please re-check"
                              );
                            }
                          }
                          else {
                            showMySnackBar(
                              context: context,
                              backgroundColor: AppColor.redColor,
                              message: "fields must not be empty"
                            );
                          }
                        }              
                      ),
                      SizedBox(height: 20.h),

                    ],
                  ),
                ),
              ),  
            ]
          );
        }
      )
    );
  }
}