import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class BankFieldFlipper2 extends StatefulWidget {

  const BankFieldFlipper2({super.key, required this.text, required this.onFlip});
  final String text;
  final VoidCallback onFlip;

  @override
  State< BankFieldFlipper2> createState() => _BankFieldFlipper2State();
}

class _BankFieldFlipper2State extends State< BankFieldFlipper2> {

  var controller = Get.put(TransactionsController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFlip,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor, 
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Container(
                child: controller.isBankSelected2.value ? Icon(
                  CupertinoIcons.chevron_up, 
                  color: AppColor.blackColor, 
                  size: 20,
                ) 
                :Icon(
                  CupertinoIcons.chevron_down, 
                  color: AppColor.blackColor, 
                  size: 20,
                )
              )
            ],
          ),
          SizedBox(height: 5.h,),
          Divider(thickness: 0.8, color: AppColor.blackColor,)
        ],
      ),
    );
  }
}