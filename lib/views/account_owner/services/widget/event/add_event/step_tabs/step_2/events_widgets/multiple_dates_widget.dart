import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';









class MultipleDatesWidget extends StatefulWidget {
  const MultipleDatesWidget({super.key});

  @override
  State<MultipleDatesWidget> createState() => _MultipleDatesWidgetState();
}

class _MultipleDatesWidgetState extends State<MultipleDatesWidget> {

  final controller = Get.put(EventsController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: controller.addRow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    size: 24.r,
                    color: AppColor.textGreyColor,
                    Icons.add
                  ),
                  SizedBox(width: 5.w,),
                  Text(
                    "Add date slot",
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(width: 10.w,),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(
                "Start time",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(
                "End time",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        ),
    
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    
        Obx(
          () {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), //const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: controller.widgetList.length,
              itemBuilder: (context, index) {
                return controller.widgetList[index];
              },
            );
          }
        ),
    
      ],
    );
  }

}

