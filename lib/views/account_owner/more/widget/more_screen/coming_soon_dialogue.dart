import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';









///Alert Dialog
Future<void> comingSoonDialogue({required BuildContext context,}) async{
  showDialog(
    /*isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    backgroundColor: AppColor.bgColor,*/
    barrierDismissible: false,
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
                  'Integration',
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30,),
                Text(
                  '       Enhance your meeting experience by\n    integrating your favorite apps and tools.\n                        (coming soon)',
                  style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
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