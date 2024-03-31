import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/package/add_service/step_tabs/step_3/new/date_range_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/package/add_service/step_tabs/step_3/new/start_date_box.dart';
import 'package:luround/views/account_owner/services/widget/package/add_service/step_tabs/step_3/new/start_time_box.dart';
import 'package:luround/views/account_owner/services/widget/package/add_service/step_tabs/step_3/new/stop_date_box.dart';
import 'package:luround/views/account_owner/services/widget/package/add_service/step_tabs/step_3/new/stop_time_box.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_1/textfields/amount_textfield.dart';











class Step3PagePackageService extends StatefulWidget{
  Step3PagePackageService({super.key,});

  @override
  State<Step3PagePackageService> createState() => _Step3PagePackageServiceState();
}

class _Step3PagePackageServiceState extends State<Step3PagePackageService> {

  var mainController = Get.put(PackageServiceController());
  var servicesService = Get.put(AccOwnerServicePageService());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        Text(
          "Date and Time",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        //r1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StartDateBoxPackage(),
            StartTimeBoxPackage()
          ],
        ),
        SizedBox(height: 30.h,),
        //r2
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StopDateBoxPackage(),
            StopTimeBoxPackage()
          ],
        ),

        SizedBox(height: 30.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock,
                  color: AppColor.blackColor,
                  size: 22.r,
                ),
                SizedBox(width: 5.w,),
                Text(
                  "Duration",
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            Obx(
              () {
                return Text(
                  mainController.calcDuration.value,
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400
                  ),
                );
              }
            ),
          ]
        ),

        SizedBox(height: 30.h,),
        Text(
          "Service fee",
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
                textController: mainController.inPersonController
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
                textController: mainController.virtualController
              ),
            ),
          ],
        ),
        SizedBox(height: 100.h),

        //button
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Done", 
          onPressed: () {}
        ),

        //button
        /*Obx(
          () {
            return servicesService.isServiceCRLoading.value ? Loader() : RebrandedReusableButton(
              textColor: mainController.isCheckBoxActive.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: mainController.isCheckBoxActive.value ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: mainController.isCheckBoxActive.value ? 
              //widget.onNext
              () {
                    
                mainController.getTimeIntervals(
                  earliestTime: mainController.findEarliestTime(),
                  latestTime: mainController.findLatestTime(),
                  interval: mainController.duration.value
                )
                .whenComplete(() {
                  servicesService.createUserService(
                    available_time_list: mainController.availableTime,
                    context: context,
                    //service_type: "Virtual", //In-Person
                    service_name: mainController.serviceNameController.text, 
                    description: mainController.descriptionController.text, 
                    links: [mainController.addLinksController.text], 
                    service_charge_in_person: mainController.inPersonController.text, 
                    service_charge_virtual: mainController.virtualController.text, 
                    duration: mainController.formatDuration(), 
                    time: "${mainController.findEarliestTime()} - ${mainController.findLatestTime()}",
                    date: mainController.selectServiceModel.value,  //selectServiceModel, selectDurationRadio   //regular service model           
                    available_days: mainController.availableDays(),
                  ).whenComplete(() {
                    //1
                    setState(() {
                      mainController.curentStep = mainController.curentStep - 2;
                    });
                    //2
                    mainController.serviceNameController.clear();
                    mainController.descriptionController.clear();
                    mainController.addLinksController.clear();
                    mainController.inPersonController.clear();
                    mainController.virtualController.clear();
                    //3
                    Get.offUntil(
                      GetPageRoute(
                        curve: Curves.bounceIn,
                        page: () => const MainPage(),
                      ), 
                      (route) => true
                    );
                  });       
                });
                        
              }
              : () {
                print('nothing');
              },
                
            );
          }
        ),*/

        SizedBox(height: 5.h),
      ]
    );
    
  }
}