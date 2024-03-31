import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/dropdows/recurrence_dropdown.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/dropdows/timeline_dropdown.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_1/textfields/amount_textfield.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_1/textfields/description_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/reusable_custom_textfield.dart';









class Step1PageProgramService extends StatefulWidget {
  Step1PageProgramService({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step1PageProgramService> createState() => _Step1PageProgramServiceState();
}

class _Step1PageProgramServiceState extends State<Step1PageProgramService> {


  var controller = Get.put(ProgramServiceController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameController.addListener(() {
      setState(() {
        controller.isServiceNameTapped.value = controller.serviceNameController.text.isNotEmpty;
      });
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
        ReusableTextField(  
          onChanged: (val) {},
          hintText: "Service name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textController: controller.serviceNameController
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
        DescriptionTextField(  
          onChanged: (val) {
            //controller.handleTextChanged(val);
            // Check if character count exceeds the maximum
            setState(() {
              if (val.length > controller.maxLength) {
                //Remove extra characters      
                controller.descriptionController.text = val.substring(0, controller.maxLength);
                debugPrint("you have reached max length");
              } 
            });
            
          },
          hintText: "Write a brief descriptive summary of the service you provide.",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textController: controller.descriptionController,
        ),
        SizedBox(height: 10.h,),
        //max length for message textfield
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${controller.descriptionController.text.length}/${controller.maxLength}",
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        /*SizedBox(height: 20.h),
        Row(
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
                  controller.toggleLink.value = true;
                  controller.isTextGone.value = true;
                });
              },
              child: SvgPicture.asset("assets/svg/add_icon.svg"),
            )
          ],
        ),
        SizedBox(height: 10.h),
        //textfield
        controller.toggleLink.value ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ReusableTextField(  
                onChanged: (val) {},
                hintText: "e.g, https://www.example.com",
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                textController: controller.addLinksController
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  controller.toggleLink.value = false;
                  controller.isTextGone.value = false;
                });
              }, 
              icon: Icon(CupertinoIcons.xmark, color: AppColor.blackColor,),
            )
          ],
        ) : SizedBox(),
        SizedBox(height: 20.h,),

        controller.isTextGone.value ? SizedBox()
        :Text(
          "Add links to contents that relates to this service",
          style: GoogleFonts.inter(
            color: AppColor.textGreyColor, 
            fontSize: 14.sp
          ),
        ),
        
        controller.isTextGone.value ? SizedBox(): SizedBox(height: 4.h,),
        
        controller.isTextGone.value ? SizedBox() : Divider(color: AppColor.textGreyColor, thickness: 1,),*/
        Text(
          "Service timeline",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        //SizedBox(height: 20.h),
        ProgramServiceTimeline(),


        SizedBox(height: 30.h,),
        Text(
          "Service recurrence",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h,),
        //SizedBox(height: 20.h),
        ProgramServiceRecurrence(),


        SizedBox(height: 150.h,),
        RebrandedReusableButton(
          textColor: controller.isServiceNameTapped.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: controller.isServiceNameTapped.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Next", 
          onPressed: controller.isServiceNameTapped.value ? 
          widget.onNext
          : () {
            print('nothing');
          },
        ),
        SizedBox(height: 20.h,),


      ]
    );
  }
}