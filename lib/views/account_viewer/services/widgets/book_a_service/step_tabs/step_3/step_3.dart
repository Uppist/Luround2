import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/step_tabs/step_3/time_selector_grid_view.dart';
import '../../../../../../../utils/colors/app_theme.dart';








class Step3Screen extends StatefulWidget {
  Step3Screen({super.key,required this.onSubmit});
  final VoidCallback onSubmit;

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select time",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20.h,),
          //time gridview        
          TimeGridView(),
          SizedBox(height: 220.h,),
          RebrandedReusableButton(
            textColor: AppColor.bgColor,
            color: AppColor.mainColor,
            text: "Next", 
            onPressed: widget.onSubmit,
          ),
          SizedBox(height: 10.h,),
        ],
      ),
    );
  }
}