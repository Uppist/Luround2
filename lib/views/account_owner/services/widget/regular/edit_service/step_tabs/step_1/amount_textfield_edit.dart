import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class AmountTextFieldEdit extends StatefulWidget {
  AmountTextFieldEdit({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, required this.initialValue,});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  

  @override
  State<AmountTextFieldEdit> createState() => _AmountTextFieldEditState();
}

class _AmountTextFieldEditState extends State<AmountTextFieldEdit> {

  var serviceController = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
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
              serviceController.showNiceCurrencyPickerEdit(context: context);
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