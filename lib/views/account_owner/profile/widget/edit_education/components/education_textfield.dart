import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/profile/profile_page_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class EducationTextField extends StatefulWidget {
  const EducationTextField ({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.controller,});
  final TextInputType keyboardType;
  final String hintText;
  //final VoidCallback onSuffixIconTapped;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  @override
  State<EducationTextField > createState() => _EducationTextFieldState();
}

class _EducationTextFieldState extends State<EducationTextField> {

  var controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        controller.updateEducationFocus(hasFocus);
      },
      child: TextFormField(
        //onTap: widget.onSuffixIconTapped,
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        autocorrect: true,
        inputFormatters: const [],
        minLines: 1,
        maxLines: 10,
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(color: AppColor.blackColor),
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
          /*suffixIcon:InkWell(
            onTap: widget.onSuffixIconTapped,
            child: controller.isSuffixIconTapped.value ? Icon(
              CupertinoIcons.chevron_up, 
              color: AppColor.textGreyColor, 
              size: 20,
            ) 
            : Icon(
                CupertinoIcons.chevron_down, 
                color: AppColor.textGreyColor, 
                size: 20,
              )
          )*/
        ),
      ),
    );
  }
}