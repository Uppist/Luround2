import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class UtilsTextField extends StatefulWidget {
  const UtilsTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;

  @override
  State<UtilsTextField> createState() => _UtilsTextFieldState();
}

class _UtilsTextFieldState extends State<UtilsTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 10,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.inter(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
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
          labelText: widget.hintText,
          //labelStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 16.sp),
          labelStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        ),
      ),
    );
  }
}


//this one has initial value
class UtilsTextField2 extends StatefulWidget {
  const UtilsTextField2({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.initialValue, this.onFocusChanged,});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;

  @override
  State<UtilsTextField2> createState() => _UtilsTextField2State();
}

class _UtilsTextField2State extends State<UtilsTextField2> {

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
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.inter(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(        
          border: const OutlineInputBorder(
            borderSide: BorderSide.none, // Remove the border
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
          ),     
          hintText: widget.hintText,
          //labelStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 16.sp),
          hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        ),
      ),
    );
  }
}


class UtilsTextField3 extends StatefulWidget {
  const UtilsTextField3({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, this.onFieldSubmitted,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;

  @override
  State<UtilsTextField3> createState() => _UtilsTextField3State();
}

class _UtilsTextField3State extends State<UtilsTextField3> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 10,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.inter(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
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
        ),
      ),
    );
  }
}




//textfield specifically for service price creation
class UtilsTextField4 extends StatefulWidget {
  const UtilsTextField4({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, this.onFieldSubmitted, required this.textController,});
  //final IconData icon;
  final TextEditingController textController;
  //final String? initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;

  @override
  State<UtilsTextField4> createState() => _UtilsTextField4State();
}

class _UtilsTextField4State extends State<UtilsTextField4> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: SizedBox(
        height: 50.h,
        child: TextFormField(
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          controller: widget.textController,
          //initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          maxLines: 2,
          minLines: 1,
          autocorrect: true,
          inputFormatters: const [],
          enableSuggestions: true,
          enableInteractiveSelection: true,
          cursorColor: AppColor.darkGreyColor,
          //style: GoogleFonts.inter(color: AppColor.blackColor),
          style: GoogleFonts.inter(color: AppColor.darkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
          textCapitalization: TextCapitalization.sentences,
          textInputAction: widget.textInputAction,          
          scrollPhysics: const BouncingScrollPhysics(),
          decoration: InputDecoration(     
            /*prefixIcon: Icon(
              widget.icon,
              size: 24.r,
              color: AppColor.darkGreyColor,
            ),*/
        
            
            contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),  
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColor.redColor), // Set the color you prefer
            ),
            fillColor: AppColor.bgColor, 
            filled: true, 
            
        
            /*border: OutlineInputBorder(
              borderSide: BorderSide.none, // Remove the border
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
            ),*/ 
          
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400), 
            errorStyle: GoogleFonts.poppins(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
