import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class AccViewerEducationAndCertificationSection extends StatelessWidget {
  AccViewerEducationAndCertificationSection({super.key, required this.itemCount, required this.certificateTitle, required this.institution, required this.issuedDate, required this.credentialID, required this.onPressedShowCertificte});
  final VoidCallback onPressedShowCertificte;
  final int itemCount;
  final String certificateTitle;
  final String institution;
  final String issuedDate;
  final String credentialID;

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
                fontWeight: FontWeight.bold
              )
            )
          ),
        ),
        
        SizedBox(height: 20.h),

        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
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
                        certificateTitle,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        institution,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 13.sp,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        issuedDate,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 13.sp,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        credentialID,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 13.sp,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //SHOW CERTIFICATE BUTTON
                      InkWell(
                        onTap: onPressedShowCertificte,
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
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
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