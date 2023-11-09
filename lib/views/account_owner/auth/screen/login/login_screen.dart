import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/login/password_textfield.dart';
import 'package:luround/views/account_owner/auth/screen/login/textfield.dart';
import 'package:luround/views/account_owner/auth/screen/registration/google_signin_option.dart';









class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());

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
                      "Login to account",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Welcome back!",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGreyColor
                      ),
                    ),
                    SizedBox(height: 40,),
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
                            labelText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textController: controller.loginEmailController,                          
                          ),
                          SizedBox(height: 20,),
                          PasswordTextField(
                            onChanged: (val) {},
                            validator: (val) {
                              return controller.validateLoginPassword();
                            },    
                            labelText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            textController: controller.loginPasswordController,
                            isObscured: controller.seeLoginPassword,                          
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    //Rich Text for reading terms and conditions
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot password ?",
                          style: GoogleFonts.inter(
                            color: AppColor.redColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ),

                    SizedBox(height: 50,),
                    SignInWithGoogleWidget(
                      onGoogleSignIn: () {},
                      onTextButton: () {},
                      firstText: "Don't have an account ?",
                      lastText: "Create account",
                    ),
                    SizedBox(height: 60,),
          
                    RebrandedReusableButton(
                      textColor: controller.isLoginPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                      color: controller.isLoginPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                      text: "Login",
                      onPressed: controller.isLoginPageButtonEnabled  
                      ? () {
                        controller.checkLoginCredentials();
                        print("user logged in");
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