import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/OTP/first_timer/otp_screen.dart';





class TrxDashBoard extends StatelessWidget {
  TrxDashBoard({super.key, required this.amountPaid, required this.amountReceived,});
  final String amountPaid;
  final String amountReceived;

  var controller = Get.put(TransactionsController());

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
                  controller.toggleTrx();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 250.w,
                  //width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.badGreen,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.bgColor,
                      width: 0.8
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Obx(
                        () {
                          return Text(
                            controller.isTrxAmountToggled.value ? "Total amount received" : "Total amount paid",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.bgColor,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
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
              ),
            ],
          ),
          SizedBox(height: 60.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () {
                  return Text(
                    controller.isTrxAmountToggled.value ? amountReceived : amountPaid,
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
                  Get.to(() => InputPinPage());
                },
                child: Text(
                  "Withdraw",
                  style: GoogleFonts.inter(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.bgColor,
                    decorationThickness: 1.5,
                    color: AppColor.bgColor,
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
}