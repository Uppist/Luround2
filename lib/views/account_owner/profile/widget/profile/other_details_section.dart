import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';





class OtherDetailsSection extends StatelessWidget {
  OtherDetailsSection({super.key, required this.onPressedEdit, required this.profileController, required this.media_links, required this.profileService,});
  final ProfilePageController profileController;
  final AccOwnerProfileService profileService;
  final VoidCallback onPressedEdit;
  final List<dynamic> media_links;

  var service = Get.put(AccOwnerProfileService());
 
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
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
                )
              )
            ),
            InkWell(
              onTap: onPressedEdit,
              child: SvgPicture.asset('assets/svg/edit.svg',)
            )
          ],
        ),
        SizedBox(height: 20.h),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: media_links.length,
          separatorBuilder: (context, index) => SizedBox(height: 30.h),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.delete_outline_rounded,
                    color: AppColor.redColor
                  )
                ]
              ),
              onDismissed: (direction) async{
                await service.deleteMediaData(
                  context: context, 
                  name: media_links[index]['name'], 
                  link: media_links[index]['link'], 
                  icon: media_links[index]["icon"]
                );
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
                          media_links[index]["link"] ?? "link",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 7.h,), //10
                        //Subtitle text
                        Text(
                          media_links[index]['name'] ?? "name",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.darkGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400
                            )
                          ),
                          overflow: TextOverflow.ellipsis,
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