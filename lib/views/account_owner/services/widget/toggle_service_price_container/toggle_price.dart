import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';






class TogglePriceContainer extends StatefulWidget {
  TogglePriceContainer({super.key, required this.index,});
  final int index;

  @override
  State<TogglePriceContainer> createState() => _TogglePriceContainerState();
}

class _TogglePriceContainerState extends State<TogglePriceContainer> {
  var controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(),
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        alignment: Alignment.center,
        height: 50,
        width: 210, //250,
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(
            color: AppColor.navyBlue,
            width: 2.0,
          )
        ),
        child: Obx(
          () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.handleTabTap(widget.index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    //height: 70,
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      color: controller.isVirtual.value &&  controller.selectedIndex.value == widget.index ? AppColor.navyBlue : AppColor.bgColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Virtual',
                      style: GoogleFonts.inter(
                        color: controller.isVirtual.value &&  controller.selectedIndex.value == widget.index ? AppColor.bgColor : AppColor.textGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.handleTabTap(widget.index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    //height: 70,
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      color: controller.isVirtual.value &&  controller.selectedIndex.value == widget.index ? AppColor.bgColor : AppColor.navyBlue, //.redColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'In-person',
                      style: GoogleFonts.inter(
                        color: controller.isVirtual.value &&  controller.selectedIndex.value == widget.index ? AppColor.textGreyColor : AppColor.bgColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ]
            );
          }
        )
    );
  }
}