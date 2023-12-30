import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/profile/profile_page_controller.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class CountryFieldFlipper extends StatefulWidget {

  const CountryFieldFlipper({super.key, required this.text, required this.onFlip});
  final String text;
  final VoidCallback onFlip;

  @override
  State<CountryFieldFlipper> createState() => _CountryFieldFlipperState();
}

class _CountryFieldFlipperState extends State<CountryFieldFlipper> {

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
                  color: AppColor.textGreyColor, 
                  fontSize: 14.sp
                ),
              ),
              Container(
                child: controller.isCountrySelected.value ? Icon(
                  CupertinoIcons.chevron_up, 
                  color: AppColor.textGreyColor, 
                  size: 20,
                ) 
                :Icon(
                  CupertinoIcons.chevron_down, 
                  color: AppColor.textGreyColor, 
                  size: 20,
                )
              )
            ],
          ),
          SizedBox(height: 5.h,),
          Divider(thickness: 0.8, color: AppColor.darkGreyColor,)
        ],
      ),
    );
  }
}