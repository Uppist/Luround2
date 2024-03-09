import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/bookings_service/user_bookings_services.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/screen/reschedule_screen.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/cancel_booking_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/delete_bookings_bottomsheet.dart';







///Alert Dialog
Future<void> bookingsListDialogueBox({
  required VoidCallback onDelete,
  required BuildContext context, 
  required String serviceName,
  required String serviceDate,
  required String serviceTime,
  required String serviceDuration,
  required String bookingId,
  required String client_name, 
  required AccOwnerBookingService service
}) async {
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1
                InkWell(
                  onTap: () {
                    Get.off(() => RescheduleBookingPage(
                      bookingId: bookingId,
                      service_name: serviceName,
                      service_date: serviceDate,
                      service_time: serviceTime,
                      service_duration: serviceDuration,
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/reschedule.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Reschedule',
                        style: GoogleFonts.inter(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
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
                    //Navigator.pop(context);
                    cancelBookingDialogueBox(
                      service: service,
                      context: context, 
                      serviceName: serviceName,
                      bookingId: bookingId,
                      client_name: client_name
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/xmark.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //3
                InkWell(
                  onTap: () {

                    deleteBookingsDialogueBox(
                      context: context, 
                      titleText: serviceName, 
                      onDelete: onDelete,
                    );
                    
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/delete.svg'),
                      SizedBox(width: 20.w,),
                      Text(
                        'Delete',
                        style: GoogleFonts.inter(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
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