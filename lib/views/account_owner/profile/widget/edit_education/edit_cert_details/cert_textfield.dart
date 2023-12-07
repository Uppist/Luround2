import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class CertDetailsTextField extends StatefulWidget {
  const CertDetailsTextField ({super.key,required this.onChanged, required this.hintText, required this.initialValue, required this.keyboardType, required this.textInputAction});
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final String initialValue;

  @override
  State<CertDetailsTextField > createState() => _CertDetailsTextFieldState();
}

class _CertDetailsTextFieldState extends State<CertDetailsTextField> {


  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {},
      child: TextFormField(
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        minLines: 1,
        maxLines: 2,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.inter(color: AppColor.blackColor),
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(        
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Remove the border
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
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

class CertDetailsTextField2 extends StatefulWidget {
  const CertDetailsTextField2 ({super.key,required this.onChanged, required this.hintText, required this.initialValue, required this.keyboardType, required this.textInputAction});
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final String initialValue;

  @override
  State<CertDetailsTextField2> createState() => _CertDetailsTextField2State();
}

class _CertDetailsTextField2State extends State<CertDetailsTextField2> {


  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {},
      child: TextFormField(
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        minLines: 1,
        maxLines: 2,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.inter(color: AppColor.blackColor),
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(        
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Remove the border
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
          ),     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),              
          suffixIcon: Icon(
            CupertinoIcons.calendar,
            color: AppColor.darkGreyColor,
          ),
          //SvgPicture.asset("assets/svg/cert_calendar.svg", width: 10.w, height: 10.h,),
        ),
      ),
    );
  }
}