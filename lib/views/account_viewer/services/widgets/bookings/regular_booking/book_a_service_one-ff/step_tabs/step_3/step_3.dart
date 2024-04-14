import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/regular_booking/book_a_service_one-ff/step_tabs/step_3/time_selector_grid_view.dart';
import '../../../../../../../../../utils/colors/app_theme.dart';








class Step3Screen extends StatefulWidget {
  Step3Screen({super.key,required this.onSubmit, required this.avail_time});
  final VoidCallback onSubmit;
  final List<dynamic> avail_time;

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
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20.h,),
          //time gridview        
          TimeGridView(
            avail_time: widget.avail_time,
          ),

          //sizedbox_height
          SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
          
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