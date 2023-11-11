import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/forgot_password/pages/forgot_password.dart';










class PasswordLinkExpiredPage extends StatefulWidget {
  PasswordLinkExpiredPage({super.key});

  @override
  State<PasswordLinkExpiredPage> createState() => _PasswordLinkExpiredPageState();
}

class _PasswordLinkExpiredPageState extends State<PasswordLinkExpiredPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Link Expired",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Password reset link expires every 60 seconds and can be used only once.",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                ],
              ),
            ),                     
            SizedBox(height: MediaQuery.of(context).size.height /1.5,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RebrandedReusableButton(
                textColor: AppColor.bgColor,
                color: AppColor.mainColor, 
                text: "Resend Email",
                onPressed: () {
                  Get.off(() => ForgotPasswordPage());
                },
              ),
            ),
            SizedBox(height: 20,),

          ]
        )
      )    
    );
  }
}