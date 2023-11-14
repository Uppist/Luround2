import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r)
          )
        ),
        backgroundColor: AppColor.bgColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
        content: Wrap(
          children: [
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              decoration: BoxDecoration(
                //image: DecorationImage(image: AssetImage(''),),
                color: AppColor.bgColor,
                /*borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),*/
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                
                  Text(
                    "Meeting Rescheduled",
                    style: GoogleFonts.inter(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      "This meeting has been rescheduled. The other party would be informed of this change.",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGreyColor
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  ReusableButton(
                    onPressed: () {
                      //let me try this getx navigation technique
                      //Get.offUntil(GetPageRoute(page: () => MainPage()), (route) => true);
                      Get.back();
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