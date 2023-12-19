import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/profile_page_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';










class CertificationTextField extends StatefulWidget {
  const CertificationTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.onFocusChange, required this.textController,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChange;


  @override
  State<CertificationTextField> createState() => _CertificationTextFieldState();
}

class _CertificationTextFieldState extends State<CertificationTextField> {

  var controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChange,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        autocorrect: true,
        inputFormatters: const [],
        minLines: 1,
        maxLines: 10,
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
          /*suffixIcon:InkWell(
            onTap: widget.onSuffixIconTapped,
            child: controller.isSuffixIconTapped.value ? Icon(
              CupertinoIcons.chevron_down, 
              color: AppColor.textGreyColor, 
              size: 20,
            ) 
            : Icon(
                CupertinoIcons.chevron_up, 
                color: AppColor.textGreyColor, 
                size: 20,
              )
          )*/
        ),
      ),
    );
  }
}