import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class PriceTypeRadioWidget extends StatefulWidget {
  PriceTypeRadioWidget({super.key, this.selectedValue,});
  RxString? selectedValue; // This will hold the selected value

  @override
  State<PriceTypeRadioWidget> createState() => _PriceTypeRadioWidgetState();
}

class _PriceTypeRadioWidgetState extends State<PriceTypeRadioWidget> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //1
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              activeColor: AppColor.mainColor,
              //toggleable: true,
              value: "Virtual",
              groupValue: widget.selectedValue!.value,
              onChanged: (String? value) {
                setState(() {
                  widget.selectedValue!.value = value!;
                  log("${widget.selectedValue}");
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "Virtual",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        //2
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              activeColor: AppColor.mainColor,
              //toggleable: true,
              value: "In-person",
              groupValue: widget.selectedValue!.value,
              onChanged: (String? value) {
                setState(() {
                  widget.selectedValue!.value = value!;
                  log("${widget.selectedValue}");
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "In-person",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        //3
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              activeColor: AppColor.mainColor,
              //toggleable: true,
              value: "Both",
              groupValue: widget.selectedValue!.value,
              onChanged: (String? value) {
                setState(() {
                  widget.selectedValue!.value = value!;
                  log("${widget.selectedValue}");
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "Both",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ],
    );
  }
}
