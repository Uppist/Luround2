import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/financials/quotes/received_quotes_response.dart';
import 'package:luround/services/account_owner/more/financials/quotes_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state_2.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/requested_quotes/requested_quotes_display.dart';







class RequestedQuotesList extends StatefulWidget {
  RequestedQuotesList({super.key});

  @override
  State<RequestedQuotesList> createState() => _RequestedQuotesListState();
}

class _RequestedQuotesListState extends State<RequestedQuotesList> {
  var service = Get.put(QuotesService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<ReceivedQuotesResponse>  newData = await service.getUserReceivedQuotes();
    // Update the UI with the new data
    newData.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));
    service.filteredReceivedQuotesList.clear();
    service.filteredReceivedQuotesList.addAll(newData); 
    print("updated filtered requested qoutes list: ${service.filteredReceivedQuotesList}");
  }

  late Future<List<ReceivedQuotesResponse>> receivedQuoteFuture;
  @override
  void initState() {
    super.initState();
    receivedQuoteFuture = service.getUserReceivedQuotes();
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<ReceivedQuotesResponse>>(
      future: receivedQuoteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: Loader(),);
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return FinancialsEmptyState2(
            onRefresh: () {
              service.getUserReceivedQuotes();
            },
            titleText: 'No requested quotes yet',
            subtitleText: 'quote requests',
          );
        }
            
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-error: ${snapshot.error}");
          
          return FinancialsEmptyState2(
            onRefresh: () {
              service.getUserReceivedQuotes();
            },
            titleText: 'No requested quotes yet',
            subtitleText: 'quote requests',
          );
        }
        if (snapshot.hasData) {
          var data = snapshot.data!;
          //sort the resulting list by name
      
          data.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));
          service.filteredReceivedQuotesList.clear();
          service.filteredReceivedQuotesList.addAll(data); 
          print("filtered requested qoutes list: ${service.filteredReceivedQuotesList}");
          return Obx(
            () {
              return  service.filteredReceivedQuotesList.isNotEmpty ? Expanded(
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
                    itemCount: service.filteredReceivedQuotesList.length,
                    //padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                          
                      final item = service.filteredReceivedQuotesList[index];
                          
                      
                      
                      return RequestedQuotesDisplay(
                        refresh: _refresh(),
                        onPressed: (){},
                        bank_name: "",
                        account_name: "",
                        account_number: "",
                        offer: item.offer,
                        created_at: item.created_at,
                        tracking_id: item.tracking_id.toString(),
                        service_name: item.service_name,
                        uploaded_file: item.uploaded_file,
                        quote_id: item.quote_id, 
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
                  ),
                ),
              ) : FinancialsEmptyState2(
                onRefresh: () {
                  //service.getUserReceivedQuotes();
                  _refresh();
                },
                titleText: 'No requested quotes yet',
                subtitleText: 'quote requests',
              );
            }
          );
        }
        return FinancialsEmptyState2(
          onRefresh: () {
            _refresh();  
          },
          titleText: 'No requested quotes yet',
          subtitleText: 'quote requests',
        );
      }
    );
  }
}