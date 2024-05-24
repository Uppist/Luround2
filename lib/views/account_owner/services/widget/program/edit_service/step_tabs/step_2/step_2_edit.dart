import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/textfields/amount_textfield_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/dropdows/recurrence_dropdown_edit.dart';










class Step2PageProgramServiceEdit  extends StatefulWidget {
  const Step2PageProgramServiceEdit({super.key, required this.onNext, required this.service_charge_in_person, required this.service_charge_virtual});
  final VoidCallback onNext;
  final String service_charge_in_person;
  final String service_charge_virtual;

  @override
  State<Step2PageProgramServiceEdit> createState() => _Step2PageProgramServiceEditState();
}

class _Step2PageProgramServiceEditState extends State<Step2PageProgramServiceEdit> {
  
  final controller = Get.put(ProgramServiceController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Program recurrence",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h,),
        //SizedBox(height: 20.h),
        ProgramServiceRecurrenceEdit(),
        SizedBox(height: 30.h),

        Text(
          "Maximum number of participants",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
          alignment: Alignment.center,
          height: 45.h,
          width: 130.w, //125
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColor.textGreyColor,
              width: 1.0, //2
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed:() {
                  controller.decreaseCountEdit();
                }, 
                icon: Icon(
                  CupertinoIcons.minus_circle,
                  color: AppColor.textGreyColor,
                  size: 24.r,
                )
              ),
              //SizedBox(width: 5.w,),
              Obx(
                () {
                  return Text(
                    controller.countEdit.value.toString(),
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400
                    ),
                  );
                }
              ),
              //SizedBox(width: 5.w,),
              IconButton(
                onPressed:() {
                  controller.increaseCountEdit();
                }, 
                icon: Icon(
                  CupertinoIcons.add_circled,
                  color: AppColor.textGreyColor,
                  size: 24.r,
                )
              )
            ],
          )
        ),
        SizedBox(height: 30.h,),

        Text(
          "Program fee",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
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
              child: AmountTextFieldEdit(
                onChanged: (val) {
                  //setState(() {
                    controller.inPersonPriceControllerEdit.text = val;
                  //});
                },
                hintText: "00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialValue: widget.service_charge_in_person,

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
              child: AmountTextFieldEdit(  
                onChanged: (val) {
                  //setState(() {
                    controller.virtualPriceControllerEdit.text = val;
                  //});
                },
                hintText: "00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                initialValue: widget.service_charge_virtual,
              ),
            ),
          ],
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
    
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext,
        ),
    
    
      ]
    );
  }
}


  