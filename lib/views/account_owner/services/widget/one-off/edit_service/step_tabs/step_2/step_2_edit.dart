import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_2/one-off_widgets/textcontroller_set.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_2/step_2.dart';








class Step2PageEdit extends StatefulWidget {
  const Step2PageEdit({super.key, required this.onNext});
  final VoidCallback onNext;

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
        ListView.separated(
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
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.23),

        InkWell(
          onTap: () {           
            setState(() {
              ServiceControllerSett controllerSet = ServiceControllerSett();
              //controller.textFields.add(buildTextField(controllerSet));
              controller.controllersEdit.add(controllerSet);
              print("controller_list: ${controller.controllersEdit}");
              print("controller_list_length: ${controller.controllersEdit.length}");
              // Access your controllers through the list of ControllerSet instances
              for (ServiceControllerSett controllerSet in controller.controllersEdit) {
                print("duration: ${controllerSet.durationController.text}");
                print("virtual price: ${controllerSet.virtualPriceController.text}");
                print("in-person price: ${controllerSet.inpersonPriceController.text}");
              }

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
        ReusableTextField(  
          onChanged: (val) {},
          hintText: "Meeting link",
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.next,
          textController: controller.addLinksControllerEdit
        ),

        
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
    
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor,
          text: "Next", 
          onPressed: //controller.selectServiceModel.value.isNotEmpty ? 
          widget.onNext,
          /*: () {
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
          },*/
        )
    
    
      ]
    );
  }
}


  