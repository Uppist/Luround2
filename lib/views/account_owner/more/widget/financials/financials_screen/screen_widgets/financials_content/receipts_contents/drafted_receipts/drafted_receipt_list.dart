import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/receipts_contents/drafted_receipts/drafted_receipt_display.dart';







class DraftedReceiptList extends StatelessWidget {
  const DraftedReceiptList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: 6,
        //padding: EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          return DraftedReceiptDisplay(
            onPressed: (){},
          );
        }
      ),
    );
  }
}