import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class RegPasswordTextField extends StatefulWidget {
  RegPasswordTextField({super.key,required this.onChanged, required this.labelText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.isObscured, required this.validator,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String labelText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  bool isObscured;
  
  

  @override
  State<RegPasswordTextField> createState() => _RegPasswordTextFieldState();
}

class _RegPasswordTextFieldState extends State<RegPasswordTextField> {

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
        //
        obscureText: widget.isObscured,
        obscuringCharacter: '*',
        decoration: InputDecoration(        
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Remove the border
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
          ),
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 13.sp),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.mainColor), // Set the color you prefer
          ),     
          labelText: widget.labelText,
          labelStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp),              
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                widget.isObscured = !widget.isObscured;
              });
              debugPrint("${widget.isObscured}");
            },
            child: widget.isObscured 
            ? Icon(Icons.visibility_outlined, color: AppColor.textGreyColor,) 
            : Icon(Icons.visibility_off_outlined, color: AppColor.textGreyColor,) 
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}