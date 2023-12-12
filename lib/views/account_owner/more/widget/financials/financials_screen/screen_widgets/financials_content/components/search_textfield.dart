import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class FinancialsSearchTextField extends StatefulWidget {
  const FinancialsSearchTextField({super.key, required this.onFieldSubmitted, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.onTap, required this.controller,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final void Function()? onTap;
  final FinancialsController controller;

  @override
  State<FinancialsSearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<FinancialsSearchTextField> {

  //var controller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Focus(
        onFocusChange: widget.onFocusChanged,
        child: TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          //onChanged: widget.onChanged,
          onTap: widget.onTap,
          controller: widget.textController,
          keyboardType: widget.keyboardType,
          maxLines: 1,
          autocorrect: true,
          inputFormatters: const [],
          enableSuggestions: true,
          enableInteractiveSelection: true,
          cursorColor: AppColor.textGreyColor,
          style: GoogleFonts.poppins(color: AppColor.textGreyColor),
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
            hintStyle: GoogleFonts.poppins(color: AppColor.textGreyColor, fontSize: 14.sp),              
            filled: true,
            fillColor: AppColor.bgColor,
            prefixIcon: Icon(CupertinoIcons.search, color: AppColor.textGreyColor, size: 20,),
            suffixIcon: widget.controller.isFieldTapped.value == true ?
            IconButton(
              onPressed:() {
                widget.controller.searchQuoteController.clear();
              },
              icon: Icon(
                CupertinoIcons.xmark, 
                color: AppColor.textGreyColor, 
                size: 20
              ),
            )
             : null
          ),
        ),
      ),
    );
  }
}