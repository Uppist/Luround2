import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/payment_service.dart/paystack_client_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/payment_screen/widget/custom_row.dart';




class YearlySubscriptionPage extends StatelessWidget {
  YearlySubscriptionPage({super.key, required this.onNavigate});
  final VoidCallback onNavigate;

  var paystackService = Get.put(PaystackClientService());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        //normal white container
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(15.r),
              //border: Border.all(color: AppColor.navyBlue)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Center(
                  child: Text(
                    "Standard Plan",
                    style: GoogleFonts.inter(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "N25,200",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w700
                          )
                        ),
                        TextSpan(
                          text: "/year",
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          )
                        )
                      ]
                    )
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "FULL ACCESS",
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 25.h),
                PaymentRowText(
                  text: 'Customize your profile',
                ),
                SizedBox(height: 25.h,),
                PaymentRowText(
                  text: 'Set up your service page',
                ),
                SizedBox(height: 25.h,),
                PaymentRowText(
                  text: 'Track your bookings and transactions',
                ),
                SizedBox(height: 25.h,),
                PaymentRowText(
                  text: 'Send quotes, invoice and receipts',
                ),
                SizedBox(height: 25.h,),
                PaymentRowText(
                  text: 'Sync your calendar',
                ),
                SizedBox(height: 90.h,),
                RebrandedReusableButton(
                  color: AppColor.navyBlue, 
                  text: "Choose Plan", 
                  onPressed: () {
                    //call paystack api
                    paystackService.payWithPaystack(
                      context: context, 
                      realAmount: 25200, 
                      companyEmail: "support@luround.com",
                      onNavigate: onNavigate,
                    );
                  }, 
                  textColor: AppColor.bgColor,
                ),
              ],
            ),
          ),
        ),
    
        //yellow stacked container
        Positioned(
          top: 5.h, // Adjust this value to control how much it protrudes
          left: 130,
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            alignment: Alignment.center,
            height: 35.h,
            width: 110.w,
            decoration: BoxDecoration(
              color: AppColor.yellowStar,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Text(
              'You save 52%',
              style: GoogleFonts.inter(
                color: AppColor.bgColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700
              ),
            )
          ),
        ),
      ],
    );
  }
}