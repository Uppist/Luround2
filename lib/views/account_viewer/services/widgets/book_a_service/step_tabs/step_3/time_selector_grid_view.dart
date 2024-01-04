import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/utils/colors/app_theme.dart';








class TimeGridView extends StatefulWidget {
  TimeGridView({super.key, required this.avail_time,});
  final List<dynamic> avail_time;

  @override
  State<TimeGridView> createState() => _TimeGridViewState();
}

var controller = Get.put(AccViewerServicesController());

class _TimeGridViewState extends State<TimeGridView> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("available time list: ${widget.avail_time}");
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 35, //10,
        mainAxisSpacing: 25, //10,
        childAspectRatio: 3.0, // Adjust this ratio as needed to control the item size
      ), 
      physics: NeverScrollableScrollPhysics(), //BouncingScrollPhysics(),
      itemCount: widget.avail_time.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if(widget.avail_time.isEmpty) {
          print("available time list: ${widget.avail_time}");
          return Text(
            "No available time for this service",
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400
            ),
          );
        }
        return InkWell(
          onTap: () {
            setState(() {
              controller.selectedindex = index;
              print(index);
              controller.onAvailableTimeSelected(
                avail_time: widget.avail_time,
                index: controller.selectedindex
              );
            });
          },
          child: Container(
            alignment: Alignment.center,
            //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            height: 50.h,
            //width: 120,
            decoration: BoxDecoration(          
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: controller.selectedindex == index ? AppColor.mainColor : AppColor.textGreyColor.withOpacity(0.2)
              )
            ),
            child: Text(
              "${widget.avail_time[index]}",  //${index}
              style: GoogleFonts.inter(
                color: controller.selectedindex == index ? AppColor.mainColor : AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            )
          ),
        );
      }
    );
  }
}