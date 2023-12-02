import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/mainpage_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';



class TransferFundsSuccessScreen extends StatelessWidget {
TransferFundsSuccessScreen({super.key, required this.amount});
  final String amount;

  final MainPageController mainPageController = MainPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Success",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => MainPage());
                    },
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: AppColor.darkGreyColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Divider(color: AppColor.textGreyColor, thickness: 0.3,),
              SizedBox(height: 30.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "You have successfully withdrawn ",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "$amount ",
                      style: GoogleFonts.inter(
                        color: AppColor.mainColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "from your wallet",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ]
                )
              ),
              SizedBox(height: 200.h,),
              Center(
                child: SvgPicture.asset("assets/svg/check_ss.svg", width: 120.w, height: 120.h,)
              ),
              SizedBox(height: 290.h,),
              ReusableButton(
                color: AppColor.mainColor,
                text: 'Close',
                onPressed: () async{
                  Get.offAll(() => MainPage());
                },
              ),
              SizedBox(height: 20.h,),
            ]
          )
        )
      )
    );
  }
}