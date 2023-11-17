import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
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
  var userProfileService = Get.put(UserProfileService());
  var userEmail = LocalStorage.getUseremail();
  var userName = LocalStorage.getUsername();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            /////////////////////////////Header Section/////////////////////
            //HEADER SECTION///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/luround_logo.png'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: SvgPicture.asset('assets/svg/notify_active.svg'),
                      ),
                      SizedBox(width: 20.w,),
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
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.h),
                    //QRCODE Widget
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 20.h
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.greyColor
                      ),
                      width: double.infinity,
                      child: Image.asset('assets/images/qrcode_img.png'),
                    ),
                    SizedBox(height: 20.h,),
            
                    //SEE ALL REVIEWS TEXT BUTTON
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500
                                    )
                                  )
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          //OWNER'S IMAGE
                          InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 300.h,
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
                          SizedBox(height: 30.h,),
                          Center(
                            child: Text(
                              userName,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold
                                )
                              )
                            ),
                          ),
                          SizedBox(height: 10.h,),

                          
                          //Wrap with Future builder
      ///////////////////////////////////////////////////////////////////////////////////
                          //OWNER'S NAME
                          FutureBuilder<UserModel>(
                            future: userProfileService.getUserProfileDetails(email: userEmail),
                            builder: (context, snapshot) {

                              var data = snapshot.data!;
                              
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Loader();
                              } 

                              if (snapshot.hasError) {
                                return SafeArea(
                                  child: Center(
                                    child: Text(
                                      'Error: ${snapshot.error}',
                                      style: GoogleFonts.inter(
                                        color: AppColor.textGreyColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500
                                      )
                                    )
                                  ),
                                );
                              }

                              if (!snapshot.hasData) {
                                return ProfileEmptyState(
                                  onPressed: () {
                                    userProfileService.getUserProfileDetails(email: userEmail);
                                  },
                                  userName: "data.displayName",
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //OWNER'S OCCUPATION
                                  Center(
                                    child: Text(
                                      'Professional Specialist',
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: 17.sp,
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
                                        child: Text(
                                          'https://www.mylink.com',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              color: AppColor.blueColor,
                                             fontSize: 15.sp,
                                             fontWeight: FontWeight.w500
                                            )
                                          )
                                        )
                                      ),
                                      SizedBox(width: 4.w,),
                                      InkWell(
                                        onTap: () {},
                                        child: SvgPicture.asset('assets/svg/copy_link.svg')
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h),
                                      
                                  /////////////////////////////
                                  //STRUCTURED WIDGETS COMES IN
                                  AboutSection(
                                    onPressed: () {
                                      Get.to(() => EditAboutPage());
                                    },
                                    text: 'ggggggggggggggggggggggggggggggggggggggggggggggggzgstyhrdthdhrhrdt'
                                  ),
                                  SizedBox(height: 30.h),
                              
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
                                  SizedBox(height: 30.h),
                                  OtherDetailsSection(
                                    itemCount: controller.subtitleText.length,
                                    onPressedEdit: () {
                                      Get.to(() => EditOthersPage());
                                    },
                                    profileController: controller,
                                  ),
                                  SizedBox(height: 50.h),
                                  AddSectionButton(
                                    onPressed: () {
                                      Get.to(() => AddSectionPage());
                                    },
                                  ),
                                ],
                              );
                            }
                          ),
                        ]
                      )  
                    )
                  ]
                )                                        
              )
              /////////////////////////////////////                       
            )        
          ]
        )
      ),
    
      
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        foregroundColor: AppColor.redColor,
        backgroundColor: AppColor.redColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r)
        ),
        onPressed: () {},
        label: Text(
          'Share Profile',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.bgColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
            )
          )
        ),
      ),
    );
  }
}