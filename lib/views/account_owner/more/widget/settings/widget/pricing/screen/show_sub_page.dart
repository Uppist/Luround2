import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/settings/billings/widgets/add_card_button.dart';
import 'package:luround/views/account_owner/more/widget/settings/billings/widgets/payment_card.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/billing_history_display.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/upgrade_button.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/screen/payment_screen_for_app.dart';









class ShowSubscriptionPage extends StatelessWidget {

  ShowSubscriptionPage({super.key});
   
  var controller = Get.put(MoreController());
  var service = Get.put(SettingsService());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section/////
            /*Container(
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
            ),*/
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
                    "Pricing",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
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
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Plan",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),

                      SizedBox(height: 5.h,),
                      Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      SizedBox(height: 15.h,),
                      
                      Text(
                        "You are on a 30 days free trial plan",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),


                      SizedBox(height: 30.h,),
                      Text(
                        "N0.00",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),

                      SizedBox(height: 30.h,),
                      //upgrade/change subscription plan
                      UpgradeButton(
                        onPressed: () {
                          Get.to(() => const SubscriptionScreenInApp());
                        },
                      ),
        
                      //SizedBox(height: 2,),
                      
                      SizedBox(height: 50.h,),

                      //see billing history
                      Obx(
                        () {
                          return InkWell(
                            onTap: () {
                              service.isBillingHistoryActive.value = !service.isBillingHistoryActive.value;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "See Billing History",
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                service.isBillingHistoryActive.value ?
                                Icon(
                                  CupertinoIcons.chevron_down,
                                  color: AppColor.blackColor,
                                  size: 24.r,
                                )
                                :Icon(
                                  CupertinoIcons.chevron_right,
                                  color: AppColor.blackColor,
                                  size: 24.r,
                                )
                              ],
                            ),
                          );
                        }
                      ),
                      //SizedBox(height: 2,),
                      Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      const SizedBox(height: 20,),
                      Obx(
                        () {
                          return service.isBillingHistoryActive.value ? ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical, 
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(height: 20.h,), 
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return const BillingHistoryDisplay(
                                payment_date: 'March 20, 2025',
                                plan_type: 'Monthly plan',
                                amount: 'N4,200',
                              );
                            }
                          ): const SizedBox();
                        }
                      ),

                      
                      
                      /////EXPANDED/////
                      //NoPaymentMethodText(), //wrap with future builder
                      /*ListView.separated(
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
                      ),*/
                      
        
              
              
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
