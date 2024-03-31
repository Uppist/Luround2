import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';





class StartTimeBoxProgramEdit extends StatefulWidget {
  const StartTimeBoxProgramEdit({super.key});

  @override
  State<StartTimeBoxProgramEdit> createState() => _StartTimeBoxProgramEditState();
}

class _StartTimeBoxProgramEditState extends State<StartTimeBoxProgramEdit> {

  var controller = Get.put(ProgramServiceController());

  //t1
  Future<void> openFlutterTimePickerForStartTimeEdit({required BuildContext context}) async{
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
        controller.startTimeValueEdit.value = time.format(context);
        print(controller.startTimeValueEdit.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openFlutterTimePickerForStartTimeEdit(context: context);
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
          controller.startTimeValueEdit.value.isNotEmpty ? controller.startTimeValueEdit.value : "start time",
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