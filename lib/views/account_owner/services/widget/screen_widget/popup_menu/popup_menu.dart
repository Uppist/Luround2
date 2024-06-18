import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class PopupMenuFilterInt extends StatelessWidget {
  const PopupMenuFilterInt({super.key, this.onTap, required this.selectedValue, this.onChanged, this.items, required this.index,});
  final void Function()? onTap;
  final int selectedValue;
  final void Function(int?)? onChanged;
  final List<DropdownMenuItem<int>>? items;
  final int index;


  @override
  Widget build(BuildContext context) {
    return Container(
          height: 50.h,
          width: 145.w, //135.w
          alignment: Alignment.center,
          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.transparent, //AppColor.bgColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.transparent, //Colors.grey.withOpacity(0.3)
            )
          ),
          child: DropdownButtonFormField<int>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(        
              border: const OutlineInputBorder(
                borderSide: BorderSide.none, // Remove the border
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.bgColor), // Set the color you prefer
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.bgColor), // Set the color you prefer
              ),     
              hintText: "",
              hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),              
            ),
            icon: Icon(
              CupertinoIcons.chevron_down,
              color: AppColor.bgColor,
              size: 20.r,
            ),
            iconDisabledColor: AppColor.textGreyColor,
            iconEnabledColor: AppColor.bgColor,
            dropdownColor: AppColor.blackColor,
            borderRadius: BorderRadius.circular(10.r),
            style: GoogleFonts.inter(
              color: AppColor.bgColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500
            ),
            /*selectedItemBuilder: (context) {
              return [
                Container(
                  color: AppColor.bgColor,
                ),
              ];
            },*/
            elevation: 3,
            /*dropdownColor: AppColor.blackColor,
            underline: Divider(color: AppColor.bgColor, thickness: 1.0,),
            borderRadius: BorderRadius.circular(5.r),
            iconEnabledColor: AppColor.bgColor,
            icon: Icon(CupertinoIcons.chevron_down, color: AppColor.bgColor,)*/
            //iconSize: 16.r,
            enableFeedback: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            value: selectedValue,
            onChanged: onChanged,
            items: items
          ),
        );
      }
  

}


class PopupMenuFilterStr extends StatelessWidget {
  const PopupMenuFilterStr({super.key, this.onTap, required this.selectedValue, required this.onChanged, this.items, required this.index,});
  final void Function()? onTap;
  final RxString selectedValue;
  //final void Function(String?)? onChanged;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>>? items;
  final int index;


  @override
  Widget build(BuildContext context) {
    return Container(
          height: 50.h,
          width: 135.w,
          alignment: Alignment.center,
          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.transparent, //AppColor.bgColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.transparent, //Colors.grey.withOpacity(0.3)
            )
          ),
          child: DropdownButtonFormField<String>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(        
              border: const OutlineInputBorder(
                borderSide: BorderSide.none, // Remove the border
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.bgColor), // Set the color you prefer
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.bgColor), // Set the color you prefer
              ),     
              hintText: "",
              hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),              
            ),
            icon: Icon(
              CupertinoIcons.chevron_down,
              color: AppColor.bgColor,
              size: 24.r,
            ),
            iconDisabledColor: AppColor.textGreyColor,
            iconEnabledColor: AppColor.bgColor,
            dropdownColor: AppColor.blackColor,
            borderRadius: BorderRadius.circular(10.r),
            style: GoogleFonts.inter(
              color: AppColor.bgColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500
            ),
            elevation: 3,
            /*dropdownColor: AppColor.blackColor,
            borderRadius: BorderRadius.circular(5.r),
            iconEnabledColor: AppColor.bgColor,
            icon: Icon(CupertinoIcons.chevron_down, color: AppColor.bgColor,),*/
            //iconSize: 16.r,
            enableFeedback: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            value: selectedValue.value,
            onChanged: onChanged,
            items: items
          ),
        );
      }
}



