import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class FpEmailTextField extends StatefulWidget {
  const FpEmailTextField({super.key,required this.onChanged, required this.labelText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.validator,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String labelText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  

  @override
  State<FpEmailTextField> createState() => _FpEmailTextFieldState();
}

class _FpEmailTextFieldState extends State<FpEmailTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 1,
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
            borderSide: BorderSide(color: AppColor.mainColor), // Set the color you prefer
          ), 
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
          ),
          //errorText: widget.errortext,
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 14.sp),    
          labelText: widget.labelText,
          labelStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp),              
          //filled: true,
          //fillColor: swapSpaceWhiteColor,
          //suffixIcon: widget.icon,
        ),
        validator: widget.validator,
      ),
    );
  }
}