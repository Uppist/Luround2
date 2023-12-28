import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class BorderTextField extends StatefulWidget {
  const BorderTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.initialValue, this.onFocusChanged,});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;

  @override
  State<BorderTextField> createState() => _BorderTextFieldState();
}

class _BorderTextFieldState extends State<BorderTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        maxLines: 10,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.inter(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(        
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Remove the border
            borderRadius: BorderRadius.circular(10.r)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
            borderRadius: BorderRadius.circular(10.r)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
            borderRadius: BorderRadius.circular(10.r)
          ),     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),              
          //filled: true,
          //fillColor: swapSpaceWhiteColor,
          //suffixIcon: Icon(CupertinoIcons.chevron_down, color: AppColor.textGreyColor, size: 20,)
        ),
      ),
    );
  }
}





////[DISCOUNT TEXTFIELD]////
class DiscountTextField extends StatefulWidget {
  const DiscountTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.initialValue, this.onFocusChanged,});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;

  @override
  State<DiscountTextField> createState() => _DiscountTextFieldState();
}

class _DiscountTextFieldState extends State<DiscountTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        maxLines: 10,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.inter(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(        
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Remove the border
            borderRadius: BorderRadius.circular(10.r)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
            borderRadius: BorderRadius.circular(10.r)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
            borderRadius: BorderRadius.circular(10.r)
          ),     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),              
          //filled: true,
          //fillColor: swapSpaceWhiteColor,
          suffixIcon: Icon(
            CupertinoIcons.percent, 
            color: AppColor.darkGreyColor, 
            size: 20,
          )
        ),
      ),
    );
  }
}