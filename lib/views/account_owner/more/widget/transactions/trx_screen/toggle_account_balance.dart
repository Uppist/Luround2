import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';






///Alert Dialog
Future<void> toggleAccountBalance({
  required BuildContext context,
  required VoidCallback onWalletBalance,
  required VoidCallback onAmountPaidBalance,
  required VoidCallback onAmountReceivedBalance,
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
                  onTap: onAmountReceivedBalance,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Total amount received',
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //2
                /*InkWell(
                  onTap: onAmountPaidBalance,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Total amount paid',
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
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
                  onTap: onWalletBalance,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet',
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),*/
                //SizedBox(height: 30.h,),
                /////
              ],
            ),
          ),
        ],
      );
    }
  );
}