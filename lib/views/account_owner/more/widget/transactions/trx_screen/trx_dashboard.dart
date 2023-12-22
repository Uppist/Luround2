import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/models/account_owner/more/wallet_balance.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/toggle_account_balance.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/screen/select_account_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/otp/first_timer/otp_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/select_country/select_country.dart';





class TrxDashBoard extends StatelessWidget {
  TrxDashBoard({super.key,});


  var controller = Get.put(TransactionsController());
  var service = Get.put(WithdrawalService());

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<WalletBalance>(
      future: service.getUserWalletBalance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            height: 210.h,
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w, 
              vertical: 30.h, 
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColor.badGreen,
              /*boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5) ,//withOpacity(0.2),
                  spreadRadius: 0.5,
                  blurRadius: 5.0,
                )
              ],*/
            ),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-data: ${snapshot.data}");
        }
        if (snapshot.hasData) {

          var data = snapshot.data!; 
          return Container(
            alignment: Alignment.center,
            //height: 300,
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w, 
              vertical: 30.h, 
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColor.badGreen,
              /*boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5) ,//withOpacity(0.2),
                  spreadRadius: 0.5,
                  blurRadius: 5.0,
                )
              ],*/
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        toggleAccountBalance(
                          context: context,
                          onAmountPaidBalance: () {
                            controller.filterMoneyTypeList('Total amount paid')
                            .whenComplete(() => Get.back());
                          },
                          onAmountReceivedBalance: () {
                            controller.filterMoneyTypeList('Total amount received')
                            .whenComplete(() => Get.back());
                          },
                          onWalletBalance: () {
                            controller.filterMoneyTypeList('Wallet')
                            .whenComplete(() => Get.back());
                          }
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                        alignment: Alignment.center,
                        height: 50.h,
                        width: 230.w,
                        //width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.badGreen,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColor.whiteTextColor,
                            width: 0.8
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                      
                            Obx(
                              () {
                                return Text(
                                  controller.selectedMoneyType.value == "Total amount received" ?  "Total amount received" : controller.selectedMoneyType.value == "Total amount paid" ? "Total amount paid" : "Wallet",
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: AppColor.whiteTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    )
                                  )
                                );
                              }
                            ),                                        
                            Icon(
                              CupertinoIcons.chevron_up_chevron_down,
                              color: AppColor.bgColor,
                              size: 20,
                            )
                          ],
                        ),                
                      ),
                    )
                  ],
                ),
                SizedBox(height: 60.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () {
                        return Text(
                          controller.selectedMoneyType.value == "Total amount received" ?  "N100" : controller.selectedMoneyType.value == "Total amount paid" ? "N200" : "N${data.wallet_balance}",
                          style: GoogleFonts.inter(
                            color: AppColor.bgColor,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold
                          ),
                        );
                      }
                    ),
                    InkWell(
                      onTap: () {
                        //TODO: Boolean check//
                        Get.to(() => InputPinPage());
                        //Get.to(() => SelectCountryPage());
                      },
                      child: Text(
                        "Withdraw",
                        style: GoogleFonts.inter(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.whiteTextColor,
                          decorationThickness: 1.5,
                          color: AppColor.whiteTextColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            )
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
      
    );
  }
}