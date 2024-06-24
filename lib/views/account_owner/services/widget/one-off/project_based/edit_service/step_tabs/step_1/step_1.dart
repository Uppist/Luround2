import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import '../../../../time_based/edit_service/step_tabs/step_1/textfields/amount_textfield_edit.dart';
import '../../../../time_based/edit_service/step_tabs/step_1/textfields/description_textfield_edit.dart';
import '../../../../time_based/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';










class Step1PageOPBEdit extends StatefulWidget {
  const Step1PageOPBEdit({super.key, required this.onNext, required this.serviceName, required this.description, required this.price});
  final String serviceName;
  final String description;
  final String price;
  final VoidCallback onNext;

  @override
  State<Step1PageOPBEdit> createState() => _Step1PageOPBEditState();
}

class _Step1PageOPBEditState extends State<Step1PageOPBEdit> {


  final controller = Get.put(ServicesController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameControllerEdit.addListener(() {
      if(mounted) {
        setState(() {
          controller.isServiceNameTappedEdit.value = controller.serviceNameControllerEdit.text.isNotEmpty;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service name",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        ReusableEditTextField(  
          onChanged: (val) {
            controller.serviceNameControllerEdit.text = val;
          },
          hintText: "Ex: CV Writing",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          initialValue: widget.serviceName,
        ),
        SizedBox(height: 40.h),
        Text(
          "Description",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        DescriptionTextFieldEdit(  
          onChanged: (val) {

            setState(() {
              if (val.length > controller.maxLengthEdit) {
                //Remove extra characters      
                controller.descriptionControllerEdit.text = val.substring(0, controller.maxLengthEdit);
                debugPrint("you have reached max length");
              } 
            });
            
          },
          hintText: "Write a brief descriptive summary of the service you provide.",
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          initialValue: widget.description
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

        SizedBox(height: 40.h),

        Text(
          "Pricing",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),

        AmountTextFieldEdit(
          onChanged: (val) {
            controller.priceControllerEdit.text = val;
          },
          hintText: "${currency(context).currencySymbol} 00.00",
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          initialValue: widget.price,

        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.21),
        
        RebrandedReusableButton(
          textColor: controller.isServiceNameTappedEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: controller.isServiceNameTappedEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Next", 
          onPressed: controller.isServiceNameTappedEdit.value ? 
          widget.onNext
          : () {
           log('nothing');
          },
        ),
        //SizedBox(height: 20.h,),


      ]
    );
  }
}