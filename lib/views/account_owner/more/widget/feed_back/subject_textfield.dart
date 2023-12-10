import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';










class SubjectTextField extends StatefulWidget {
  const SubjectTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.controller,});
  //final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  State<SubjectTextField> createState() => _SubjectTextFieldState();
}

class _SubjectTextFieldState extends State<SubjectTextField> {

  //var controller = Get.put(MoreController());

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {},
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        minLines: 1,
        maxLines: 2,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.inter(
          color: AppColor.blackColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400
        ),
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
          hintStyle: GoogleFonts.inter(
            color: AppColor.textGreyColor, 
            fontSize: 14.sp,
            fontWeight: FontWeight.w400
          ),              
          //filled: true,
          //fillColor: swapSpaceWhiteColor,
          //suffixIcon: Icon(CupertinoIcons.chevron_down, color: AppColor.textGreyColor, size: 20,)
        ),
      ),
    );
  }
}