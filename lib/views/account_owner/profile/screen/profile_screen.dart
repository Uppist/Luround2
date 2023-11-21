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
import 'package:qr_flutter/qr_flutter.dart';
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
                    /*Container(
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
                    ),*/

                    //wrap future builder here
                    FutureBuilder<UserModel>(
                      future: userProfileService.getUserProfileDetails(email: userEmail),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox();
                        }
                        var data = snapshot.data!;
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 20.h
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.greyColor
                          ),
                          width: double.infinity,
                          child: QrImageView(
                            data: data.luround_url ?? "www.luround.com",
                            version: QrVersions.auto,
                            size: 170.w,
                            errorStateBuilder: (context, error) {
                              return Text(
                                "Uh oh! Something went wrong!",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.darkGreyColor
                                ),
                              );
                            },
                          ),
                        );
                      }
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
                          FutureBuilder<UserModel>(
                            future: userProfileService.getUserProfileDetails(email: userEmail),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return SizedBox();
                              }
                              var data = snapshot.data!;
                              return Container(
                                alignment: Alignment.center,
                                height: 300.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: data.photoUrl == "my_photo" ? AppColor.emptyPic : AppColor.greyColor,
                                  image:  data.photoUrl == "my_photo" ?
                                  DecorationImage(
                                    image: AssetImage('assets/images/empty_picc.png'),
                                    fit: BoxFit.contain
                                  )
                                  : DecorationImage(
                                    image: NetworkImage(data.photoUrl),
                                    fit: BoxFit.cover
                                  )
                                ),
                              );
                            }
                          ),
                          SizedBox(height: 30.h,),
                          
                          //user name
                          FutureBuilder<UserModel>(
                            future: userProfileService.getUserProfileDetails(email: userEmail),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return SizedBox();
                              }
                              var data = snapshot.data!;
                              return Center(
                                child: Text(
                                  data.displayName,
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ),
                              );
                            }
                          ),
                          SizedBox(height: 20.h,),

                          
                          //Wrap with Future builder
      ///////////////////////////////////////////////////////////////////////////////////
                          //OWNER'S NAME
                          FutureBuilder<UserModel>(
                            future: userProfileService.getUserProfileDetails(email: userEmail),
                            builder: (context, snapshot) {
                              
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Loader2();
                              } 

                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return SafeArea(
                                  child: Center(
                                    child: Text(
                                      '${snapshot.error}',
                                      style: GoogleFonts.inter(
                                        color: AppColor.textGreyColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal
                                      )
                                    )
                                  ),
                                );
                              }

                              if (!snapshot.hasData) {
                                return SafeArea(
                                  child: Center(
                                    child: Text(
                                      'No data in db fam',
                                      style: GoogleFonts.inter(
                                        color: AppColor.textGreyColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal
                                      )
                                    )
                                  ),
                                );
                              }
                              
                              var data = snapshot.data!;

                              if (data.about.isEmpty && data.media_links.isEmpty && data.certificates.isEmpty) {
                                return ProfileEmptyState(
                                  onPressed: () {
                                    //userProfileService.getUserProfileDetails(email: userEmail);
                                    Get.to(() => AddSectionPage(
                                      aboutUser: data.about,
                                    ));
                                  },
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
              
                                  //OWNER'S OCCUPATION
                                  Center(
                                    child: Text(
                                      data.occupation,
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
                                        onPressed: () {
                                          userProfileService.launchUrlLink(link: data.luround_url);
                                        },
                                        child: Text(
                                          data.luround_url, //data.displayName["company"]
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
                                      Get.to(() => EditAboutPage(
                                        about: data.about,
                                      ));
                                    },
                                    text: data.about
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
                                    itemCount: data.media_links.length,
                                    onPressedEdit: () {
                                      Get.to(() => EditOthersPage());
                                    },
                                    profileController: controller,
                                  ),
                                  SizedBox(height: 50.h),
                                  if(data.occupation.isEmpty || data.about.isEmpty || data.certificates.isEmpty || data.media_links.isEmpty)
                                  AddSectionButton(
                                    onPressed: () {
                                      Get.to(() => AddSectionPage(
                                        aboutUser: data.about,
                                      ));
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