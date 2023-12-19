import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class SettingsPasswordTextField extends StatefulWidget {
  SettingsPasswordTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.isObscured});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  bool isObscured;

  @override
  State<SettingsPasswordTextField> createState() => _SettingsPasswordTextFieldState();
}

class _SettingsPasswordTextFieldState extends State<SettingsPasswordTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 1,
        //minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        obscureText: widget.isObscured,
        obscuringCharacter: '*',
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
          //labelText: widget.hintText,
          //labelStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 16.sp), 
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
          //filled: true,
          //fillColor: swapSpaceWhiteColor,
          //suffixIcon: Icon(CupertinoIcons.chevron_down, color: AppColor.textGreyColor, size: 20,)
        ),
      ),
    );
  }
}


//for otp field
class SettingsPasswordTextField2 extends StatefulWidget {
  SettingsPasswordTextField2({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.initialValue, this.onFocusChanged, required this.isObscured});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  bool isObscured;

  @override
  State<SettingsPasswordTextField2> createState() => _SettingsPasswordTextField2State();
}

class _SettingsPasswordTextField2State extends State<SettingsPasswordTextField2> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        maxLines: 1,
        //minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        obscureText: widget.isObscured,
        obscuringCharacter: '*',
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
          //labelText: widget.hintText,
          //labelStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 16.sp), 
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
          //filled: true,
          //fillColor: swapSpaceWhiteColor,
          //suffixIcon: Icon(CupertinoIcons.chevron_down, color: AppColor.textGreyColor, size: 20,)
        ),
      ),
    );
  }
}