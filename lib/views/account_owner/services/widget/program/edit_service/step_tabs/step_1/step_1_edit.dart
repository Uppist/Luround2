import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/textfields/description_textfield_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/dropdows/recurrence_dropdown_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/dropdows/timeline_dropdown_edit.dart';










class Step1PageProgramServiceEdit extends StatefulWidget {
  const Step1PageProgramServiceEdit({super.key, required this.onNext, required this.serviceId, required this.service_name, required this.description, required this.links, required this.service_charge_in_person, required this.service_charge_virtual,});
  final VoidCallback onNext;
  final String serviceId;
  final String service_name;
  final String description;
  final List<dynamic> links;
  final String service_charge_in_person;
  final String service_charge_virtual;

  @override
  State<Step1PageProgramServiceEdit> createState() => _Step1PageProgramServiceEditState();
}

class _Step1PageProgramServiceEditState extends State<Step1PageProgramServiceEdit> {
  
  var controller = Get.put(ProgramServiceController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameControllerEdit.addListener(() {
      /*setState(() {
        controller.i.value = controller.serviceNameControllerEdit.text.isNotEmpty;
      });*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onChanged: (val) {
            setState(() {
              controller.serviceNameControllerEdit.text = val;
            });
          },
          hintText: "Service name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          initialValue: widget.service_name,
        ),
        SizedBox(height: 30.h),
        Text(
          "Description (optional)",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.h),
        DescriptionTextFieldEdit(  
          onChanged: (val) {
            setState(() {
              // Check if character count exceeds the maximum
              if (val.length > controller.maxLengthEdit) {
                // Remove extra characters        
                controller.descriptionControllerEdit.text = val.substring(0, controller.maxLengthEdit);
                debugPrint("you have reached max length");
              } 
              controller.descriptionControllerEdit.text = val;
            });
          },
          hintText: "Write a brief descriptive summary of the service you provide.",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          initialValue: widget.description,
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

        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add links (optional)",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
              ),
            ),
            InkWell(
              onTap: () {  
                setState(() {
                  controller.toggleLinkEdit.value = true;
                  controller.isTextGoneEdit.value = true;
                });         
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
              child: DescriptionTextFieldEdit(  
                onChanged: (val) {
                  setState(() {
                    controller.addLinksControllerEdit.text = val;
                  });
                },
                hintText: "e.g, https://www.example.com",
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                initialValue: widget.links[0],
              ),
            ),
            IconButton(
              onPressed: () { 
                setState(() {
                  controller.toggleLinkEdit.value = false;
                  controller.isTextGoneEdit.value = false; 
                });              
                              
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
    
        SizedBox(height: 20.h,),*/

        Text(
          "Service timeline",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        //SizedBox(height: 20.h),
        ProgramServiceTimelineEdit(),
        
        SizedBox(height: 20.h,),
        Text(
          "Service recurrence",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        //SizedBox(height: 20.h),
        ProgramServiceRecurrenceEdit(),


        SizedBox(height: 150.h,),
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext
        ),
        SizedBox(height: 20.h,),

      ]
    );
  }
}