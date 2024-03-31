import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';





class StopTimeBoxPackage extends StatefulWidget {
  const StopTimeBoxPackage({super.key});

  @override
  State<StopTimeBoxPackage> createState() => _StopTimeBoxPackageState();
}

class _StopTimeBoxPackageState extends State<StopTimeBoxPackage> {

  var controller = Get.put(PackageServiceController());

  //t2
  Future<void> openFlutterTimePickerForStopTime({required BuildContext context}) async{
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
        controller.stopTimeValue.value = time.format(context);
        print(controller.stopTimeValue.value);
      });
      controller.calculateDuration(startTime: controller.startTimeValue.value, endTime: controller.stopTimeValue.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openFlutterTimePickerForStopTime(context: context);
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
          controller.stopTimeValue.value.isNotEmpty ? controller.stopTimeValue.value : "stop time",
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