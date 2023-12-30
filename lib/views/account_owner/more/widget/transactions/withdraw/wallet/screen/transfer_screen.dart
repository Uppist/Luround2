import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/otp/usual/set_pin%20to%20withdraw.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/widget/black_card.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/wallet/widget/green_card.dart';






class TransferScreen extends StatefulWidget {
  TransferScreen({super.key, required this.accountNumber, required this.accountName, required this.bankName, required this.bankCode, required this.wallet_balance});
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final int wallet_balance;

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {

  var controller = Get.put(TransactionsController());
  
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Withdraw',),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                  GreenCard(walletBalance: 'N${widget.wallet_balance}',),
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
                        wallet_balance: widget.wallet_balance,
                        bankCode: widget.bankCode,
                        amount: controller.enterAmountController.text,
                        bank: widget.bankName,
                        accountName: widget.accountName,
                        accountNumber: widget.accountNumber,
                      ));
                    }
                    : () {
                      print('nothing');
                    },
                  ),
                  SizedBox(height: 20.h,),

                ],
              ),
            )
          ),
        ]
      )
    );
  }
}