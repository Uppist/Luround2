import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/withdraw/otp/usual/set_pin_to_withdraw.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/withdraw/wallet/widget/black_card.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/withdraw/wallet/widget/green_card.dart';






class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key, required this.accountNumber, required this.accountName, required this.bankName, required this.bankCode, required this.wallet_balance, required this.receipientCode});
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final String receipientCode;
  final int wallet_balance;

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {

  final controller = Get.put(TransactionsController());
  
  @override
  void initState() {
    // TODO: implement initState
    controller.enterAmountController.addListener(() {
      setState(() {
        controller.isTrxNextButtoReady.value = controller.enterAmountController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Header
            /////////////
            SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
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
                    'Withdraw',
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            /////////
            SizedBox(height: 10.h),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),
            SizedBox(height: 20.h,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transfer to",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    BlackCard(
                      accountName: widget.accountName,
                      accountNumber: widget.accountNumber,
                      bank: widget.bankName,
                    ),
                    SizedBox(height: 30.h,),
                    Text(
                      "Transfer from",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    GreenCard(walletBalance: '${currency(context).currencySymbol}${widget.wallet_balance}',),
                    SizedBox(height: 30.h,),
                    Text(
                      "Enter Amount*",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    UtilsTextField(
                      onChanged: (val) {}, 
                      hintText: '', 
                      keyboardType: TextInputType.number, 
                      textInputAction: TextInputAction.next, 
                      textController: controller.enterAmountController
                    ),
                    SizedBox(height: 30.h,),
                    Text(
                      "Remark (Optional)",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    UtilsTextField(
                      onChanged: (val) {}, 
                      hintText: '', 
                      keyboardType: TextInputType.text, 
                      textInputAction: TextInputAction.done, 
                      textController: controller.enterRemarkController
                    ),
                    SizedBox(height: 70.h,),
                    //button
                    RebrandedReusableButton(
                      textColor: controller.isTrxNextButtoReady.value ? AppColor.bgColor : AppColor.darkGreyColor,
                      color: controller.isTrxNextButtoReady.value ? AppColor.mainColor : AppColor.lightPurple, 
                      text: "Next", 
                      onPressed: controller.isTrxNextButtoReady.value ? 
                      () {
                        Get.to(() => SetPinToWithdrawPage(
                          receipientCode: widget.receipientCode,
                          wallet_balance: widget.wallet_balance,
                          bankCode: widget.bankCode,
                          amount: controller.enterAmountController.text,
                          bank: widget.bankName,
                          accountName: widget.accountName,
                          accountNumber: widget.accountNumber,
                        ));
                      }
                      : () {
                        log('nothing');
                      },
                    ),
                    SizedBox(height: 20.h,),
        
                  ],
                ),
              )
            ),
          ]
        ),
      )
    );
  }
}