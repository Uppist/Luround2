import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/edit_service/step_tabs/step_1/description_textfield_edit.dart';
import 'package:luround/views/account_owner/services/widget/edit_service/step_tabs/step_1/edit_textfield.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_1/amount_textfield.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_1/description_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/reusable_custom_textfield.dart';









class Step1PageEdit extends GetView<ServicesController> {
  Step1PageEdit({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service name*",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10.h),
          ReusableEditTextField(  
            onChanged: (val) {},
            hintText: "Service name",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            initialValue: "",
          ),
          SizedBox(height: 30.h),
          Text(
            "Description (optional)*",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10.h),
          DescriptionTextFieldEdit(  
            onChanged: (val) {
              // Check if character count exceeds the maximum
              if (val.length > controller.maxLengthEdit) {
                // Remove extra characters        
                controller.descriptionControllerEdit.text = val.substring(0, controller.maxLengthEdit);
                debugPrint("you have reached max length");
              } 
              //setState(() {}); // Update the UI
            },
            hintText: "Write a brief descriptive summary of the service you provide.",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            initialValue: "",
          ),
          SizedBox(height: 10.h,),
          //max length for message textfield
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${controller.descriptionControllerEdit.text.length}/${controller.maxLengthEdit}",
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add links (optional)*",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              InkWell(
                onTap: () {           
                  controller.toggleLinkEdit.value = true;
                  controller.isTextGoneEdit.value = true;
                },
                child: SvgPicture.asset("assets/svg/add_icon.svg"),
              )
            ],
          ),
          SizedBox(height: 10.h),
          //textfield
          controller.toggleLinkEdit.value ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ReusableTextField(  
                  onChanged: (val) {},
                  hintText: "e.g, https://www.example.com",
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  textController: controller.addLinksControllerEdit
                ),
              ),
              IconButton(
                onPressed: () {               
                  controller.toggleLinkEdit.value = false;
                  controller.isTextGoneEdit.value = false;              
                }, 
                icon: Icon(CupertinoIcons.xmark, color: AppColor.blackColor,),
              )
            ],
          ) : SizedBox(),
          SizedBox(height: 20.h,),

          controller.isTextGoneEdit.value ? SizedBox()
          :Text(
            "Add links to contents that relates to this service",
            style: GoogleFonts.inter(
              color: AppColor.textGreyColor, 
              fontSize: 14.sp
            ),
          ),
          
          controller.isTextGoneEdit.value ? SizedBox(): SizedBox(height: 4.h,),
          
          controller.isTextGoneEdit.value ? SizedBox() : Divider(color: AppColor.textGreyColor, thickness: 1,),
      
          SizedBox(height: 20.h,),
          Text(
            "Service charge per session*",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "In-person",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor, 
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(width: 20.w,),
              Expanded(
                child: AmountTextField(  
                  onChanged: (val) {},
                  hintText: "00.00",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  textController: controller.inPersonControllerEdit
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Virtual",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor, 
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(width: 45.w,),
              Expanded(
                child: AmountTextField(  
                  onChanged: (val) {},
                  hintText: "00.00",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  textController: controller.virtualControllerEdit
                ),
              ),
            ],
          ),
          SizedBox(height: 80.h,),
          RebrandedReusableButton(
            textColor: controller.ispriceButtonEnabledEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
            color: controller.ispriceButtonEnabledEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
            text: "Next", 
            onPressed: controller.ispriceButtonEnabledEdit.value ? 
            onNext
            : () {
              print('nothing');
            },
          ),
          SizedBox(height: 20.h,),


        ]
      )
    );
  }
}