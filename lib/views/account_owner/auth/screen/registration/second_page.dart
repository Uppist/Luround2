import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
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

  @override
  void initState() {
    // Add a listener to the text controller
    controller.confirmPasswordController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isSecondPageButtonEnabled = controller.confirmPasswordController.text.isNotEmpty;
      });
    });
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
                      "Create your account",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Almost there!",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGreyColor
                      ),
                    ),
                    SizedBox(height: 40,),
                    //Form and textfields
                    Form(
                      key: GlobalKey(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegPasswordTextField(
                            errortext:  controller.passwordError.value.isEmpty
                            ? null
                            : controller.passwordError.value,
                            onChanged: (val) {
                              controller.clearPasswordError(val);
                            },
                            labelText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            textController: controller.passwordController,
                            isObscured: controller.seePassword,                          
                          ),
                          SizedBox(height: 20,),
                          RegPasswordTextField(
                            errortext:  controller.confirmPasswordError.value.isEmpty
                            ? null
                            : controller.confirmPasswordError.value,
                            onChanged: (val) {
                              controller.clearConfirmPasswordError(val);
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
                    SizedBox(height: 20,),
                    //Rich Text for reading terms and conditions

                    SizedBox(height: 60,),
                    SignInWithGoogleWidget(
                      onGoogleSignIn: () {},
                      onTextButton: () {},
                      firstText: "Already have an account ?",
                      lastText: "Login",
                    )

                  ],
                ),
              )
            ),
            

            
            //NEXT BUTTON HERE
            //pay button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RebrandedReusableButton(
                textColor: controller.isSecondPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                color: controller.isSecondPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                text: "Create account",
                onPressed: controller.isSecondPageButtonEnabled  
                ? () {
                  print("yayyyy");
                  controller.validateLastPage(context);
                }
                : () {
                  print('nothing for you chief!!');
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