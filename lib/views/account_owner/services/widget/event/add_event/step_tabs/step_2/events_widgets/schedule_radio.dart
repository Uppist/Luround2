import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class CustomRadioWidget extends StatefulWidget {
  CustomRadioWidget({super.key, this.selectedValue,});
  RxString? selectedValue; // This will hold the selected value

  @override
  State<CustomRadioWidget> createState() => _CustomRadioWidgetState();
}

class _CustomRadioWidgetState extends State<CustomRadioWidget> {
  

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
              value: "Single date",
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
              "Single date",
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
              value: "Multiple dates",
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
              "Multiple dates",
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
