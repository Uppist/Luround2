import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';





///Alert Dialog
Future<void> enterPaymentBottomSheet({required BuildContext context, required VoidCallback onDelete, required FinancialsService service}) async{
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
      return Container(
        //height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        width: double.infinity,
        color: AppColor.bgColor,
        child: Builder(
          builder:(context) {
            return Wrap(  
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    SizedBox(height: 30.h,),*/
                    
            
                  ],
                ),
              ],
            );
          }
        ),
      );
    }
  );
}