import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/payment_service.dart/paystack_client_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/custom_row.dart';





class MonthlySubscriptionPageAuth extends StatelessWidget {
  MonthlySubscriptionPageAuth({super.key,});

  var paystackService = Get.put(PaystackClientService());

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            SizedBox(height: 5.h),
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
                      text: "${currency(context).currencySymbol}1,200",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700
                      )
                    ),
                    TextSpan(
                      text: "/month",
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
            SizedBox(height: 60.h,),
            RebrandedReusableButton(
              color: AppColor.navyBlue, 
              text: "Choose Plan", 
              onPressed: () {
                //call paystack api
                paystackService.payWithPaystackForAuth(
                  context: context, 
                  realAmount: 1200, 
                  companyEmail: "support@luround.com",
                );
              }, 
              textColor: AppColor.bgColor,
            ),
          ],
        ),
      ),
    );
  }
}




class MonthlySubscriptionPageApp extends StatelessWidget {
  MonthlySubscriptionPageApp({super.key,});

  var paystackService = Get.put(PaystackClientService());

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            SizedBox(height: 5.h),
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
                      text: "${currency(context).currencySymbol}1,200",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700
                      )
                    ),
                    TextSpan(
                      text: "/month",
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
            SizedBox(height: 60.h,),
            RebrandedReusableButton(
              color: AppColor.navyBlue, 
              text: "Choose Plan", 
              onPressed: () {
                //call paystack api
                paystackService.payWithPaystackForApp(
                  context: context, 
                  realAmount: 1200, 
                  companyEmail: "support@luround.com",
                );
              }, 
              textColor: AppColor.bgColor,
            ),
          ],
        ),
      ),
    );
  }
}