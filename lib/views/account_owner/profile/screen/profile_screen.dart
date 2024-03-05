import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/copy_to_clipboard.dart';
import 'package:luround/utils/components/extractors.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/share_profile_link.dart';
import 'package:luround/views/account_owner/payment_screen/widget/free_trial_banner.dart.dart';
import 'package:luround/views/account_owner/profile/screen/profile_empty_state.dart';
import 'package:luround/views/account_owner/profile/widget/add_section/add_section_screen.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/page/edit_education_page.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/edit_others_page.dart';
import 'package:luround/views/account_owner/profile/widget/profile/about_section.dart';
import 'package:luround/views/account_owner/profile/widget/profile/add_section_button.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../widget/edit_about/edit_about_page.dart';
import '../widget/edit_photo/edit_photo_page.dart';
import '../widget/profile/education_&_certifications_section.dart';
import '../widget/profile/other_details_section.dart';
import '../widget/reviews/reviews_screen.dart';











class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  //var service = Get.put(FinancialsPdfService());

  final ProfilePageController controller = Get.put(ProfilePageController());

  final AccOwnerProfileService userProfileService = Get.put(AccOwnerProfileService());

  final String userEmail = LocalStorage.getUseremail();
  
  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<UserModel> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final UserModel newData = await userProfileService.getUserProfileDetails(email: userEmail);
    // Update the UI with the new data
    print('updated profile data: $newData');
    return newData;
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: RefreshIndicator.adaptive(
        color: AppColor.greyColor,
        backgroundColor: AppColor.mainColor,
        key: _refreshKey,
        onRefresh: () {
          return _refresh();
        },
        child: SafeArea(
          child: Column(
            children: [
              const FreeTrialBanner(),
              SizedBox(height: 5.h,),
              _buildHeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  //controller: _scrollController,
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildShareProfileButton()
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/luround_logo.png'),
          //SvgPicture.asset('assets/svg/logo_new.svg'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => NotificationsPage());
                  //service.saveAndShareQuotePDF(context: context);
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
  
  //valid
  Widget _buildShareProfileButton() {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FloatingActionButton.extended(
            extendedPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            foregroundColor: AppColor.redColor,
            backgroundColor: AppColor.redColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            onPressed: () {
              print("still loading fam. please wait");
            },
            label: Text(
              'Share Profile',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.bgColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-data: ${snapshot.data}");
        }
        if (snapshot.hasData) {

          var data = snapshot.data!; 

          return FloatingActionButton.extended(
            extendedPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            foregroundColor: AppColor.redColor,
            backgroundColor: AppColor.redColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            onPressed: () {
              shareProfileLink(link: data.luround_url.replaceFirst('luround.com/', 'luround.com/#/'));
              //shareProfileLink(link: editedUrl);
            },
            label: Text(
              'Share Profile',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.bgColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
        return Center(
          child: Text(
            "connection timed out",
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.normal
            )
          )
        );
      },
    );
  }
  
  //valid
  Widget _buildEditProfileButton() {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return InkWell(
            onTap: () {
              print("still loading fam. please wait");
            },
            child: SvgPicture.asset('assets/svg/edit.svg'),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return SvgPicture.asset('assets/svg/edit.svg');
        }
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-data: ${snapshot.data}");
        }
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return InkWell(
            onTap: () {
              Get.to(() => EditPhotoPage(
                  logo_url: data.logo_url,
                  displayName: data.displayName,
                  company: data.company,
                  occupation: data.occupation,
                  photoUrl: data.photoUrl,
                )
              );
            },
            child: SvgPicture.asset('assets/svg/edit.svg'),
          );
        }
        return SvgPicture.asset('assets/svg/edit.svg');
      },
    );
  }

  ////////////////////////////////////////////////////
  //[MAIN CONTENT HERE]//
  Widget _buildContent() {
    return FutureBuilder<UserModel>(
      future: userProfileService.getUserProfileDetails(email: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-data: ${snapshot.data}");
          return Loader2(); 
        }
         
        if (snapshot.hasData) {
          var data = snapshot.data!;
          //&& data.company.isEmpty && data.logo_url.isEmpty
          if(data.occupation.isEmpty && data.about.isEmpty && data.certificates.isEmpty && data.media_links.isEmpty) {
            return ProfileEmptyState(
              onPressed: () {
                Get.to(
                  () => AddSectionPage(
                    logo_url: data.logo_url,
                    aboutUser: data.about,
                    displayName: data.displayName,
                    company: data.company,
                    occupation: data.occupation,
                    photoUrl: data.photoUrl,
                  )
                );
                    
              }
            );
          }
        
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: QrImageView(
                  data: data.luround_url.replaceFirst('luround.com/', 'luround.com/#/'), //editedUrl,
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
              ),

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
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          )
                        )
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              InkWell(
                onTap: () {
                  userProfileService.pickImageFromGallery(context: context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    alignment: Alignment.center,
                    height: 300.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: data.photoUrl == "my_photo" ? AppColor.emptyPic : AppColor.greyColor,
                      image:  data.photoUrl == "my_photo" ?
                      DecorationImage(
                        image: AssetImage('assets/images/profile_null.png'),
                        fit: BoxFit.contain
                      )
                      :DecorationImage(
                        image: NetworkImage(data.photoUrl),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  data.displayName,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600
                    )
                  )
                ),
              ),

              SizedBox(height: 20.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: AppColor.greyColor,
                            image: DecorationImage(
                              image: NetworkImage(data.logo_url),
                              fit: BoxFit.contain
                            )
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Text(
                          data.company,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h,),

                  Center(
                    child: Text(
                      data.occupation,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            data.luround_url.replaceFirst('luround.com/', 'luround.com/#/'),
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.blueColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400
                              )
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 4.w,),
                        InkWell(
                          onTap: () {
                            copyToClipboard(
                              text:  data.luround_url.replaceFirst('luround.com/', 'luround.com/#/'),
                              context: context,
                              snackMessage: "profile link copied to clipboard"
                            );
                          },
                          child: SvgPicture.asset('assets/svg/copy_link.svg')
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  SizedBox(height: 30.h),
                  data.about.isEmpty ? SizedBox() :
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
                  /*Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  SizedBox(height: 30.h),   
                  data.certificates.isEmpty ? SizedBox() :                       
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
                  SizedBox(height: 30.h),*/
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  SizedBox(height: 30.h),
                  data.media_links.isEmpty ? SizedBox() :
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
                  SizedBox(height: 30.h),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  //SizedBox(height: 30.h),
                  SizedBox(height: 50.h),

                  ///////[RUN CHECK]///////////////
                  if (
                    data.about.isEmpty ||
                    //data.certificates.isEmpty ||
                    data.media_links.isEmpty
                  )
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AddSectionButton(
                      onPressed: () {
                        Get.to(
                          () => AddSectionPage(
                            logo_url: data.logo_url,
                            aboutUser: data.about,
                            displayName: data.displayName,
                            company: data.company,
                            occupation: data.occupation,
                            photoUrl: data.photoUrl,
                          )
                        );
                      },
                    ),
                  ),
                ],
              ),  


              SizedBox(height: 30.h),
              ////////////////////////////////////////////////////////////////////////
            ],     
          );
        }
        return Center(
          child: Text(
            "connection timed out",
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.normal
            )
          )
        );
      }
    );
  }
  ////////////////

}
