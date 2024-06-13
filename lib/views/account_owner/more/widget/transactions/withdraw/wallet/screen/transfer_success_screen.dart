import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/reusable_white_button.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/transactions_screen.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/screen/withdrawal_receipt.dart';



class TransferFundsSuccessScreen extends StatelessWidget {
  TransferFundsSuccessScreen({super.key, required this.amount, required this.account_name, required this.account_number, required this.bank_name, required this.transaction_ref, required this.transaction_date, required this.transaction_time});

  final String amount;
  final String account_name;
  final String account_number;
  final String bank_name;
  final String transaction_ref;
  final int transaction_date;
  final int transaction_time;


  final MainPageController mainPageController = MainPageController();
  final trxController = Get.put(TransactionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Success",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  InkWell(
                    onTap: () {
                      Get.offUntil(GetPageRoute(page: () => TransactionPage()), (route) => false);
                    },
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: AppColor.darkGreyColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Divider(color: AppColor.textGreyColor, thickness: 0.3,),
              SizedBox(height: 30.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "You have successfully withdrawn ",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "${currency(context).currencySymbol}$amount ",
                      style: GoogleFonts.inter(
                        color: AppColor.mainColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    TextSpan(
                      text: "from your wallet",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ]
                )
              ),
              SizedBox(height: 200.h,),
              Center(
                child: SvgPicture.asset("assets/svg/check_ss.svg", width: 120.w, height: 120.h,)
              ),
              SizedBox(height: 210.h,),
              ReusableButton(
                color: AppColor.mainColor,
                text: 'Withdrawal Receipt',
                onPressed: () async{
                  Get.offAll(() => WithdrawalReceipt(
                    amount: amount,
                    remark: trxController.enterRemarkController.text,
                    account_name: account_name,
                    account_number: account_number,
                    bank_name: bank_name,
                    transaction_ref: transaction_ref,
                    transaction_date: transaction_date,
                    transaction_time: transaction_time,
                  ));
                },
              ),
              SizedBox(height: 30.h,),
              ReusableWhiteButton(
                color: AppColor.bgColor,
                text: 'Exit',
                onPressed: () async{
                  Get.offUntil(GetPageRoute(page: () => TransactionPage()), (route) => false);
                },
              ),
              SizedBox(height: 20.h,),
            ]
          ),
        )
      )
    );
  }
}