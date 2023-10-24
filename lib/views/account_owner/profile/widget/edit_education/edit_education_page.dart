import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'education_textfield.dart';










class EditEducationPage extends StatefulWidget {
  EditEducationPage({super.key});

  @override
  State<EditEducationPage> createState() => _EditEducationPageState();
}

class _EditEducationPageState extends State<EditEducationPage> {
  var controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Education & Certifications',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //About
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Education & Certification',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset("assets/svg/add_icon.svg"),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    //List view.builder that shows a list of all certificates from the user
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Certification name*',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Remove',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColor.textGreyColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    EducationTextField(
                      onChanged: (val) {},
                      initialValue: controller.educationController.text,
                      hintText: 'Certified Professional Specialist',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,                   
                    ),
                    SizedBox(height: 500,),  //500
                    ReusableButton(
                      color: AppColor.mainColor,
                      text: 'Save',
                      onPressed: () {},
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              )
            ]
          )
        )
      )
    );
  }
}