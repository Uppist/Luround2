import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_1/textfields/amount_textfield.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/dropdows/recurrence_dropdown.dart';










class Step2PageProgramService  extends StatefulWidget {
  const Step2PageProgramService({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2PageProgramService> createState() => _Step2PageProgramServiceState();
}

class _Step2PageProgramServiceState extends State<Step2PageProgramService > {
  
  var controller = Get.put(ProgramServiceController());
  
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
        SizedBox(height: 30.h,),
        //SizedBox(height: 20.h),
        ProgramServiceRecurrence(),
        SizedBox(height: 40.h),

        Text(
          "Maximum number of participants",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
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
                  controller.decreaseCount();
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
                    controller.count.value.toString(),
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
                  controller.increaseCount();
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
        SizedBox(height: 40.h,),

        Text(
          "Program fee",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 40.h,),
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
                textController: controller.inPersonPriceController
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h,),
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
                textController: controller.virtualPriceController
              ),
            ),
          ],
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.17),
    
    
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


  