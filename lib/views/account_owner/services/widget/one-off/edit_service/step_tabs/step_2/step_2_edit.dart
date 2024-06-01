import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/ui/textcontroller_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/services/widget/one-off/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';
import '../../../../program/add_service/step_tabs/step_1/new/custom_checkbox_listtile.dart';








class Step2PageEdit extends StatefulWidget {
  const Step2PageEdit({super.key, required this.onNext, required this.virtual_meeting_link});
  final VoidCallback onNext;
  final String virtual_meeting_link;

  @override
  State<Step2PageEdit> createState() => _Step2PageEditState();
}

class _Step2PageEditState extends State<Step2PageEdit> {

  final controller = Get.put(ServicesController());

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
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(
                "Virtual",
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
                "In-person",
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

        //2           
        //growable list that displays textfields that was added
        /*ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), //const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controller.controllersEdit.length, //certified (working)
          //padding: EdgeInsets.symmetric(vertical: 10.h),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemBuilder: (context, index) {  //certified (working)
                  
            ServiceControllerSett controllerSet = controller.controllersEdit[index];
        
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: buildAdditionalTextField(
                    '', 
                    controllerSet.durationController, 
                    TextInputType.number, 
                    Icon(CupertinoIcons.clock, size: 22.r, color: AppColor.textGreyColor,), 
                    0.w,
                    Text(
                      "Min.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 10.sp, //12.sp
                        fontWeight: FontWeight.w400
                      ),
                      overflow: TextOverflow.ellipsis,
                    ), 
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: buildAdditionalTextField(
                    '', 
                    controllerSet.virtualPriceController, 
                    TextInputType.number, 
                    Text(
                      currency(context).currencySymbol,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    //SvgPicture.asset("assets/svg/naira.svg"),
                    150.w
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: buildAdditionalTextField(
                    '', 
                    controllerSet.inpersonPriceController, 
                    TextInputType.number, 
                    Text(
                      currency(context).currencySymbol,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    //SvgPicture.asset("assets/svg/naira.svg"),
                    150.w
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    setState(() {
                      //profileController.textFields.removeAt(index);
                      controller.controllersEdit.removeAt(index);
                      print("controller_list: ${controller.controllersEdit}");
                      print("controller_list_length: ${controller.controllersEdit.length}");
                    });
                  },
                  child: Icon(CupertinoIcons.delete, size: 24.r, color: AppColor.textGreyColor,),
                )
                
              ],
            );           
          }    
        ),*/

        
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
                //
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
                          },
                          onFieldSubmitted: (val) {
                            controller.updateVirtualPriceEdit(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlotEdit}");
                              log(controllerSet.virtualPriceController.text);
                            });
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textController: controllerSet.virtualPriceController,
                          //initialValue: virtualPrice,
                          hintText: '${currency(context).currencySymbol} 0.00',
                        ),
                      ),

                      SizedBox(width: 10.w,),

                      //Inperson Price TextField
                      Expanded(
                        child: UtilsTextField4(
                          onChanged: (val) {
                            controllerSet.inpersonPriceController.text = val;
                          },
                          onFieldSubmitted: (val) {
                            controller.updateInpersonPriceEdit(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlotEdit}");
                              log(controllerSet.inpersonPriceController.text);
                            });
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textController: controllerSet.inpersonPriceController,
                          //initialValue: inpersonPrice,
                          hintText: '${currency(context).currencySymbol} 0.00',
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


        SizedBox(height: MediaQuery.of(context).size.height * 0.05),


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
          onChanged: (val) {},
          hintText: "Meeting link",
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.next,
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
  }
}


  