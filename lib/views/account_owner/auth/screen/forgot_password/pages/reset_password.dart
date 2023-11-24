import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/textfields/reset_password_textfield.dart';
import 'password_updated.dart';








class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());
  var authServices = Get.put(AuthService());

  @override
  void initState() {
    // Add a listener to the text controller
    /*controller.resetFpConfirmPasswordController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.resetFpConfirmPasswordController  = controller.resetFpConfirmPasswordControlle.text.isNotEmpty;
      });
    });*/
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Obx(
        () {
          return authServices.isLoading.value ? Loader() : SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///Header Section
                Container(
                  color: AppColor.bgColor,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              //Get.back();
                            },
                            child: Icon(
                              CupertinoIcons.xmark,
                              color: AppColor.blackColor,
                              size: 23,
                            ),
                          ),
                          SizedBox(width: 110.w,),
                          //SizedBox(width: MediaQuery.of(context).size.width / 3.8.w,),
                          Image.asset('assets/images/luround_logo.png')
                        ]
                      ),
                    ]
                  )
                ),
                SizedBox(height: 30.h,),

                //BODY SECTION//
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reset Password",
                          style: GoogleFonts.inter(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackColor
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          "Enter a new password to reset the password in your account.",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkGreyColor
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        //Form and textfields
                        Form(
                          key: controller.resetFpFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ResetPasswordTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validateResetPassword();
                                },    
                                labelText: "Password",
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                textController: controller.resetFpPasswordController,
                                isObscured: controller.seeResetFpPassword,                       
                              ),
                              SizedBox(height: 20.h,),
                              ResetPasswordTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validateResetConfirmPassword();
                                },    
                                labelText: "Confirm Password",
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                textController: controller.resetFpConfirmPasswordController,
                                isObscured: controller.seeResetFpConfirmPassword,                          
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 355.h,),
                        //SizedBox(height: MediaQuery.of(context).size.height /2.4.h,),
              
                        RebrandedReusableButton(
                          textColor: controller.isresetfpButtonActivated ? AppColor.bgColor : AppColor.darkGreyColor,
                          color: controller.isresetfpButtonActivated ? AppColor.mainColor : AppColor.lightPurple, 
                          text: "Reset password",
                          onPressed: controller.isresetfpButtonActivated 
                          ? () {
                            controller.resetUserPassword();
                          }
                          : () {
                            print('nothing for you chief!!');
                          },
                        ),
                        SizedBox(height: 20.h,),

                      ],
                    ),
                  )
                ),
              ]
            )
          );
        }
      )
    );
  }
}