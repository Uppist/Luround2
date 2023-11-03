import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:time_range_picker/time_range_picker.dart';










class TimeRangeSelector extends StatefulWidget {
  TimeRangeSelector({super.key, required this.index});
  final int index;

  @override
  State<TimeRangeSelector> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  
  var controller = Get.put(ServicesController());

  //func that opens this awesome time range picker package
  Future<void> openTimeRangePicker({required BuildContext context, required int index}) async{
    TimeRange result = await showTimeRangePicker(
      context: context,
      //start: TimeOfDay.now()
      paintingStyle: PaintingStyle.stroke,
      use24HourFormat: true,
      //strokeColor: AppColor.mainColor,
      //handlerColor: AppColor.mainColor,
      handlerRadius: 12,
      //selectedColor: AppColor.mainColor,
      //backgroundColor: AppColor.greyColor,
      barrierDismissible: false,
      //timeTextStyle: GoogleFonts.inter(),
      //activeTimeTextStyle: GoogleFonts.inter()

    );
    controller.startTimeValue.value = controller.startTimeFunc(startTime: result.startTime);
    controller.stopTimeValue.value = controller.stopTimeFunc(stopTime: result.endTime);
    setState(() {
      controller.daysOfTheWeekCheckBox[index].addAll({
        "from": controller.startTimeValue.value, 
        "to" : controller.stopTimeValue.value,
      });
    });
    print("start = ${controller.startTimeValue.value} : stop = ${controller.stopTimeValue.value}");
  
    //print("start = ${jay} : stop = ${alvin}");
  }

  

  
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openTimeRangePicker(context: context, index: widget.index);
      },
      child: Container(
        color: AppColor.bgColor,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //from container      
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 130,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.textGreyColor,
                  width: 1.0, //2
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [                  
                  Text(
                    controller.daysOfTheWeekCheckBox[widget.index]['from'] ?? "from", //"${controller.startTime.value}: ${controller.startMinute.value}",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: AppColor.textGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                      )
                    )
                  ),                   
                  SizedBox(width: 5,),
                  Icon(
                    CupertinoIcons.time,
                    color: AppColor.textGreyColor,
                  )
                ],
              ),
            ),
            SizedBox(width: 10,),
            Text(
              "-",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.textGreyColor,
                  fontSize: 16,
                  //fontWeight: FontWeight.w500
                )
              )
            ),           
            SizedBox(width: 10,),
            //to container
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 130,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.textGreyColor,
                  width: 1.0, //2
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [          
                  Text(
                    controller.daysOfTheWeekCheckBox[widget.index]['to'] ?? "to", //"${controller.endTime.value}: ${controller.endMinute.value}",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                      color: AppColor.textGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                      )
                    )
                  ),                                  
                  SizedBox(width: 5,),
                  Icon(
                    CupertinoIcons.time,
                    color: AppColor.textGreyColor,
                  )
                ],
              ),
            ),
            SizedBox(width: 5,),
            //delete icon
            Expanded(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    controller.daysOfTheWeekCheckBox[widget.index]["isChecked"] = false;
                    controller.daysOfTheWeekCheckBox[widget.index]['to'] = "to";
                    controller.daysOfTheWeekCheckBox[widget.index]['from'] = "from";
                  });
                  print(controller.daysOfTheWeekCheckBox[widget.index]["isChecked"]);
                }, 
                icon: Icon(Icons.delete_outline_rounded),
                color: AppColor.textGreyColor,
              ),
            )
          ],
        )     
      ),
    );
  }
}