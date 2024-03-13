import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/screen/payment_screen_for_app.dart';







class FreeTrialBanner extends StatefulWidget {
  FreeTrialBanner({super.key,});

  @override
  State<FreeTrialBanner> createState() => _FreeTrialBannerState();
}

class _FreeTrialBannerState extends State<FreeTrialBanner> {

  final AccOwnerProfileService userProfileService = Get.put(AccOwnerProfileService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return userProfileService.isBannerCancelled.value ? SizedBox(): Container(
          alignment: Alignment.center,
          height: 45.h, //40.h
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w,),
          color: AppColor.navyBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'You are currently on 30 days free trial plan',
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => SubscriptionScreenInApp());
                    },
                    child: Text(
                      'see pricing',
                      style: GoogleFonts.inter(
                        color: AppColor.bgColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        decorationColor: AppColor.bgColor,
                        decoration: TextDecoration.underline
                      ),
                    )
                  ),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: () {
                      userProfileService.isBannerCancelled.value = true; //!userProfileService.isBannerCancelled.value;
                    },
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: AppColor.bgColor,
                      size: 24.r,
                    )
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}