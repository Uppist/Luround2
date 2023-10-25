import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import '../../../../../controllers/account_viewer/profile_page_controller__acc_viewer.dart';







class AdditionalInfoSection extends StatelessWidget {
  AdditionalInfoSection({super.key, required this.profileController, required this.itemCount,});
  final ProfilePageAccViewerController profileController;
  final int itemCount;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: AppColor.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          )
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