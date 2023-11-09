import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/authentication_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/auth/screen/registration/google_signin_option.dart';
import 'package:luround/views/account_owner/auth/screen/registration/reg_textfield.dart';
import 'package:luround/views/account_owner/auth/screen/registration/second_page.dart';





class RegisterPage1 extends StatefulWidget {
  RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {

  //Dependency injection/Composition
  var controller = Get.put(AuthController());

  @override
  void initState() {
    // Add a listener to the text controller
    controller.emailController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isFirstPageButtonEnabled = controller.emailController.text.isNotEmpty;
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
                      "Let's get you started",
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
                          RegTextField(
                            errortext:  controller.firstNameError.value.isEmpty
                            ? null
                            : controller.firstNameError.value,
                            onChanged: (val) {
                              controller.clearFirstNameError(val);
                            },
                            labelText: "First Name",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            textController: controller.firstNameController,                          
                          ),
                          SizedBox(height: 20,),
                          RegTextField(
                            errortext: controller.lastNameError.value.isEmpty
                            ? null
                            : controller.lastNameError.value,
                            onChanged: (val) {
                              controller.clearLastNameError(val);
                            },
                            labelText: "Last Name",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            textController: controller.lastNameController,                          
                          ),
                          SizedBox(height: 20,),
                          RegTextField(
                            errortext: controller.emailError.value.isEmpty
                            ? null
                            : controller.emailError.value,
                            onChanged: (val) {
                              controller.clearEmailError(val);
                            },
                            labelText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            textController: controller.emailController,                          
                          ),
                        ],
                      ),
                    ),

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
            //SizedBox(height: 50,),



            //NEXT BUTTON HERE
            //pay button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RebrandedReusableButton(
                textColor: controller.isFirstPageButtonEnabled ? AppColor.bgColor : AppColor.darkGreyColor,
                color: controller.isFirstPageButtonEnabled ? AppColor.mainColor : AppColor.lightPurple, 
                text: "Next",
                onPressed: controller.isFirstPageButtonEnabled  
                ? () {
                  print("yayyyy");
                  controller.validateFirstPage(context);
                  //Get.to(() => RegisterPage2());
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