import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/login/login_screen.dart';








class PasswordUpdatedPage extends StatelessWidget {
  const PasswordUpdatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height /2.5,),
              Text(
                "Password Updated",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: 20,),
              Text(
                "Your password has been updated",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                )
              ),

              SizedBox(height: MediaQuery.of(context).size.height /2.6,),
              //
              RebrandedReusableButton(
                textColor: AppColor.bgColor,
                color: AppColor.mainColor, 
                text: "Login",
                onPressed: (){
                  Get.offUntil(GetPageRoute(page: () => LoginPage()), (route) => false);
                },
              ),
              //SizedBox(height: 20,),
            ]
          ),
        )
      )
    );
  }
}