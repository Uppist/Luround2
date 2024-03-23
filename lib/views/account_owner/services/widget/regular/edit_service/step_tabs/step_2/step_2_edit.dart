import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/regular/edit_service/step_tabs/step_2/radio_section_edit.dart';
import 'package:luround/views/account_owner/services/widget/regular/edit_service/step_tabs/step_2/service_model_edit.dart';









class Step2PageEdit extends GetView<ServicesController> {
  Step2PageEdit({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service duration*",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 30.h),
          InkWell(
            onTap: () async{
              controller.showDurationPickerDialogEdit(context: context);         
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              alignment: Alignment.centerLeft,
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.textGreyColor,
                  width: 1.0, //2
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () {
                      return Text(
                        "${controller.durationEdit.value}".substring(0, 7),
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.textGreyColor,
                            fontSize: 16.sp,
                            //fontWeight: FontWeight.w500
                          )
                        )
                      );
                    }
                  ),
                  Icon(
                    CupertinoIcons.time,
                    color: AppColor.textGreyColor,
                  ),
                ],
              ),
            )
          ),
          SizedBox(height: 30.h,),
          Text(
            "This service can be scheduled...",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),

          SizedBox(height: 20.h,),

          //schedule radio section
          //EditScheduleRadioWidget(),
          EditRegularServiceModelSelector(),
          
          SizedBox(height: 280.h,),

          Obx(
            () {
              return RebrandedReusableButton(
                textColor: controller.ispriceButtonEnabledEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
                color: controller.ispriceButtonEnabledEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
                text: "Next", 
                onPressed: controller.ispriceButtonEnabledEdit.value ? 
                onNext
                : () {
                  print('nothing');
                },
              );
            }
          ),
          SizedBox(height: 10.h,),


        ]
      )
    );
  }
}


  