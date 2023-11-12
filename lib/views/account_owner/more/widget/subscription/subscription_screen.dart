import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/subscription/add_card_button.dart';
import 'package:luround/views/account_owner/more/widget/subscription/no_payment_method.dart';
import 'package:luround/views/account_owner/more/widget/subscription/payment_card.dart';
import 'package:luround/views/account_owner/more/widget/subscription/upgrade_button.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';









class SubscriptionScreen extends StatelessWidget {

  SubscriptionScreen({super.key});
   
  var controller = Get.put(MoreController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section/////
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: SvgPicture.asset("assets/svg/notify_active.svg"),
                      ),
                    ]
                  ),
                ]
              )
            ),
            /////////////////////////////////////////////
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),
            ///Navigation Section/////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w,),
              height: 70.h, //65
              width: double.infinity,
              color: AppColor.bgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.blackColor,
                    )
                  ),
                  SizedBox(width: 3.w,),
                  Text(
                    "Subscription",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),
            SizedBox(height: 10.h,),
          
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Plan",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      SizedBox(height: 10.h,),
                      Text(
                        "You are using the free plan",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      //upgrade subscription plan
                      UpgradeButton(onPressed: () {},),
                      SizedBox(height: 20.h,),
                      //payment method row (add card)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Method",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          AddCardButton(onPressed: () { },)
                        ],
                      ),
                      //SizedBox(height: 2,),
                      Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      SizedBox(height: 20.h,),
                      
                      
                      /////EXPANDED/////
                      //NoPaymentMethodText(), //wrap with future builder
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical, 
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: 30.h,), 
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return PaymentCard(
                            cardType: "MasterCard",
                            cardNuber: "Master 1234****567877",
                            expiryDate: "Expires 12/23",
                            onEditPressed: () {}, 
                            onDelete: () {}
                          );
                        }
                      ),
                      SizedBox(height: 40.h,),
                      //see billing history
                      InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "See Billing History",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: AppColor.blackColor,
                            )
                          ],
                        ),
                      ),
                      //SizedBox(height: 2,),
                      Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
              
              
                    ],
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}
