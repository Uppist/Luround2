import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/copy_to_clipboard.dart';
import 'package:luround/utils/components/extract_firstname.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/share_profile_link.dart';
import 'package:luround/views/account_owner/profile/screen/profile_empty_state.dart';
import 'package:luround/views/account_owner/profile/widget/add_section/add_section_screen.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/page/edit_education_page.dart';
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











class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  final ProfilePageController controller = Get.put(ProfilePageController());

  final AccOwnerProfileService userProfileService = Get.put(AccOwnerProfileService());

  final String userEmail = LocalStorage.getUseremail();

  Future<void> _refresh() async {
    // Simulate a refresh by waiting for a short duration
    await Future.delayed(Duration(seconds: 1));
    await userProfileService.getUserProfileDetails(email: userEmail);
  }
  
  ScrollController? _scrollController;
  bool showShareIcon = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController!.position.userScrollDirection == ScrollDirection.reverse) {
      // Scrolling down
      if (showShareIcon) {
        setState(() {
          showShareIcon = false;
        });
      }
    } else if (_scrollController!.position.userScrollDirection == ScrollDirection.forward) {
      // Scrolling up
      if (!showShareIcon) {
        setState(() {
          showShareIcon = true;
        });
      }
    }
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
                  fontWeight: FontWeight.w500,
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
              shareProfileLink(link: data.luround_url);
            },
            label: showShareIcon ? Icon(Icons.share) : Text(
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
        }
        return SvgPicture.asset('assets/svg/edit.svg');
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
         
        if (snapshot.hasData) {
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
        if (snapshot.hasData) {

          var data = snapshot.data!;

          if(data.occupation.isEmpty && data.about.isEmpty && data.certificates.isEmpty && data.media_links.isEmpty) {
            return ProfileEmptyState(
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
                    
              }
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
                  onTap: () {
                    copyToClipboard(
                      text: data.luround_url,
                      context: context,
                      snackMessage: "link copied to clipboard"
                    );
                  },
                  child: SvgPicture.asset('assets/svg/copy_link.svg')
                ),
              ],
            ),

            SizedBox(height: 30.h),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),
            SizedBox(height: 30.h),
                   
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
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
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
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
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

        if (snapshot.hasData) {
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

        if (snapshot.hasData) {
          var data = snapshot.data!;
        
          return InkWell(
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
        
        if (snapshot.hasData) {
          var data = snapshot.data!;

          return Center(
            child: Text(
              data.displayName,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold
                )
              )
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
      }
    );
  }
}
