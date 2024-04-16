import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/models/account_owner/more/pricing/billing_history_model.dart';
import 'package:luround/models/account_owner/more/pricing/user_subscription_model.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/no_billing_history.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/billing_history_display.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/widget/upgrade_button.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/pricing/payment_screen/payment_screen_for_app.dart';









class ShowSubscriptionPage extends StatefulWidget {

  const ShowSubscriptionPage({super.key});

  @override
  State<ShowSubscriptionPage> createState() => _ShowSubscriptionPageState();
}

class _ShowSubscriptionPageState extends State<ShowSubscriptionPage> {


  var controller = Get.put(MoreController());
  var service = Get.put(SettingsService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Fetch new data here
    final List<BillingHistoryResponse>  newData = await service.getUserBillingHistory();
    // Update the UI with the new data
    service.billingHistoryList.clear();
    service.billingHistoryList.addAll(newData);
    print('updated billing history list: ${service.billingHistoryList}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.getUserBillingHistory().then((value) {
      service.billingHistoryList.value = value;
      print("initialized billing history list: ${service.billingHistoryList}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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

                      //FUTUREBUILDER
                      FutureBuilder<UserSubscriptionResponse>(
                        future: service.getUserSubscriptionPlan(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Loader2();
                          }
                          if (snapshot.hasError) {
                            debugPrint("${snapshot.error}");
                          }
                          if (!snapshot.hasData) {
                            print("sn-trace: ${snapshot.stackTrace}");
                            print("sn-data: ${snapshot.data}");
                            //return Loader2(); 
                          }
         
                          if (snapshot.hasData) {
                            var data = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.subscription_plan == "Trial" ? "You are on a 30 days free trial plan" : data.subscription_plan == "Monthly" ? "You are on a monthly plan" : "You are on a yearly plan",
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(height: 30.h,),
                                Text(
                                  data.subscription_plan == "Trial" ? "N0.00" : data.subscription_plan == "Monthly" ? "N4,200" : "N30,000",
                                  style: GoogleFonts.inter(
                                    color: AppColor.blackColor,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            );
                          }
                          return Center(
                            child: Text(
                              "connection timed out",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal
                              )
                            )
                          );
                        }
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
                          return service.isBillingHistoryActive.value || service.billingHistoryList.isNotEmpty ?
                          RefreshIndicator.adaptive(
                            color: AppColor.greyColor,
                            backgroundColor: AppColor.mainColor,
                            key: _refreshKey,
                            onRefresh: () {
                              return _refresh();
                            },
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical, 
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => SizedBox(height: 20.h,), 
                              itemCount: service.billingHistoryList.length,
                              itemBuilder: (context, index) {
                                final data = service.billingHistoryList[index];
                                return BillingHistoryDisplay(
                                  payment_date: convertStringServerTimeToDate(data.date),
                                  plan_type: data.plan,
                                  amount: 'N${data.amount}',
                                );
                              }
                            ),
                          ): const SizedBox(); //const NoBillingHistoryState();
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
