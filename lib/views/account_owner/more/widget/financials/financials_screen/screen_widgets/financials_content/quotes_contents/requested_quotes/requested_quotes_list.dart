import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state_2.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/requested_quotes/requested_quotes_display.dart';






class RequestedQuotesList extends StatelessWidget {
  RequestedQuotesList({super.key});

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
            itemCount: service.filteredReceivedQuotesList.length,
            //padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {

              final item = service.filteredReceivedQuotesList[index];

              if(service.filteredReceivedQuotesList.isEmpty) {
                return FinancialsEmptyState2(
                  onRefresh: () {
                    service.isLoading.value = true;
                    service.loadReceivedQuotesData();
                    service.isLoading.value = false;
                  },
                  titleText: 'No requested quotes yet',
                  subtitleText: 'quote requests',
                );
              }
              if(service.filteredReceivedQuotesList.isNotEmpty) {
                return RequestedQuotesDisplay(
                  onPressed: (){},
                );
              }

              return FinancialsEmptyState2(
                onRefresh: () {
                  service.isLoading.value = true;
                  service.loadReceivedQuotesData();
                  service.isLoading.value = false;
                },
                titleText: 'No requested quotes yet',
                subtitleText: 'quote requests',
              );
            }
          ),
        );
      }
    );
  }
}