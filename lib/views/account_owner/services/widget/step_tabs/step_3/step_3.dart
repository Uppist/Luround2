import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_3/time_range_picker.dart';










class Step3Page extends StatefulWidget {
  Step3Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step3Page> createState() => _Step3PageState();
}

class _Step3PageState extends State<Step3Page> {

  var controller = Get.put(ServicesController());

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Day and Time availability*",
          style: GoogleFonts.poppins(
            color: AppColor.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle_rounded,
              color: AppColor.mainColor,
            ),
            SizedBox(width: 10,),
            Text(
              "West Africa Standard Time",
              style: GoogleFonts.poppins(
                color: AppColor.mainColor,
                fontSize: 15,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.3,),
          itemCount: 7,
          itemBuilder: (context, index) {
            return CheckboxListTile.adaptive(
              checkColor: AppColor.bgColor,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
              ),
              enableFeedback: true,
              activeColor: AppColor.mainColor,
              controlAffinity: ListTileControlAffinity.leading,
              value: controller.daysOfTheWeekCheckBox[index]["isChecked"],
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              onChanged: (value) {
                setState(() {
                  controller.daysOfTheWeekCheckBox[index]["isChecked"] = value;
                  controller.isCheckBoxActive.value = true;
                });
                print("$index, ${controller.daysOfTheWeekCheckBox[index]["day"]}");
              },
              tileColor: AppColor.bgColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.daysOfTheWeekCheckBox[index]["day"],
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset("assets/svg/add_icon.svg"),
                  )
                ],
              ),
              subtitle: controller.daysOfTheWeekCheckBox[index]["isChecked"] == true 
              ?TimeRangeSelector()
              :SizedBox(),
            );
          }, 
        ),
        SizedBox(height: 80),
        RebrandedReusableButton(
          textColor: controller.isCheckBoxActive.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: controller.isCheckBoxActive.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Next", 
          onPressed: controller.isCheckBoxActive.value ? 
          widget.onNext
          : () {
            print('nothing');
          },
        ),
        SizedBox(height: 20),
      ]
    );
  }
}