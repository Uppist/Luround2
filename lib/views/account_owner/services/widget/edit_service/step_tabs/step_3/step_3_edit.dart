import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/edit_service/step_tabs/step_3/time_range_picker_edit.dart';







class Step3PageEdit extends StatefulWidget{
  Step3PageEdit({
    super.key, 
    required this.serviceId, 
    required this.service_name, 
    required this.description, 
    required this.links, 
    required this.service_charge_in_person, 
    required this.service_charge_virtual, 
    required this.duration, 
    required this.time, 
    required this.date, 
    required this.available_days
  });

  final String serviceId;
  final String service_name;
  final String description;
  final List<dynamic> links;
  final String service_charge_in_person;
  final String service_charge_virtual;
  final String duration;
  final String time;
  final String date;
  final String available_days;


  @override
  State<Step3PageEdit> createState() => _Step3PageEditState();
}

class _Step3PageEditState extends State<Step3PageEdit> {
  var mainController = Get.put(ServicesController());
  var servicesService = Get.put(AccOwnerServicePageService());

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Day and Time availability*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle_rounded,
              color: AppColor.mainColor,
            ),
            SizedBox(width: 10.w,),
            Text(
              "West Africa Standard Time",
              style: GoogleFonts.inter(
                color: AppColor.mainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.3,),
          itemCount: mainController.daysOfTheWeekCheckBoxEdit.length,
          itemBuilder: (context, index) {
            return Builder(
              builder: (context) {
                return CheckboxListTile.adaptive(
                  checkColor: AppColor.bgColor,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)
                  ),
                  enableFeedback: true,
                  activeColor: AppColor.mainColor,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"],
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w,),
                  onChanged: (value) {    
                    setState(() {
                      mainController.isCheckBoxActiveEdit.value = true;
                      mainController.toggleCheckboxEdit(index, value);
                      print("selectedDaysEdit: ${mainController.selectedDaysEdit}");
                    
                    }); 

                  },
                  tileColor: AppColor.bgColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainController.daysOfTheWeekCheckBoxEdit[index]["day"],
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"] = !mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"];
                          //to activate the done button
                          mainController.isCheckBoxActiveEdit.value = true;                  
                        },
                        child: SvgPicture.asset("assets/svg/add_icon.svg"),
                      )
                    ],
                  ),
                  subtitle: mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"] 
                  ?EditTimeRangeSelector(index: index)           
                  : SizedBox(),
                );
              }
            );
          }, 
        ),
        SizedBox(height: 90.h),
        RebrandedReusableButton(
          textColor: mainController.isCheckBoxActiveEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: mainController.isCheckBoxActiveEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Done", 
          onPressed: mainController.isCheckBoxActiveEdit.value ? 
          //widget.onNext
          () {
            servicesService.updateUserService(
              context: context,
              //service_type: "Virtual", //In-Person
              serviceId: widget.serviceId,
              service_name: mainController.serviceNameControllerEdit.text.isEmpty ? widget.service_name : mainController.serviceNameControllerEdit.text, 
              description: mainController.descriptionControllerEdit.text.isEmpty ? widget.description : mainController.descriptionControllerEdit.text, 
              links: mainController.addLinksControllerEdit.text.isEmpty ? widget.links : [mainController.addLinksControllerEdit.text], 
              service_charge_in_person: mainController.inPersonControllerEdit.text.isEmpty ? widget.service_charge_in_person : mainController.inPersonControllerEdit.text, 
              service_charge_virtual: mainController.virtualControllerEdit.text.isEmpty ? widget.service_charge_virtual : mainController.virtualControllerEdit.text, 
              duration: mainController.formatDurationEdit().isEmpty ? widget.duration  : mainController.formatDurationEdit(), 
              time: mainController.startTimeValueEdit.isEmpty ? widget.time : "${mainController.startTimeValueEdit} - ${mainController.stopTimeValueEdit}",
              date: mainController.selectDateRangeEdit.isEmpty ? widget.date : mainController.selectDateRangeEdit,             
              available_days: mainController.availableDaysEdit(),
            ).whenComplete(() {
              Get.offUntil(
                GetPageRoute(
                  curve: Curves.bounceIn,
                  page: () => MainPage(),
                ), 
                (route) => true
              );
            });
          }
          : () {
            print('nothing');
          },
        ),
        SizedBox(height: 5.h),
      ]
    );
  }
}