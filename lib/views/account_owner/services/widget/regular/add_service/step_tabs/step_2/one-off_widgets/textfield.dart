import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookings/bookings_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class OneoffTextField extends StatefulWidget {
  const OneoffTextField({super.key, required this.onFieldSubmitted, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, this.width, required this.prefixIcon, this.onChanged,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final double? width;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final void Function(String)? onChanged;
  final Widget prefixIcon;
  

  @override
  State<OneoffTextField> createState() => _OneoffTextFieldState();
}

class _OneoffTextFieldState extends State<OneoffTextField> {

  var controller = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widget.width,
      child: Focus(
        onFocusChange: widget.onFocusChanged,
        child: TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          controller: widget.textController,
          keyboardType: widget.keyboardType,
          maxLines: 1,
          autocorrect: true,
          inputFormatters: const [],
          enableSuggestions: true,
          enableInteractiveSelection: true,
          cursorColor: AppColor.textGreyColor,
          style: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
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
            hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 12.sp, fontWeight: FontWeight.w400),              
            filled: true,
            fillColor: AppColor.bgColor,
            prefixIcon: widget.prefixIcon,
            //prefixIconConstraints: BoxConstraints.loose()
          ),
        ),
      ),
    );
  }
}