import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/financials/quotes/sent_quotes_response_model.dart';
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/sent_quotes/sent_quotes_display.dart';







class QuotesList extends StatefulWidget {
  QuotesList({super.key,});

  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  var service = Get.put(QuotesService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  late Future<List<SentQuotesResponse>> sentQuoteFuture;
  @override
  void initState() {
    super.initState();
    sentQuoteFuture = service.getUserSentQuotes();
    
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<SentQuotesResponse>  newData = await service.getUserSentQuotes();
    // Update the UI with the new data
    newData.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));
    service.filteredSentQuotesList.clear();
    service.filteredSentQuotesList.addAll(newData);
    print("updated filtered sent qoutes list: ${service.filteredSentQuotesList}");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sentQuoteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: Loader(),);
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return FinancialsEmptyState(
            titleText: 'No sent quotes yet',
            subtitleText: 'a quote',
          );
        }
          
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-error: ${snapshot.error}");
        
          return FinancialsEmptyState(
            titleText: 'No sent quotes yet',
            subtitleText: 'a quote',
          );
        }
               
        if (snapshot.hasData) {
          var data = snapshot.data!;
          //sort the resulting list by name
    
          data.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));
          service.filteredSentQuotesList.clear();
          service.filteredSentQuotesList.addAll(data); 
          print("filtered sent qoutes list: ${service.filteredSentQuotesList}");
        
          return Obx(
            () {
              return service.filteredSentQuotesList.isNotEmpty ? Expanded(
                child: RefreshIndicator.adaptive(
                  color: AppColor.greyColor,
                  backgroundColor: AppColor.mainColor,
                  key: _refreshKey,
                  onRefresh: () {
                    return _refresh();
                  },
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
                          refresh: _refresh(),
                          onPressed: (){},
                          created_at: item.created_at,
                          tracking_id: item.tracking_id.toString(),
                          quote_id: item.quote_id, //randNum.toString(), 
                          service_provider_address: item.service_provider['address'] ?? "non",
                          service_provider_phone_number: item.service_provider['phone_number'] ?? "non",
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
                ),
              ):FinancialsEmptyState(
                titleText: 'No sent quotes yet',
                subtitleText: 'a quote',
              );
            }
          );
        }
        return FinancialsEmptyState(
          titleText: 'No sent quotes yet',
          subtitleText: 'a quote',
        );
    
      }
    );
  }
}