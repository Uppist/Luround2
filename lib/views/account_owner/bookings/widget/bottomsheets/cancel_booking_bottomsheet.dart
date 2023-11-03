import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/widget/alert_dialogue/meeting_cancelled_dialog.dart';








///Alert Dialog
Future<void> cancelBookingDialogueBox({required BuildContext context, required String serviceName}) async{
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cancel "${serviceName}"',
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 40,),
                Text(
                  'Are you sure you want to cancel this booking ?',
                  style: GoogleFonts.poppins(
                    color: AppColor.darkGreyColor,
                    fontSize: 14,
                    //fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 40,),
                InkWell(
                  onTap: () {
                    meetingCancelledBookingDialogueBox(context: context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.center,
                    height: 50,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.redColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.redColor
                      )
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.bgColor,
                          fontSize: 18,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  )
                ),
                SizedBox(height:25),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.center,
                    height: 50,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.darkGreyColor
                      )
                    ),
                    child: Text(
                      "Do not cancel",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.darkGreyColor,
                          fontSize: 18,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  )
                ),

                //SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      );
    }
  );
}