import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class EducationAndCertificationSection extends StatelessWidget {
  EducationAndCertificationSection({super.key, required this.onPressedEdit, required this.itemCount, required this.certificateTitle, required this.institution, required this.issuedDate, required this.credentialID, required this.onPressedShowCertificte});
  final VoidCallback onPressedEdit;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Education & Certifications',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 18,
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
        
        SizedBox(height: 20),

        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.bgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svg/award_icon.svg'),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        certificateTitle,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 5,),
                      Text(
                        institution,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 14,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 5,),
                      Text(
                        issuedDate,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 14,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 5,),
                      Text(
                        credentialID,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColor.darkGreyColor,
                            fontSize: 14,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      ),
                      SizedBox(height: 10,),
                      //SHOW CERTIFICATE BUTTON
                      InkWell(
                        onTap: onPressedShowCertificte,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          alignment: Alignment.center,
                          height: 50,
                          //width: 200,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColor.darkGreyColor
                            )
                          ),
                          child: Text(
                            'Show Certificate',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColor.darkGreyColor,
                                fontSize: 15,
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