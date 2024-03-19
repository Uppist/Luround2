import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/controllers/account_owner/auth/authentication_controller.dart';
import 'package:luround/services/account_owner/auth_service/auth_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/login/page/login_screen.dart';
import 'package:luround/views/account_owner/auth/screen/registration/google_signin_option.dart';
import 'package:luround/views/account_owner/auth/screen/registration/textfields/reg_textfield.dart';






class RegisterPage1 extends StatefulWidget {
  RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());
  var authService = Get.put(AuthService());

  @override
  void initState() {
    // Add a listener to the text controller
    /*controller.emailController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isFirstPageButtonEnabled = controller.emailController.text.isNotEmpty;
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
                              Navigator.pop(context);
                            },
                            child: Icon(
                              CupertinoIcons.xmark,
                              color: AppColor.blackColor,
                              size: 23,
                            ),
                          ),
                          SizedBox(width: 150.w),
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
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Let's get you started",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkGreyColor
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        //Form and textfields
                        Form(
                          key: controller.formKey1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RegTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validateFirstName();
                                },
                                labelText: "Your first name",
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                textController: controller.firstNameController,                          
                              ),
                              SizedBox(height: 20.h,),
                              RegTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validateLastName();
                                },
                                labelText: "Your last name",
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                textController: controller.lastNameController,                          
                              ),
                              SizedBox(height: 20.h,),
                              RegTextField(
                                onChanged: (val) {},
                                validator: (val) {
                                  return controller.validateEmail(value: val!);
                                },
                                labelText: "Your email address",
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                textController: controller.emailController,                          
                              ),
                            ],
                          ),
                        ),
          
                        SizedBox(height: 60.h,),
                        RebrandedReusableButton(
                          textColor: controller.isFirstPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                          color: controller.isFirstPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                          text: "Next",
                          onPressed: controller.isFirstPageButtonEnabled  
                          ? () {
                            controller.checkFirstPageCredentials();
                            print("done");
                          }
                          : () {
                            print('nothing for you chief!!');
                          },
                        ),
                        SizedBox(height: 70.h),
                        SignInWithGoogleWidget(
                          onGoogleSignIn: () {
                            authService.signUpWithGoogle(context: context);
                          },
                          onTextButton: () {
                            Get.off(() => LoginPage());
                          },
                          firstText: "Already have an account?",
                          lastText: "Log in",
                        ),        
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  )
                ),
          
                /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: RebrandedReusableButton(
                    textColor: controller.isFirstPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                    color: controller.isFirstPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                    text: "Next",
                    onPressed: controller.isFirstPageButtonEnabled  
                    ? () {
                      controller.checkFirstPageCredentials();
                      print("done");
                    }
                    : () {
                      print('nothing for you chief!!');
                    },
                  ),
                ),
                SizedBox(height: 20.h,),*/
              ]
            )
          );
        }
      )
    );
  }
}