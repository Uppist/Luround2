import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/qoutes/sent_quotes/sent_quotes_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class CTVDueDateTextField extends StatefulWidget {
  const CTVDueDateTextField({super.key, required this.onFieldSubmitted, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, required this.initialValue,});
  final TextInputType keyboardType;
  final String hintText;
  final String initialValue;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;

  @override
  State<CTVDueDateTextField> createState() => _CTVDueDateTextFieldState();
}

class _CTVDueDateTextFieldState extends State<CTVDueDateTextField> {


  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: SizedBox(
        height: 50.h,
        width: 110.w,
        child: TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          //onChanged: widget.onChanged
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          maxLines: 1,
          autocorrect: true,
          inputFormatters: const [],
          enableSuggestions: true,
          enableInteractiveSelection: true,
          cursorColor: AppColor.textGreyColor,
          style: GoogleFonts.inter(color: AppColor.darkGreyColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
          textCapitalization: TextCapitalization.sentences,
          textInputAction: widget.textInputAction,          
          scrollPhysics: const BouncingScrollPhysics(),
          decoration: InputDecoration(        
            /*border: OutlineInputBorder(
              borderSide: BorderSide.none, // Remove the border
            ),*/
            contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textGreyColor.withOpacity(0.1)), // Set the color you prefer
              borderRadius: BorderRadius.circular(12.r)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
              borderRadius: BorderRadius.circular(12.r)
            ),     
            hintText: widget.hintText,
            hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 12.sp),              
            filled: true,
            fillColor: AppColor.bgColor,
          ),
        ),
      ),
    );
  }
}







class CTVDiscountTextField extends StatefulWidget {
  const CTVDiscountTextField({super.key, required this.onFieldSubmitted, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, required this.initialValue,});
  final TextInputType keyboardType;
  final String hintText;
  final String initialValue;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;

  @override
  State<CTVDiscountTextField> createState() => _CTVDiscountTextFieldState();
}

class _CTVDiscountTextFieldState extends State<CTVDiscountTextField> {


  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: SizedBox(
        height: 50.h,
        width: 70.w,
        child: TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          //onChanged: widget.onChanged
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          maxLines: 1,
          autocorrect: true,
          inputFormatters: const [],
          enableSuggestions: true,
          enableInteractiveSelection: true,
          cursorColor: AppColor.textGreyColor,
          style: GoogleFonts.inter(color: AppColor.darkGreyColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
          textCapitalization: TextCapitalization.sentences,
          textInputAction: widget.textInputAction,          
          scrollPhysics: const BouncingScrollPhysics(),
          decoration: InputDecoration(        
            /*border: OutlineInputBorder(
              borderSide: BorderSide.none, // Remove the border
            ),*/
            contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textGreyColor.withOpacity(0.1)), // Set the color you prefer
              borderRadius: BorderRadius.circular(12.r)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
              borderRadius: BorderRadius.circular(12.r)
            ),     
            hintText: widget.hintText,
            hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 12.sp),              
            filled: true,
            fillColor: AppColor.bgColor,
          ),
        ),
      ),
    );
  }
}