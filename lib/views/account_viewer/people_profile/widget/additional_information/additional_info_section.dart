import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_viewer/profile_service/get_user_profile.dart';
import 'package:luround/utils/colors/app_theme.dart';
import '../../../../../controllers/account_viewer/profile_page_controller__acc_viewer.dart';







class AdditionalInfoSection extends StatelessWidget {
  AdditionalInfoSection({super.key, required this.profileController, required this.service, required this.media_links,});
  final ProfilePageAccViewerController profileController;
  final AccViewerProfileService service;
  final List<dynamic> media_links;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            )
          )
        ),
        SizedBox(height: 20.h),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: media_links.length,
          separatorBuilder: (context, index) => SizedBox(height: 30.h),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if(media_links[index]['name'] == 'Email') {
                   print("launch email");
                  service.launchUrlEmail(email: media_links[index]["link"]);
                }
                else if(media_links[index]['name'] == 'Mobile') {
                  print("launch mobile");
                  service.launchUrlPhone(phone: media_links[index]["link"]);
                }
                else{
                  print("launch url");
                  service.launchUrlLink(link: media_links[index]["link"]);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Icon
                  SvgPicture.asset(
                    media_links[index]["icon"] ?? "icon",
                    height: 55.h, width: 55.w,
                  ),
                  SizedBox(width: 15.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Title text
                        Text(
                          media_links[index]['name'] ?? "name",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            )
                          )
                        ),
                        SizedBox(height: 5.h,),
                        //Subtitle text
                        Text(
                          media_links[index]["link"] ?? "link",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.darkGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400
                            )
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        )
        
      ]
    );
  }
}