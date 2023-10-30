import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/profile/screen/profile_empty_state.dart';
import 'package:luround/views/account_owner/profile/widget/add_section/add_section_screen.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/edit_education_page.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/edit_others_page.dart';
import 'package:luround/views/account_owner/profile/widget/profile/about_section.dart';
import 'package:luround/views/account_owner/profile/widget/profile/add_section_button.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';
import '../../../../controllers/account_owner/profile_page_controller.dart';
import '../widget/edit_about/edit_about_page.dart';
import '../widget/edit_photo/edit_photo_page.dart';
import '../widget/profile/education_&_certifications_section.dart';
import '../widget/profile/other_details_section.dart';
import '../widget/reviews/reviews_screen.dart';








class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  var controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/images/luround_logo.png'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => NotificationsPage());
                          },
                          child: SvgPicture.asset('assets/svg/notify_active.svg'),
                        ),
                        SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            Get.to(() => EditPhotoPage());
                          },
                          child: SvgPicture.asset('assets/svg/edit.svg'),
                        )
                      ],
                    )
                  ]
                ),         
              ),
              SizedBox(height: 10),
              //QRCODE Widget
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.greyColor
                ),
                width: double.infinity,
                child: Image.asset('assets/images/qrcode_img.png'),
              ),
              SizedBox(height: 20,),

              //SEE ALL REVIEWS TEXT BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //SEE ALL REVIEWS
                        TextButton(
                          onPressed: () {
                            Get.to(() => ReviewsPage());
                          }, 
                          child: Text(
                            'See all reviews',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.darkGreyColor,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              )
                            )
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    //OWNER'S IMAGE
                    InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: controller.isEmpty ? AppColor.emptyPic : AppColor.greyColor,
                          image: DecorationImage(
                            image: AssetImage('assets/images/man_pics.png'),  //controller.isEmpty ? AssetImage('assets/images/empty_pic.png',)
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    //OWNER'S NAME
                    Center(
                      child: Text(
                        'Ronald Richard',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    //OWNER'S OCCUPATION
                    Center(
                      child: Text(
                        'Professional Specialist',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          )
                        )
                      ),
                    ),
                    //SizedBox(height: 5,),
                    //OWNER'S LINK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('https://www.mylink.com',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.blueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              )
                            )
                          )
                        ),
                        SizedBox(width: 4,),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset('assets/svg/copy_link.svg')
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    /////////////////////////////
                    //STRUCTURED WIDGETS COMES IN
                    //ProfileEmptyState(onPressed: () {},)
                    AboutSection(
                      onPressed: () {
                        Get.to(() => EditAboutPage());
                      },
                      text: 'ggggggggggggggggggggggggggggggggggggggggggggggggzgstyhrdthdhrhrdt'
                    ),
                    SizedBox(height: 30),
                    
                    EducationAndCertificationSection(
                      itemCount: 2,
                      onPressedEdit: () {
                        Get.to(() => EditEducationPage());
                      },

                      onPressedShowCertificte: () {},
                      certificateTitle: 'Certified Professional Specialist',
                      institution: 'London Business School',
                      issuedDate: 'Issued Oct 2023',
                      credentialID: 'CREDENTIAL ID: 7380030',
                    ),
                    SizedBox(height: 30),
                    OtherDetailsSection(
                      itemCount: controller.subtitleText.length,
                      onPressedEdit: () {
                        Get.to(() => EditOthersPage());
                      },
                      profileController: controller,
                    ),
                    SizedBox(height: 50),
                    AddSectionButton(
                      onPressed: () {
                        Get.to(() => AddSectionPage());
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              /////////////////////////////////////
            ]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        foregroundColor: AppColor.redColor,
        backgroundColor: AppColor.redColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        onPressed: () {},
        label: Text(
          'Share Profile',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.bgColor,
              fontSize: 15,
              fontWeight: FontWeight.w500
            )
          )
        ),
      ),
    );
  }
}