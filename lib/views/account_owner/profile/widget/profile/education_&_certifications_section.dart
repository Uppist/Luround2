import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class EducationAndCertificationSection extends StatelessWidget {
  EducationAndCertificationSection({super.key, required this.onPressedEdit, required this.itemCount, required this.eduAndCertList});
  final VoidCallback onPressedEdit;
  final int itemCount;
  final List<dynamic> eduAndCertList;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Education & Certifications',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            InkWell(
              onTap: onPressedEdit,
              child: SvgPicture.asset('assets/svg/edit.svg')
            )
          ],
        ),
        
        SizedBox(height: 20.h),

        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.bgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svg/award_icon.svg',),
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
                      SizedBox(height: 7.h,),
                      Text(
                        eduAndCertList[index]['issuingOrganization'],
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 15.sp,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 7.h,),
                      Text(
                        eduAndCertList[index]['issueDate'],
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 15.sp,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 7.h,),
                      /*Text(
                        eduAndCertList[index] ['certificateLink'],
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 15.sp,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),*/
                      SizedBox(height: 12.h,),
                      //SHOW CERTIFICATE BUTTON
                      InkWell(
                        onTap: () {},
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 210.w,
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