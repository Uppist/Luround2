import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/textfields/reset_password_textfield.dart';
import 'package:luround/views/account_owner/auth/screen/registration/google_signin_option.dart';
import 'package:luround/views/account_owner/auth/screen/registration/reg_password_textfield.dart';

import 'password_updated.dart';








class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      SizedBox(width: MediaQuery.of(context).size.width / 3,),
                      Image.asset('assets/images/luround_logo.png')
                    ]
                  ),
                ]
              )
            ),
            SizedBox(height: 30,),

            //BODY SECTION//
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reset Password",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Enter a new password to reset the password in your account.",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGreyColor
                      ),
                    ),
                    SizedBox(height: 40,),
                    //Form and textfields
                    Form(
                      key: controller.formKey2,
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
                          SizedBox(height: 20,),
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
                  
                    SizedBox(height: MediaQuery.of(context).size.height /2.2,),
          
                    RebrandedReusableButton(
                      textColor: controller.isresetfpButtonActivated ? AppColor.bgColor : AppColor.darkGreyColor,
                      color: controller.isresetfpButtonActivated ? AppColor.mainColor : AppColor.lightPurple, 
                      text: "Reset password",
                      onPressed: controller.isresetfpButtonActivated 
                      ? () {
                        Get.to(() => PasswordUpdatedPage());
                      }
                      : () {
                        print('nothing for you chief!!');
                      },
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              )
            ),
          ]
        )
      )
    );
  }
}