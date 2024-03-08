import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/financials/invoice/invoice_respose_model.dart';
import 'package:luround/services/account_owner/more/financials/invoice_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/due_invoice/due_invoice_display.dart';





class DueInvoiceList extends StatelessWidget {
  DueInvoiceList({super.key});
  
  var service = Get.put(InvoicesService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<InvoiceResponse>  newData = await service.getUserUnpaidInvoice();
    // Update the UI with the new data

    newData.sort((a, b) => a.send_to_name.toLowerCase().compareTo(b.send_to_name.toLowerCase()));
    service.filteredUnpaidInvoiceList.clear();
    service.filteredUnpaidInvoiceList.addAll(newData); 
  }

  @override
  Widget build(BuildContext context) {
    return Obx(      
      () {
        return service.filteredDueInvoiceList.isNotEmpty ? RefreshIndicator.adaptive(
          color: AppColor.greyColor,
          backgroundColor: AppColor.mainColor,
          key: _refreshKey,
          onRefresh: () {
            return _refresh();
          },
          child: Expanded(
            child: ListView.separated( 
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemCount: service.filteredDueInvoiceList.length,
              //padding: EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
              
                final item = service.filteredDueInvoiceList[index];
                
                return DueInvoiceDisplay (
                  onPressed: (){},
                  invoice_generated_from_quote: item.invoice_generated_from_quote,
                  service_provider: item.service_provider,
                  tracking_id: item.tracking_id.toString(),
                  created_at: item.created_at,
                  service_provider_address: item.service_provider['address'] ?? "non",
                  service_provider_phone_number: item.service_provider['phone_number'] ?? "non",
                  invoice_id: item.invoice_id,
                  send_to_name: item.send_to_name,
                  send_to_email: item.send_to_email,
                  phone_number: item.phone_number,
                  due_date: item.due_date,
                  sub_total: item.sub_total,
                  discount: item.discount,
                  vat: item.vat,
                  total: item.total,
                  note: item.note,
                  status: service.filteredDueInvoiceList.isNotEmpty ? "DUE" : item.status,
                  booking_detail: item.booking_detail,
                );
              
              }
            ),
          ),
        ) : FinancialsEmptyState(
          titleText: 'No invoice yet',
          subtitleText: 'an invoice',
        );
      }
    );
  }
}