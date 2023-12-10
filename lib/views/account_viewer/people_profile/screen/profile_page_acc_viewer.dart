import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/profile_page_controller__acc_viewer.dart';
import 'package:luround/models/account_owner/user_profile/user_model.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_viewer/profile_service/get_user_profile.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/border_button.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_viewer/people_profile/widget/additional_information/additional_info_section.dart';
import 'package:luround/views/account_viewer/people_profile/widget/reviews_section/reviews_screen.dart';
import '../widget/about_section/about_section.dart';
import '../widget/education_&_certificate_section/education_&_certifications_section.dart';










class AccViewerProfilePage extends StatefulWidget {
  AccViewerProfilePage({super.key});

  @override
  State<AccViewerProfilePage> createState() => _AccViewerProfilePageState();
}

class _AccViewerProfilePageState extends State<AccViewerProfilePage> {
  
  var controller = Get.put(ProfilePageAccViewerController());
  var service = Get.put(AccViewerProfileService());
  final String userEmail = LocalStorage.getUseremail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      /*appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: Image(
          image: AssetImage('assets/images/luround_logo.png'),
        ),
      ),*/
      body: SafeArea(
        child: Column(
          children: [
            //////HEADER SECTION/////
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/luround_logo.png'),
                ]
              ),         
            ),
            SizedBox(height: 10.h),
            
            //CUSTOM BODY SECTION//
            FutureBuilder<UserModel>(
              future: service.getUserProfileDetails(),
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
            
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.greyColor
                            ),
                            height: 7.h,
                            width: double.infinity,
                          ),     
                          
                          SizedBox(height: 30.h,),
                                
                          //SEE ALL REVIEWS and image
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => AccViewerReviewsPage(
                                          userName: data.displayName,
                                          photoUrl: data.photoUrl,
                                        ));
                                      }, 
                                      child: Text(
                                        'See all reviews',
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            color: AppColor.textGreyColor,
                                            decoration: TextDecoration.underline,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            decorationColor: AppColor.darkGreyColor,
                                            decorationThickness: 2,
                                            decorationStyle: TextDecorationStyle.solid
                                          )
                                        )
                                      )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                //IMAGE
                                Container(
                                  alignment: Alignment.center,
                                  height: 300.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    //color: controller.isEmpty ? AppColor.emptyPic : AppColor.greyColor,
                                    image: DecorationImage(
                                      image: NetworkImage(data.photoUrl),  //controller.isEmpty ? AssetImage('assets/images/empty_pic.png',)
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ), 
                                
                          SizedBox(height: 30.h,),
                                
                          //OWNER'S NAME
                          Center(
                            child: Text(
                              data.displayName,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 20.h,
                                  fontWeight: FontWeight.w600
                                )
                              )
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          //Where the person works
                          Center(
                            child: Text(
                              data.company,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 15.h,
                                  fontWeight: FontWeight.w500
                                )
                              )
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          //OWNER'S OCCUPATION Here
                          Center(
                            child: Text(
                              data.occupation,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.h,
                                  fontWeight: FontWeight.w500
                                )
                              )
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.greyColor
                            ),
                            height: 7.h,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 30),
                          /////////////////////////////
                          //About section here
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            child: AccViewerAboutSection(
                              text: data.about
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.greyColor
                            ),
                            height: 7,
                            width: double.infinity,
                          ),
                          SizedBox(height: 30.h),                 
                          AccViewerEducationAndCertificationSection(
                            eduAndCertList: data.certificates,
                            service: service,
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.greyColor
                            ),
                            height: 7.h,
                            width: double.infinity,
                          ),
                                
                        SizedBox(height: 30.h,),
                        //Additional information
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          child: AdditionalInfoSection(
                            media_links: data.media_links,
                            service: service,
                            profileController: controller,
                          ),
                        ),
                        SizedBox(height: 30.h),
                                
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.greyColor
                          ),
                          height: 7.h,
                          width: double.infinity,
                        ),
                        SizedBox(height: 20.h,), 
                                
                                
                        //Sign Me Up section///////////////////////////
                        controller.showSignMeUpSection.value ?
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Cancel button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.showSignMeUpSection.value = false;
                                      });
                                    }, 
                                    icon: const Icon(CupertinoIcons.xmark),
                                    //iconSize: 30,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                "Create your own account",
                                style: GoogleFonts.inter(
                                  fontSize: 20.h,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.darkGreyColor
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                "By setting up your own account, others\n  can schedule and book your services.",
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.darkGreyColor
                                ),
                              ),
                              SizedBox(height: 50.h,),
                              //buttons
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: Column(
                                  children: [
                                    ReusableButton(
                                      onPressed: () {
                                        //ideally, it will get to google play to download the app
                                        //Get.offAll(() => const SplashScreen1());
                                      },
                                      color: AppColor.mainColor,
                                      text: 'Sign me up',
                                    ),
                                    SizedBox(height: 25.h,),
                                    BorderButton(
                                      onPressed: (){
                                        setState(() {
                                          controller.showSignMeUpSection.value = false;
                                        });
                                      },
                                      text: "Remind me later",
                                      textColor: AppColor.mainColor,
                                    ),
                                    SizedBox(height: 20.h,),
                                  ],
                                ),
                              ),
                            ]
                          ),
                        ) 
                        : const SizedBox()
                        //////////////////////////////////////////////////   
                                         
                        ]
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
            ),
          ],
        )
      )
    );
  }
}