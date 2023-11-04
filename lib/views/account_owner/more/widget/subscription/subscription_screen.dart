import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              height: 7,
            ),
            ///Navigation Section/////
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7,),
              height: 70, //65
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
                  SizedBox(width: 3,),
                  Text(
                    "Subscription",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7,
            ),
            SizedBox(height: 10,),
          
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Plan",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 5,),
                      Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      SizedBox(height: 10,),
                      Text(
                        "You are using the free plan",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      //upgrade subscription plan
                      UpgradeButton(onPressed: () {},),
                      SizedBox(height: 20,),
                      //payment method row (add card)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Method",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          AddCardButton(onPressed: () { },)
                        ],
                      ),
                      //SizedBox(height: 2,),
                      Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
                      SizedBox(height: 20,),
                      
                      
                      /////EXPANDED/////
                      //NoPaymentMethodText(), //wrap with future builder
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical, 
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: 30,), 
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
                      SizedBox(height: 40,),
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
                                fontSize: 16,
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
