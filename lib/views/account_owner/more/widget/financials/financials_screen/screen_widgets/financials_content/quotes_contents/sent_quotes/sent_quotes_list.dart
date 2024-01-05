import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/sent_quotes/sent_quotes_display.dart';







class QuotesList extends StatelessWidget {
  QuotesList({super.key,});

  var service = Get.put(QuotesService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return service.isLoading.value ? Loader() : Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemCount: service.filteredSentQuotesList.length,
            //padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final item = service.filteredSentQuotesList[index];    
              if(service.filteredSentQuotesList.isEmpty) {
                return FinancialsEmptyState(
                  titleText: 'No sent quotes yet',
                  subtitleText: 'a quote',
                );
              }
              if(service.filteredSentQuotesList.isNotEmpty) {
                return QuotesDisplay(
                  onPressed: (){},
                );
              }

              return FinancialsEmptyState(
                titleText: 'No sent quotes yet',
                subtitleText: 'a quote',
              );
            }
          ),
        );
      }
    );
  }
}