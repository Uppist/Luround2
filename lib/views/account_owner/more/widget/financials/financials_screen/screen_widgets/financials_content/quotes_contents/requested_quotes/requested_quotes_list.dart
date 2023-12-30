import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/requested_quotes/requested_quotes_display.dart';






class RequestedQuotesList extends StatelessWidget {
  const RequestedQuotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: 4,
        //padding: EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          return RequestedQuotesDisplay(
            onPressed: (){},
          );
        }
      ),
    );
  }
}