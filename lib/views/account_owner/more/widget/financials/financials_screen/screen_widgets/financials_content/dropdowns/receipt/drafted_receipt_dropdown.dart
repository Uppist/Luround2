import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/receipt_screen/drafted_receipts/view_drafted_receipts.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/receipts_contents/delete_receipt/delete_receipt.dart';






class DraftedReceiptDropDown extends StatelessWidget {
  DraftedReceiptDropDown({super.key});

  var service = Get.put(FinancialsService());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColor.bgColor,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      initialValue: "Receipt",
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              Get.to(() => ViewDraftedReceiptScreen());
            },
            child: Text(
              "View",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          /*PopupMenuItem(
            onTap: () {
              print('gggggffff');
            },
            child: Text(
              "Edit",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),*/
          PopupMenuItem(
            onTap: () {
              print('gggggffff');
            },
            child: Text(
              "Send",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              print('gggggeee');
            },
            child: Text(
              "Download",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              deleteReceiptsBottomSheet(
                context: context,
                onDelete: () {},
                service: service
              );
            },
            child: Text(
              "Delete",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          )
        ];
      },
      icon: Icon(Icons.more_vert_rounded, color: AppColor.darkGreyColor,),
    );
  }
}