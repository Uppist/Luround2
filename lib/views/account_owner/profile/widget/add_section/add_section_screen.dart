import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/views/account_owner/profile/widget/reviews/review_empty_state.dart';
import '../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';
import '../edit_about/edit_about_page.dart';
import '../edit_education/page/edit_education_page.dart';
import '../edit_others/edit_others_page.dart';
import '../edit_photo/edit_photo_page.dart';








class AddSectionPage extends StatelessWidget {
  AddSectionPage({super.key, required this.aboutUser, required this.displayName, required this.company, required this.occupation, required this.photoUrl, required this.logo_url});
  final String aboutUser;
  //final String firstName;
  //final String lastName;
  final String displayName;
  final String company;
  final String occupation;
  final String photoUrl;
  final String logo_url;

  var controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      /*appBar: AppBar(
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
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Header
              /////////////
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColor.blackColor,
                      )
                    ),
                    SizedBox(width: 3.w,),
                    Text(
                      'Add Section',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              /////////
              SizedBox(height: 10.h),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              SizedBox(height: 20.h,),
              //Photo
              InkWell(
                onTap: () {
                  Get.to(() => EditPhotoPage(
                    logo_url: logo_url,
                    displayName: displayName,
                    company: company,
                    occupation: occupation,
                    photoUrl: photoUrl,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'Photo & Intro',
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
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
                  Get.to(() => EditAboutPage(
                    about: aboutUser,
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'About',
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ),
              /*Divider(color: AppColor.darkGreyColor, thickness: 0.2),
              //education
              InkWell(
                onTap: () {
                  Get.to(() => EditEducationPage());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'Education & Certifications',
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ),*/
              Divider(color: AppColor.darkGreyColor, thickness: 0.2),
              //Others
              InkWell(
                onTap: () {
                  Get.to(() => EditOthersPage());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Container(
                    color: AppColor.bgColor,
                    child: Text(
                      'Others',
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
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