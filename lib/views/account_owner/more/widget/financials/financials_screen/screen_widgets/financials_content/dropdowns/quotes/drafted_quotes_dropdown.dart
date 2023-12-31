import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/quotes_screen/drafted_quotes/view_drafted_quotes.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/delete_quote/delete_quote.dart';






class DraftedQuoteDropDown extends StatelessWidget {
  DraftedQuoteDropDown({super.key});

  var service = Get.put(FinancialsService());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColor.bgColor,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      initialValue: "Quote",
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              Get.to(() => ViewDraftedQuoteScreen());
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
          PopupMenuItem(
            onTap: () {},
            child: Text(
              "Resend",
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
              print('gggggeee');
            },
            child: Text(
              "Convert to invoice",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              deleteQuoteBottomSheet(
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