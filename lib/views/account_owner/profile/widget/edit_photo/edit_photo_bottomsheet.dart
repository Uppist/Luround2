import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'delete_photo_bottomsheet.dart';





var profileService = Get.put(AccOwnerProfileService());


///Alert Dialog
Future<void> editPhotoDialogueBox({required BuildContext context}) async {
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1
                InkWell(
                  onTap: () {
                    profileService.pickImageFromGallery(context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/pen_photo.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Edit profile photo',
                        style: GoogleFonts.inter(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //2
                InkWell(
                  onTap: () {
                    profileService.pickImageFromGallery(context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/replace_photo.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Replace profile photo',
                        style: GoogleFonts.inter(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //1
                InkWell(
                  onTap: () {
                    deletePhotoDialogueBox(
                      context: context,
                      onDelete: () {
                        profileService.deleteProfilePhoto(context)
                        .whenComplete(() => Get.back());
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/delete_photo.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Delete profile photo',
                        style: GoogleFonts.inter(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      );
    }
  );
}