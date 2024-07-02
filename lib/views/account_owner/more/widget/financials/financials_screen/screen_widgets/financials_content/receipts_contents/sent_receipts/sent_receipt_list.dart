import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/financials/receipt/receipt_response_model.dart';
import 'package:luround/services/account_owner/more/financials/receipt_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/receipts_contents/sent_receipts/sent_receipt_display.dart';






class SentReceiptList extends StatefulWidget {
  SentReceiptList({super.key});

  @override
  State<SentReceiptList> createState() => _SentReceiptListState();
}

class _SentReceiptListState extends State<SentReceiptList> {
  var service = Get.put(ReceiptsService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<ReceiptResponse>  newData = await service.getUserSentReceipt();
    // Update the UI with the new data

    newData.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));
    service.filteredSentReceiptList.clear();
    service.filteredSentReceiptList.addAll(newData); 
  }

  late Future<List<ReceiptResponse>> sentReceiptFuture;
  @override
  void initState() {
    super.initState();
    sentReceiptFuture = service.getUserSentReceipt(); 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReceiptResponse>>(
      future: sentReceiptFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: Loader(),);
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return FinancialsEmptyState(
            titleText: 'No receipt yet',
            subtitleText: 'a receipt',
          );
        }
            
        if (!snapshot.hasData) {
          print("sn-trace: ${snapshot.stackTrace}");
          print("sn-error: ${snapshot.error}");
          
          return FinancialsEmptyState(
            titleText: 'No receipt yet',
            subtitleText: 'a receipt',
          );
        }
        if (snapshot.hasData) {
          var data = snapshot.data!;
          //sort the resulting list by name
      
          data.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));
          service.filteredSentReceiptList.clear();
          service.filteredSentReceiptList.addAll(data); 

          return Obx(
            () {
              return service.filteredSentReceiptList.isNotEmpty ? Expanded(
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
                    itemCount: service.filteredSentReceiptList.length,
                    //padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      
                      final item = service.filteredSentReceiptList[index]; 
                    
                      return SentReceiptDisplay(
                        refresh: _refresh(),
                        onPressed: (){},
                        created_at: item.created_at,
                        tracking_id: item.tracking_id.toString(),
                        service_provider_address: item.service_provider_address ?? "",
                        service_provider_phone_number: item.service_provider_phone_number ?? "",
                        receipt_id: item.receipt_id,
                        send_to: item.send_to_name,
                        sent_to_email: item.send_to_email,
                        phone_number: item.phone_number,
                        payment_status: item.payment_status,
                        discount: item.discount,
                        vat: item.vat,
                        sub_total: item.sub_total,
                        total: item.total,
                        note: item.note,
                        mode_of_payment: item.mode_of_payment,
                        receipt_date: item.receipt_date,
                        service_provider_name: item.service_provider_name,
                        service_provider_email: item.service_provider_email,
                        service_provider_userId: item.service_provider_userId,
                        service_detail: item.service_detail,
                      );
                    }
                    
                  ),
                ),
              )
              :FinancialsEmptyState(
                titleText: 'No receipt yet',
                subtitleText: 'a receipt',
              );
            }
          );
        }

        return FinancialsEmptyState(
         titleText: 'No receipt yet',
          subtitleText: 'a receipt',
        );

      }
    );
  }
}