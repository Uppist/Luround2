import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_1/amount_textfield.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_1/description_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/reusable_custom_textfield.dart';









class Step1Page extends StatefulWidget {
  Step1Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step1Page> createState() => _Step1PageState();
}

class _Step1PageState extends State<Step1Page> {
  var controller = Get.put(ServicesController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameController.addListener(() {
      setState(() {
        controller.ispriceButtonEnabled.value = controller.serviceNameController.text.isNotEmpty;
      });
    });
    super.initState();
  }

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
          ReusableTextField(  
            onChanged: (val) {},
            hintText: "Service name",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            textController: controller.serviceNameController
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
          DescriptionTextField(  
            onChanged: (val) {
              // Check if character count exceeds the maximum
              if (val.length > controller.maxLength) {
                // Remove extra characters        
                controller.descriptionController.text = val.substring(0, controller.maxLength);
                debugPrint("you have reached max length");
              } 
              setState(() {}); // Update the UI
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
          
          controller.isTextGone.value ? SizedBox() : Divider(color: AppColor.textGreyColor, thickness: 1,),
      
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
                  textController: controller.inPersonController
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
                  textController: controller.virtualController
                ),
              ),
            ],
          ),
          SizedBox(height: 80.h,),
          RebrandedReusableButton(
            textColor: controller.ispriceButtonEnabled.value ? AppColor.bgColor : AppColor.darkGreyColor,
            color: controller.ispriceButtonEnabled.value ? AppColor.mainColor : AppColor.lightPurple, 
            text: "Next", 
            onPressed: controller.ispriceButtonEnabled.value ? 
            widget.onNext
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