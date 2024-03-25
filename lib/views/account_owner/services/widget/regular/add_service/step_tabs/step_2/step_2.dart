import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_2/new/service_model.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_2/new/timeline_dropdown.dart';









class Step2Page extends StatefulWidget {
  Step2Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  
  var controller = Get.put(ServicesController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service model*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        
        //choose service model radio widgets
        RegularServiceModelSelector(),
    
        Obx(
          () {
            return controller.selectServiceModel.value == "Retainer"?
            Column(
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
                SizedBox(height: 20.h),
                RegularServiceTimeline(),
              ],
            )
            :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 20.h,),
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
                    controller.showDurationPickerDialog(context: context);         
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
                              "${controller.duration.value}".substring(0, 7),
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
              ],
            );
          }
        ),
       
        //SizedBox(height: 20.h,),
    
        //schedule radio section
        //ScheduleRadioWidget(),
    
        
        
        SizedBox(height: 280.h,),
    
        Obx(
          () {
            return RebrandedReusableButton(
              textColor: controller.selectServiceModel.value.isNotEmpty ? AppColor.bgColor : AppColor.darkGreyColor,
              color: controller.selectServiceModel.value.isNotEmpty ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Next", 
              onPressed: controller.selectServiceModel.value.isNotEmpty ? 
              widget.onNext
              : () {
                print('nothing');
              },
            );
          }
        ),
        SizedBox(height: 10.h,),
    
    
      ]
    );
  }
}


  