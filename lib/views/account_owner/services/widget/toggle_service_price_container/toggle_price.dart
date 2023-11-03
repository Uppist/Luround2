import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';






class TogglePriceContainer extends StatefulWidget {
  TogglePriceContainer({super.key, required this.index});
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
              children: List.generate(controller.tabs.length, (i) {
                return GestureDetector(
                  onTap: () {
                    controller.handleTabTap(i);
                  },
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        //height: 70,
                        width: 100,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == i ? AppColor.navyBlue : AppColor.bgColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          controller.tabs[i],
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: controller.selectedIndex.value == i ? AppColor.bgColor : AppColor.textGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          }
        )
        
        
        
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
  
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    alignment: Alignment.center,
                    //height: 70,
                    //width: 150,
                    decoration: BoxDecoration(
                      color: AppColor.navyBlue,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: AppColor.navyBlue,
                        width: 2.0,
                      )
                    ),
                    child: Text(
                      "In-person",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.bgColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  ),
              
            
            ),
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Virtual",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.textGreyColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  )
                )
              ),
            ),*/
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                alignment: Alignment.center,
                //height: 70,
                //width: 150,
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.all(
                    color: AppColor.bgColor,
                    width: 2.0,
                  )
                ),
                child: Text(
                  "In-person",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.textGreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              ),
            ),
            
          ],
        ),*/
    );
  }
}