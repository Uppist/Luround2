import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class AmountTextField extends StatefulWidget {
  const AmountTextField ({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {

  var serviceController = Get.put(ServicesController());

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
          hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp),              
          //filled: true,
          //fillColor: swapSpaceWhiteColor,
          prefixIcon: Image.asset('assets/images/naija_flag.png')
          /*InkWell(
            onTap: () {
              serviceController.showNiceCurrencyPickerAdd(context: context);
            },
            child: Icon(
              CupertinoIcons.add_circled,
              color: AppColor.blackColor,
            ),
          ),*/
        ),
      ),
    );
  }
}