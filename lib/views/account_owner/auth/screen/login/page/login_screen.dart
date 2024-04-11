import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/auth/authentication_controller.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/forgot_password.dart';
import 'package:luround/views/account_owner/auth/screen/login/login_with_google.dart';
import 'package:luround/views/account_owner/auth/screen/login/textfields/password_textfield.dart';
import 'package:luround/views/account_owner/auth/screen/login/textfields/textfield.dart';
import 'package:luround/views/account_owner/auth/screen/registration/pages/first_page.dart';









class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());
  var authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Obx(
        () {
          return authService.isLoading.value ? Loader() : SafeArea(
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
                        mainAxisAlignment: MainAxisAlignment.center, //start
                        children: [
                          /*InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              CupertinoIcons.xmark,
                              color: AppColor.blackColor,
                              size: 23,
                            ),
                          ),
                          SizedBox(width: 150.w),*/
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
                          "Log in to account",
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          "Welcome back!",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkGreyColor
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        //Form and textfields
                        Form(
                          key: controller.loginFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LoginTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validateLoginEmail(value: val!);
                                },
                                labelText: "Your email address",
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                textController: controller.loginEmailController,                          
                              ),
                              SizedBox(height: 20.h,),
                              PasswordTextField(
                                onChanged: (val) {},
                                /*validator: (val) {
                                  return controller.validateLoginPassword();
                                },*/   
                                labelText: "Input password",
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                textController: controller.loginPasswordController,
                                isObscured: controller.seeLoginPassword,                          
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        //Rich Text for reading terms and conditions
                        Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => ForgotPasswordPage());
                              //Get.to(() => PasswordUpdatedPage());
                              //Get.to(() => ResetPasswordPage());
                              //Get.to(() => PasswordLinkExpiredPage());
                            },
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                          ),
                        ),
                        SizedBox(height: 70.h,),
                        RebrandedReusableButton(
                          textColor: controller.isLoginPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                          color: controller.isLoginPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                          text: "Log in",
                          onPressed: controller.isLoginPageButtonEnabled  
                          ? () {
                            controller.checkLoginCredentials(context);
                          }
                          : () {
                            print('nothing for you chief!!');
                          },
                        ),
                        SizedBox(height: 70.h,),
                        LoginWithGoogleWidget(
                          onGoogleSignIn: () {
                            authService.signInWithGoogle(context: context);
                          },
                          onTextButton: () {
                            Get.off(() => RegisterPage1(), transition: Transition.rightToLeft);
                            //Get.to(() => RegisterPage1());
                          },
                          firstText: "Don't have an account?",
                          lastText: "Create account",
                        ),
                        SizedBox(height: 20.h,),
                

                      ],
                    ),
                  )
                ),
                //SizedBox(height: 90.h,),
              
                /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                  child: RebrandedReusableButton(
                    textColor: controller.isLoginPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                    color: controller.isLoginPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                    text: "Login",
                    onPressed: controller.isLoginPageButtonEnabled  
                    ? () {
                      controller.checkLoginCredentials();
                    }
                    : () {
                      print('nothing for you chief!!');
                    },
                  ),
                ),*/
                //SizedBox(height: 20.h,),
              ]
            )
          );
        }
      )
    );
  }
}