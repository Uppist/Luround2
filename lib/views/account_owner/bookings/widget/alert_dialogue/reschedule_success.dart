import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';








///Alert Dialog
Future<void> rescheduleDialogueBox({required BuildContext context}) async{
  showDialog(
    useSafeArea: true,
    context: context, 
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15)
          )
        ),
        backgroundColor: AppColor.bgColor,
        content: Wrap(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    "Meeting Rescheduled",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "    This meeting has bee rescheduled.\n  The other party would be informed of\n                       this change.",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                  SizedBox(height: 40,),
                  ReusableButton(
                    onPressed: () {
                      //let me try this getx navigation technique
                      Get.offUntil(GetPageRoute(page: () => MainPage()), (route) => true);
                    },
                    color: AppColor.mainColor,
                    text: 'Okay',
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    }
  );
}