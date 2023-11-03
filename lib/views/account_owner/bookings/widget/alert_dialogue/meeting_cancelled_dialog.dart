import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';








///Alert Dialog
Future<void> meetingCancelledBookingDialogueBox({required BuildContext context,}) async{
  showDialog(
    /*isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    backgroundColor: AppColor.bgColor,*/
    //barrierColor: Theme.of(context).colorScheme.background,
    useSafeArea: true,
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15)
          )
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        content: Wrap(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meeting Cancelled"',
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30,),
                Text(
                  'This meeting has been cancelled. The other party will be informed of this change.',
                  style: GoogleFonts.poppins(
                    color: AppColor.darkGreyColor,
                    fontSize: 14,
                    //fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: () {
                    Get.back(closeOverlays: true);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.center,
                    height: 50,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.mainColor
                      )
                    ),
                    child: Text(
                      "Okay",
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
                SizedBox(height: 10,),
        
              ],
            ),
          ],
        ),
      );
    }
  );
}