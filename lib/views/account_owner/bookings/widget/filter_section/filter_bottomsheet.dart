import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








///Alert Dialog
Future<void> filterDialogueBox({required BuildContext context}) async {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/sent.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Sent',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                //2
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/received.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Received',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                //1
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/upcoming.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Upcoming',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                //1
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/past.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Past',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                //1
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/cancelled.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Cancelled',
                        style: GoogleFonts.poppins(
                          color: AppColor.textGreyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                /////
              ],
            ),
          ),
        ],
      );
    }
  );
}