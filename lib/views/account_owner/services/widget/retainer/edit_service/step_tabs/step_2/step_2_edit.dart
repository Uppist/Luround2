import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/retainer/retainer_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/ui/textcontroller_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_1/new/custom_checkbox_listtile.dart';
import 'package:luround/views/account_owner/services/widget/retainer/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';










class Step2PagePackageServiceEdit  extends StatefulWidget {
  const Step2PagePackageServiceEdit({super.key, required this.virtual_meeting_link, required this.onNext});
  final VoidCallback onNext;
  final String virtual_meeting_link;

  @override
  State<Step2PagePackageServiceEdit> createState() => _Step2PagePackageServiceEditState();
}

class _Step2PagePackageServiceEditState extends State<Step2PagePackageServiceEdit> {
  
  final controller = Get.put(PackageServiceController());
  
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pricing",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(width: 10.w,),
            ),
            SizedBox(width: 60.w,),
            Expanded(
              child: Text(
                "Virtual (${currency(context).currencySymbol})",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(
                "In-person (${currency(context).currencySymbol})",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        //available days list
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemCount: controller.priceSlotEdit.length,
          itemBuilder: (context, index) {
    
            return Obx(
              () {
      
                ServiceControllerSett controllerSet = controller.controllersEdit[index];
                //
                String time = controller.priceSlotEdit[index]['time'];
                //
                bool isSelected = controller.priceSlotEdit[index]['isSelected'];
                //
                String virtualPrice = controller.getTimeSelectionEdit(time)?.virtual_pricing ?? "";
                //
                String inpersonPrice = controller.getTimeSelectionEdit(time)?.in_person_pricing ?? "";
                
                return CustomCheckBoxListTile(
                  checkbox: Checkbox.adaptive(
                    checkColor: AppColor.bgColor,
                    activeColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r)
                    ),
                    value: isSelected,
                    onChanged: (value) {   
                      // Toggle checkbox and update selection in the list
                      setState(() {
                        
                        controller.isCheckBoxActiveForPricingEdit.value = true;
                        isSelected = value!;
                        //
                        controller.toggleTimeSlotSelectionEdit(
                          index, 
                          time, 
                          value, 
                          virtualPrice, 
                          inpersonPrice,
                        );
                        //checks for custom selection for mins
                        if(time == "Custom") {
                          controller.isCustomTextFieldActivatedEdit.value = !controller.isCustomTextFieldActivatedEdit.value;
                        } 

                      });
                    },
                  ),              
                  
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          time,
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),

                      SizedBox(width: 5.w,),

                      //Virtual Price TextField
                      Expanded(
                        child: UtilsTextField4(
                          onChanged: (val) {
                            controllerSet.virtualPriceController.text = val;
                            controller.updateVirtualPriceEdit(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlotEdit}");
                              log(controllerSet.virtualPriceController.text);
                            });
                          },
                          onFieldSubmitted: (val) {
                            
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textController: controllerSet.virtualPriceController,
                          //initialValue: virtualPrice,
                          hintText: '0.00',
                        ),
                      ),

                      SizedBox(width: 10.w,),

                      //Inperson Price TextField
                      Expanded(
                        child: UtilsTextField4(
                          onChanged: (val) {
                            controllerSet.inpersonPriceController.text = val;
                            controller.updateInpersonPriceEdit(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlotEdit}");
                              log(controllerSet.inpersonPriceController.text);
                            });
                          },
                          onFieldSubmitted: (val) {
                            
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textController: controllerSet.inpersonPriceController,
                          //initialValue: inpersonPrice,
                          hintText: '0.00',
                        ),
                      ),
                
                    ],
                  ),
                  subtitle: controller.isCheckBoxActiveForPricingEdit.value ? const SizedBox() : const SizedBox()
                );
              }
            );
            
          }, 
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
        //SizedBox(height: MediaQuery.of(context).size.height * 0.42),

        Text(
          "Add meeting link for virtual bookings",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        //textfield
        ReusableEditTextField(  
          onChanged: (val) {
            controller.addLinksControllerEdit.text = val;
          },
          hintText: "Meeting link",
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          initialValue: widget.virtual_meeting_link,
          //textController: controller.addLinksControllerEdit
        ),

        
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
      
        Obx(
          () {
            return RebrandedReusableButton(
              textColor: controller.isCheckBoxActiveForPricingEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: controller.isCheckBoxActiveForPricingEdit.value ? AppColor.mainColor : AppColor.lightPurple,
              text: "Next", 
              onPressed: controller.isCheckBoxActiveForPricingEdit.value ? 
              widget.onNext
              : () {
                print('nothing');
                //controller.controllers.clear();
              },
            );
          }
        ),
      ]
    );
        
        
    //SizedBox(height: 10.h,),

  }
}


  