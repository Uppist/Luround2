import 'dart:math';
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
  int randNum = Random().nextInt(200000);

  @override
  Widget build(BuildContext context) {
    return Obx(
      //stream: service.streamController.stream,
      () {
        return service.isLoading.value ? Expanded(child: Loader()) : service.filteredSentQuotesList.isNotEmpty ? Expanded(
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
                  created_at: item.created_at,
                  tracking_id: item.tracking_id.toString(),
                  quote_id: item.quote_id, //randNum.toString(), 
                  service_provider_address: item.service_provider['address'],
                  service_provider_phone_number: item.service_provider['phone_number'],
                  send_to_name: item.send_to_name,
                  send_to_email: item.send_to_email,
                  phone_number:item.phone_number,
                  due_date: item.due_date,
                  quote_date: item.quote_date,
                  sub_total: item.sub_total,
                  discount: item.discount,
                  vat: item.vat,
                  total: item.total,
                  appointment_type: item.appointment_type,
                  status: item.status,
                  note: item.note,
                  service_provider: item.service_provider,
                  product_details: item.product_details
                );
              }

              return FinancialsEmptyState(
                titleText: 'No sent quotes yet',
                subtitleText: 'a quote',
              );
            }
          ),
        ):FinancialsEmptyState(
          titleText: 'No sent quotes yet',
          subtitleText: 'a quote',
        );
      }
    );
  }
}