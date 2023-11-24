import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/extract_firstname.dart';
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

  final ProfilePageController controller = Get.put(ProfilePageController());
  final AccOwnerProfileService userProfileService = Get.put(AccOwnerProfileService());
  final String userEmail = LocalStorage.getUseremail();

  Future<void> _refresh() async {
    // Simulate a refresh by waiting for a short duration
    await Future.delayed(Duration(seconds: 1));
    await userProfileService.getUserProfileDetails(email: userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: RefreshIndicator.adaptive(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: AppColor.mainColor,
        backgroundColor: AppColor.bgColor,
        onRefresh: _refresh,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        foregroundColor: AppColor.redColor,
        backgroundColor: AppColor.redColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        onPressed: () {},
        label: Text(
          'Share Profile',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.bgColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildHeaderSection() {
    return Padding(
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
              SizedBox(width: 20.w),
              _buildEditProfileButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton() {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return SvgPicture.asset('assets/svg/edit.svg');
        }
        var data = snapshot.data!;
        return InkWell(
          onTap: () {
            Get.to(() => EditPhotoPage(
              firstName: getFirstName(fullName: data.displayName),
              lastName: getLastName(fullName: data.displayName),
              company: data.company,
              occupation: data.occupation,
                photoUrl: data.photoUrl,
              )
            );
          },
          child: SvgPicture.asset('assets/svg/edit.svg'),
        );
      },
    );
  }
  
  //[MAIN CONTENT HERE]//
  Widget _buildContent() {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Loader()
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-data: ${snapshot.data}");
          return Loader2();
        }
        var data = snapshot.data!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQrCode(data),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
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
            ),
            SizedBox(height: 10.h,),
            _buildOwnerImage(data),
            SizedBox(height: 30.h),
            _buildUserName(data),
            SizedBox(height: 20.h),
            _buildProfileContent(data),              
            SizedBox(height: 30.h),
            ////////////////////////////////////////////////////////////////////////
          ],     
        );
      }
    );
  }

  Widget _buildProfileContent(UserModel data) {
    return FutureBuilder(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (!snapshot.hasData) {
          print("uh--oh! nothing dey;");
        }

        var data = snapshot.data!;

        if(data.occupation.isEmpty && data.about.isEmpty && data.certificates.isEmpty && data.media_links.isEmpty) {
          return ProfileEmptyState(
            onPressed: () {}
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                data.occupation,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
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
            if (
              data.occupation.isEmpty ||
              data.about.isEmpty ||
              data.certificates.isEmpty ||
              data.media_links.isEmpty
            )       
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AboutSection(
                onPressed: () {
                  Get.to(() => EditAboutPage(
                    about: data.about,
                  ));
                },
                text: data.about
              ),
            ),
            SizedBox(height: 30.h),                          
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: EducationAndCertificationSection(
                itemCount: data.certificates.length,
                eduAndCertList: data.certificates,
                onPressedEdit: () {
                  Get.to(() => EditEducationPage());
                },      
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: OtherDetailsSection(
                media_links: data.media_links,
                onPressedEdit: () {
                  Get.to(() => EditOthersPage());
                },
                profileController: controller,
                profileService: userProfileService,
              ),
            ),
            SizedBox(height: 50.h),

            ////////////////////////

            if (
              data.occupation.isEmpty ||
              data.about.isEmpty ||
              data.certificates.isEmpty ||
              data.media_links.isEmpty
            )
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AddSectionButton(
                onPressed: () {
                  Get.to(
                    () => AddSectionPage(
                      aboutUser: data.about,
                      firstName: getFirstName(fullName: data.displayName),
                      lastName: getLastName(fullName: data.displayName),
                      company: data.company,
                      occupation: data.occupation,
                      photoUrl: data.photoUrl,
                    )
                  );
                },
              ),
            ),
          ],
        );
      }
    );
  }

  // ... (other existing methods)

  Widget _buildQrCode(UserModel data) {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        if (snapshot.hasError) {
          print(snapshot.error);                         
        }
        if(!snapshot.hasData) {
          print("no data in db");
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
            data: data.luround_url,
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
    );
  }

  Widget _buildOwnerImage(UserModel data) {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        if (snapshot.hasError) {
          print(snapshot.error);                         
        }
        if(!snapshot.hasData) {
          print("no data in db (photo)");
        }
        var data = snapshot.data!;
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
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
              :DecorationImage(
                image: NetworkImage(data.photoUrl),
                fit: BoxFit.cover
              )
            ),
          ),
        );
      }
    );
  }


  Widget _buildUserName(UserModel data) {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text(
              '${snapshot.error}',
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal
              )
            )
          );
        }
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-data: ${snapshot.data}");
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
    );
  }




}
