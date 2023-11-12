import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/textfields/fp_email_textfield.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/password_link_sent_screen.dart';









class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());

  @override
  void initState() {
    // Add a listener to the text controller
    /*controller.fpEmailController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isfpButtonActivated = controller.fpEmailController.text.isNotEmpty;
      });
    });*/
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
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
                      SizedBox(width: MediaQuery.of(context).size.width / 3.2.w,),
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
                      "Forgot Password ?",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      "Please enter your registered email address.",
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGreyColor
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    //Form and textfields
                    Form(
                      key: controller.fpFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FpEmailTextField(
                            onChanged: (val) {},
                            validator: (val) {
                              return controller.validateFpEmail(value: val!);
                            },
                            labelText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textController: controller.fpEmailController,                          
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ),
            //SizedBox(height: MediaQuery.of(context).size.height /1.75,),
          
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: RebrandedReusableButton(
                textColor: controller.isfpButtonActivated ? AppColor.bgColor : AppColor.darkGreyColor,
                color: controller.isfpButtonActivated ? AppColor.mainColor : AppColor.lightPurple, 
                text: "Next",
                onPressed: controller.isfpButtonActivated  
                ? () {
                  Get.to(() => PasswordLinkSentPage());
                }
                : () {
                  print('nothing for you chief!!');
                },
              ),
            ),
            SizedBox(height: 20.h,),
          ]
        )
      )
    );
  }
}