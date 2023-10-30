import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class TimeGridView extends StatefulWidget {
  TimeGridView({super.key,});

  @override
  State<TimeGridView> createState() => _TimeGridViewState();
}

var controller = Get.put(AccViewerServicesController());

class _TimeGridViewState extends State<TimeGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 35, //10,
        mainAxisSpacing: 25, //10,
      ), 
      physics: NeverScrollableScrollPhysics(), //BouncingScrollPhysics(),
      itemCount: 8,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              controller.selectedindex = index;
              print(index);
            });
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 30,
            //width: 120,
            decoration: BoxDecoration(          
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: controller.selectedindex == index ? AppColor.mainColor : AppColor.textGreyColor.withOpacity(0.2)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,  //start
              children: [
                Text(
                  "9:50AM ${index}",
                  style: GoogleFonts.inter(
                    color: controller.selectedindex == index ? AppColor.mainColor : AppColor.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            )
          ),
        );
      }
    );
  }
}