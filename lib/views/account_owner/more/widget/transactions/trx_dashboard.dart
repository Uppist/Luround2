import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';





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
        horizontal: 20, 
        vertical: 30, 
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.center,
                  height: 50,
                  width: 250,
                  //width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.badGreen,
                    borderRadius: BorderRadius.circular(10),
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
                                fontSize: 15,
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
          SizedBox(height: 60,),
          Obx(
            () {
              return Text(
                controller.isTrxAmountToggled.value ? amountReceived : amountPaid,
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              );
            }
          ),
        ]
      )
    );
  }
}