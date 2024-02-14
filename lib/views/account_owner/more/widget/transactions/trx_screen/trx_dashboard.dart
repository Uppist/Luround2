import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/models/account_owner/more/transactions/wallet_balance.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/toggle_account_balance.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/screen/select_account_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/otp/first_timer/otp_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/select_country/select_country.dart';





class TrxDashBoard extends StatefulWidget {
  TrxDashBoard({super.key,});

  @override
  State<TrxDashBoard> createState() => _TrxDashBoardState();
}

class _TrxDashBoardState extends State<TrxDashBoard> {


  var controller = Get.put(TransactionsController());
  var service = Get.put(WithdrawalService());
  bool isTapped = false;

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        /*toggleAccountBalance(
                          context: context,
                          onAmountPaidBalance: () {

                            /*controller.filterMoneyTypeList('Total amount paid')
                            .whenComplete(() {
                              service.isTotalAmountPaidCalculated.value 
                              ? print("already calculated")
                              : service.calculateTotalAmountPaid().whenComplete(() => Get.back());
                            });*/
                          },
                          onAmountReceivedBalance: () {
                            controller.filterMoneyTypeList('Total amount received')
                            .whenComplete(() {
                              service.isTotalAmountReceivedCalculated.value
                              ? print("already calculated")
                              : service.calculateTotalAmountReceived().whenComplete(() => Get.back());
                            });
                          },
                          onWalletBalance: () {
                            /*controller.filterMoneyTypeList('Wallet')
                            .whenComplete(() => Get.back());*/
                          }
                        );*/
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
                          
                            Text(
                              "Total amount received", //?  "Total amount received" : "", //controller.selectedMoneyType.value == "Total amount paid" ? "Total amount paid" : "Wallet", //wallet
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColor.whiteTextColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              )
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
                    Text(
                      isTapped ? "N${double.parse("${service.totalAmountReceived}")}" : "****",
                      //controller.selectedMoneyType.value == "Total amount received" ?  "N${double.parse("${service.totalAmountReceived}")}" : "", //controller.selectedMoneyType.value == "Total amount paid" ? "N${double.parse("${service.totalAmountPaid}")}" : "N${double.parse("${data.wallet_balance}")}",
                      style: GoogleFonts.inter(
                        color: AppColor.bgColor,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    InkWell(
                      onTap: () {

                        setState(() {
                          isTapped = !isTapped;
                        });
                        
                        if(isTapped) {
                          controller.filterMoneyTypeList('Total amount received')
                          .whenComplete(() {
                            service.isTotalAmountReceivedCalculated.value
                            ? print("already calculated")
                            : service.calculateTotalAmountReceived(); //.whenComplete(() => Get.back());
                          });
                        }
                        
                      },
                      child: isTapped ? Icon(
                        Icons.visibility_outlined,
                        color: AppColor.whiteTextColor,
                      ) : Icon(
                        Icons.visibility_off_outlined,
                        color: AppColor.whiteTextColor,
                      ),
                    )

                    /*InkWell(
                      onTap: () {
                        //TODO: Boolean check//
                        data.has_wallet_pin 
                        ?Get.to(() => SelectCountryPage(
                          wallet_balance: data.wallet_balance,
                        ))
                        :Get.to(() => InputPinPage(
                          wallet_balance: data.wallet_balance,
                        ));
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
                    ),*/
                  ],
                ),
              ]
            )
          );
        
  }
}