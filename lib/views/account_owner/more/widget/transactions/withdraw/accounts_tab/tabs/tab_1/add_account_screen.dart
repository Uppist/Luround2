import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/transactions/withdraw/accounts_tab/tabs/tab_1/bank_field_flipper.dart';





class AddActionPageFromButton extends StatefulWidget {
  AddActionPageFromButton({super.key});

  @override
  State<AddActionPageFromButton> createState() => _AddActionPageFromButtonState();
}

class _AddActionPageFromButtonState extends State<AddActionPageFromButton> {
  var controller = Get.put(TransactionsController());

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
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 30.h),
                    Text(
                      'Input or Select Bank*',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(height: 50.h,),
                    BankFieldFlipper(
                      text: controller.inputBankController.text.isEmpty ? 'Tap to select' : controller.inputBankController.text,
                      onFlip: () {
                        setState(() {
                          controller.isBankSelected.value = true;
                        });
                      },
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'Account Number',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(height: 50.h,),
                  ]
                )
              )
            )
          )

        ]
      )
    );
  }
}