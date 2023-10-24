import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/views/account_owner/profile/widget/reviews/review_empty_state.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';
import '../edit_about/edit_about_page.dart';
import '../edit_education/edit_education_page.dart';
import '../edit_photo/edit_photo_page.dart';








class AddSectionPage extends StatelessWidget {
  AddSectionPage({super.key});

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
        title: CustomAppBarTitle(text: 'Add Section',),
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
              //Photo
              InkWell(
                onTap: () {
                  Get.to(() => EditPhotoPage());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'Photo & Intro',
                      style: GoogleFonts.poppins(
                        color: AppColor.textGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ),
              Divider(color: AppColor.darkGreyColor, thickness: 0.2),
              //About
              InkWell(
                onTap: () {
                  Get.to(() => EditAboutPage());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'About',
                      style: GoogleFonts.poppins(
                        color: AppColor.textGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ),
              Divider(color: AppColor.darkGreyColor, thickness: 0.2),
              //education
              InkWell(
                onTap: () {
                  Get.to(() => EditEducationPage());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'Education & Certifications',
                      style: GoogleFonts.poppins(
                        color: AppColor.textGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ),
              Divider(color: AppColor.darkGreyColor, thickness: 0.2),
              //Others
              InkWell(
                onTap: () {
                  //Get.to(() => EditOthersPage());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'Others',
                      style: GoogleFonts.poppins(
                        color: AppColor.textGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ),
              Divider(color: AppColor.darkGreyColor, thickness: 0.2)

            ]
          )
        )
      )
    );
  }
}