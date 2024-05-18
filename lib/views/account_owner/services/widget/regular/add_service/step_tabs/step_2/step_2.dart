import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_2/one-off_widgets/textcontroller_set.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_2/one-off_widgets/textfield.dart';









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
          "Pricing",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        
        //choose service model radio widgets
        /*RegularServiceModelSelector(),
    
        Obx(
          () {
            return controller.selectServiceModel.value == "RETAINER"?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service timeline",
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
                  "Service duration",
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
        ),*/

        //2           
        //growable list that displays textfields that was added
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), //const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controller.controllers.length, //certified (working)
          //padding: EdgeInsets.symmetric(vertical: 10.h),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemBuilder: (context, index) {  //certified (working)
                  
            ServiceControllerSett controllerSet = controller.controllers[index];
        
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildAdditionalTextField(
                  '', 
                  controllerSet.durationController, 
                  TextInputType.number, 
                  Icon(CupertinoIcons.clock, size: 22.r, color: AppColor.textGreyColor,), 
                  100.w
                ),
                buildAdditionalTextField(
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
                  100.w
                ),
                buildAdditionalTextField(
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
                  100.w
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      //profileController.textFields.removeAt(index);
                      controller.controllers.removeAt(index);
                      print("controller_list: ${controller.controllers}");
                      print("controller_list_length: ${controller.controllers.length}");
                    });
                  },
                  child: Icon(CupertinoIcons.delete, size: 24.r, color: AppColor.textGreyColor,),
                )
                
              ],
            );
                        
          },
        
        ),
            
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
    
        InkWell(
          onTap: () {           
            setState(() {
              ServiceControllerSett controllerSet = ServiceControllerSett();
              //controller.textFields.add(buildTextField(controllerSet));
              controller.controllers.add(controllerSet);
              // Access your controllers through the list of ControllerSet instances
              for (ServiceControllerSett controllerSet in controller.controllers) {
                print("duration: ${controllerSet.durationController.text}");
                print("virtual price: ${controllerSet.virtualPriceController.text}");
                print("in-person price: ${controllerSet.inpersonPriceController.text}");
              }
              controller.selectServiceModel.value = 'not empty';
            });    
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.add_circled, 
                size: 24.r, 
                color: AppColor.textGreyColor,
              ),
              SizedBox(width: 10.w,),
              Text(
                'Add time slot',
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                )
              ),
              
            ],
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add meeting links for virtual bookings",
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
          "Add meeting links for virtual bookings",
          style: GoogleFonts.inter(
            color: AppColor.textGreyColor, 
            fontSize: 14.sp
          ),
        ),
        
        controller.isTextGone.value ? SizedBox(): SizedBox(height: 4.h,),
        
        controller.isTextGone.value ? SizedBox() : Divider(color: AppColor.textGreyColor, thickness: 1,),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.20),
    
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

                //controller.textFields.clear();//remove(field);
                controller.controllers.clear();

                ////////////
                /*profileService.updateCertificateData(
                  context: context,
                  controllerSets: profileController.controllers
                ).whenComplete(() {
                  profileController.textFields.clear();//remove(field);
                  profileController.controllers.clear();
                  print("textfield_list: ${profileController.textFields}");
                  print("controller_list_length: ${profileController.controllers.length}");      
                });*/
              },
            );
          }
        ),
        //SizedBox(height: 10.h,),
    
    
      ]
    );
  }
}



  //subfields for duration, virtual and in-person price
  Widget buildAdditionalTextField(String hintText, TextEditingController controller, TextInputType inputType, Widget prefixIcon, double width) {
    return OneoffTextField(
      onFieldSubmitted: (p0) {},
      onFocusChanged: (p0) {},
      onChanged: (val) {},
      textController: controller,
      hintText: hintText,  
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      prefixIcon: prefixIcon,
      width: width,
    );
  }
  