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
import 'package:luround/views/account_owner/auth/screen/login/login_screen.dart';
import 'package:luround/views/account_owner/auth/screen/registration/google_signin_option.dart';
import 'package:luround/views/account_owner/auth/screen/registration/reg_password_textfield.dart';








class RegisterPage2 extends StatefulWidget {
  RegisterPage2({super.key});

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());
  var authService = Get.put(AuthService());

  @override
  void initState() {
    // Add a listener to the text controller
    /*controller.confirmPasswordController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isSecondPageButtonEnabled = controller.confirmPasswordController.text.isNotEmpty;
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              CupertinoIcons.xmark,
                              color: AppColor.blackColor,
                              size: 23,
                            ),
                          ),
                          SizedBox(width: 110.w),
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
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create your account",
                          style: GoogleFonts.inter(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackColor
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Almost there!",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkGreyColor
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        //Form and textfields
                        Form(
                          key: controller.formKey2,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RegPasswordTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validatePassword();
                                },    
                                labelText: "Password",
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                textController: controller.passwordController,
                                isObscured: controller.seePassword,                       
                              ),
                              SizedBox(height: 20.h,),
                              RegPasswordTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validateConfirmPassword();
                                },    
                                labelText: "Confirm Password",
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                textController: controller.confirmPasswordController,
                                isObscured: controller.seeConfirmPassword,                          
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        //Rich Text for reading terms and conditions
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "By clicking ",
                                  style: GoogleFonts.inter(
                                    color: AppColor.textGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                TextSpan(
                                  text: "Create account, ",
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                TextSpan(
                                  text: "you agree to Luround's ",
                                  style: GoogleFonts.inter(
                                    color: AppColor.textGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                TextSpan(
                                  text: "Terms of Service ",
                                  style: GoogleFonts.inter(
                                    color: AppColor.mainColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                  ),
                                  onEnter: (event) {
                                    print("hello");
                                  },
                                ),
                                TextSpan(
                                  text: "and ",
                                  style: GoogleFonts.inter(
                                    color: AppColor.textGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: GoogleFonts.inter(
                                    color: AppColor.mainColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                  ),
                                  onEnter: (event) {
                                    print("policy");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 50.h,),
                        RebrandedReusableButton(
                          textColor: controller.isSecondPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                          color: controller.isSecondPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                          text: "Create account",
                          onPressed: controller.isSecondPageButtonEnabled  
                          ? () {
                            controller.checkSecondPageCredentials();
                          }
                          : () {
                            print('nothing for you chief!!');
                          },
                        ),
                        SizedBox(height: 70.h,),
                        SignInWithGoogleWidget(
                          onGoogleSignIn: () {
                            controller.signInWithGoogleAuth();
                          },
                          onTextButton: () {
                            Get.offUntil(GetPageRoute(page: () => LoginPage()), (route) => false);
                          },
                          firstText: "Already have an account ?",
                          lastText: "Log in",
                        ),
                        SizedBox(height: 20.h,),

                      ],
                    ),
                  )
                ),
                
                //NEXT BUTTON HERE       
                /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: RebrandedReusableButton(
                    textColor: controller.isSecondPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                    color: controller.isSecondPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                    text: "Create account",
                    onPressed: controller.isSecondPageButtonEnabled  
                    ? () {
                      controller.checkSecondPageCredentials();
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