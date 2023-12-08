import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_viewer/profile_service/get_user_profile.dart';
import 'package:luround/utils/colors/app_theme.dart';





class AccViewerEducationAndCertificationSection extends StatelessWidget {
  AccViewerEducationAndCertificationSection({super.key, required this.eduAndCertList, required this.service,});
  final List<dynamic> eduAndCertList;
  final AccViewerProfileService service;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Text(
            'Education & Certifications',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
              )
            )
          ),
        ),
        
        SizedBox(height: 20.h),

        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: eduAndCertList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.bgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svg/award_icon.svg'),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eduAndCertList[index]['certificateName'],
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        eduAndCertList[index]['issuingOrganization'],
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                          )
                        )
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        eduAndCertList[index]['issueDate'],
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                          )
                        )
                      ),
                      SizedBox(height: 5.h,),
                      /*Text(
                        credentialID,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                          )
                        )
                      ),*/
                      SizedBox(height: 10.h,),
                      //SHOW CERTIFICATE BUTTON
                      InkWell(
                        onTap: () {
                          service.launchUrlLink(link: eduAndCertList[index]['certificateLink']);
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColor.darkGreyColor
                            )
                          ),
                          child: Text(
                            'Show Certificate',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.darkGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      )
                    ],
                  )
                ]
              ),
            );
          }
        )
      ]
    );
  }
}