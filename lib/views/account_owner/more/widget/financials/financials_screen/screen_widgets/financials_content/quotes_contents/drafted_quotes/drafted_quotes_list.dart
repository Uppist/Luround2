import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/drafted_quotes/drafted_quotes_display.dart';







class DraftedQuotesList extends StatefulWidget {
  DraftedQuotesList({super.key});

  @override
  State<DraftedQuotesList> createState() => _DraftedQuotesListState();
}

class _DraftedQuotesListState extends State<DraftedQuotesList> {

  var service = Get.put(QuotesService());
  
  /*@override
  void initState() {
    // TODO: implement initState
    service.loadDraftedQuotesData().then(
      (value) => print("Drafted Quotes Loaded into the Widget Tree: $value")
    );
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return service.isLoading.value ? Expanded(child: Loader()) : Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemCount: service.filteredDraftedQuotesList.length,
            //padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              
              final item = service.filteredDraftedQuotesList[index];

              if(service.filteredDraftedQuotesList.isEmpty) {
                return FinancialsEmptyState(
                  titleText: 'No drafts yet',
                  subtitleText: 'a quote',
                );
              }
              if(service.filteredDraftedQuotesList.isNotEmpty) {
                return DraftedQuotesDisplay(
                  onPressed: (){},
                  quote_id: item.quote_date, 
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
                titleText: 'No drafts yet',
                subtitleText: 'a quote',
              );
  
            }
          ),
        );
      }
    );
  }
}