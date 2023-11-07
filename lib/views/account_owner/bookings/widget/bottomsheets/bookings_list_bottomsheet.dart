import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/screen/reschedule_screen.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/cancel_booking_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/delete_bookings_bottomsheet.dart';








///Alert Dialog
Future<void> bookingsListDialogueBox({required BuildContext context, required String serviceName,}) async {
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
                  onTap: () {
                    Get.off(() => RescheduleBookingPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/reschedule.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Reschedule',
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
                  onTap: () {
                    cancelBookingDialogueBox(context: context, serviceName: serviceName,);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/xmark.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Cancel',
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
                //3
                InkWell(
                  onTap: () {
                    deleteBookingsDialogueBox(context: context, titleText: serviceName,);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/delete.svg'),
                      SizedBox(width: 20,),
                      Text(
                        'Delete',
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