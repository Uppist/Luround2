import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/profile/screen/profile_screen.dart';

import '../../../../../controllers/account_owner/profile_page_controller.dart';





class OtherDetailsSection extends StatelessWidget {
  OtherDetailsSection({super.key, required this.onPressedEdit, required this.profileController, required this.itemCount,});
  final ProfilePageController profileController;
  final VoidCallback onPressedEdit;
  final int itemCount;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Other Details',
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
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          separatorBuilder: (context, index) => SizedBox(height: 30),
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Icon
                SvgPicture.asset(
                  profileController.svgPictures[index],
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title text
                    Text(
                      profileController.titleText[index],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    //Subtitle text
                    Text(
                      profileController.subtitleText[index],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.darkGreyColor,
                          fontSize: 14,
                        )
                      )
                    ),
                  ],
                )
              ],
            );
          }
        )
        
      ]
    );
  }
}