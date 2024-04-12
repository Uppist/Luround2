import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';





class StopTimeBoxProgramEdit extends StatefulWidget {
  const StopTimeBoxProgramEdit({super.key});

  @override
  State<StopTimeBoxProgramEdit> createState() => _StopTimeBoxProgramEditState();
}

class _StopTimeBoxProgramEditState extends State<StopTimeBoxProgramEdit> {

  var controller = Get.put(ProgramServiceController());

  //t2
  Future<void> openFlutterTimePickerForStopTimeEdit({required BuildContext context}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), 
          child: child!
        );
      },
    );

    if (time != null) {
      setState(() {
        controller.stopTimeValueEdit.value= time.format(context);
        print(controller.stopTimeValueEdit.value);
      });
      controller.calculateDurationEdit(startTime: controller.startTimeValueEdit.value, endTime: controller.stopTimeValueEdit.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openFlutterTimePickerForStopTimeEdit(context: context);
      },
      child: Container(
        alignment: Alignment.center,
        height: 45.h,
        width: 85.w,
        //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColor.textGreyColor,
            width: 1.0, //2
          )
        ),
        child: Text(
          controller.stopTimeValueEdit.value.isNotEmpty ? controller.stopTimeValueEdit.value : "stop time",
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.textGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400
            )
          )
        )
      ),
    );
  }
}