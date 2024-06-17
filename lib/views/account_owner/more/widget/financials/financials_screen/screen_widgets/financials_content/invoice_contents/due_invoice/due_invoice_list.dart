import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/financials/invoice/invoice_respose_model.dart';
import 'package:luround/services/account_owner/more/financials/invoice_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/due_invoice/due_invoice_display.dart';







class DueInvoiceList extends StatelessWidget {
  DueInvoiceList({super.key});
  
  final service = Get.put(InvoicesService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  //check if an invoice is due
  Future<void> _refresh() async{
    await Future.delayed(const Duration(seconds: 1));
    // Loop through the user list and check if each object is due
    for (InvoiceResponse invoice in  service.unpaidInvoiceList) {
      if (service.isDueInThreeDays(invoice)) {
        service.filteredDueInvoiceList.clear();
        service.filteredDueInvoiceList.add(invoice);
      }
    }

    // Print the due list
    log("Due List: ${service.filteredDueInvoiceList}");
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
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemCount: service.filteredDueInvoiceList.length,
              //padding: EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
              
                final item = service.filteredDueInvoiceList[index];
                
                return DueInvoiceDisplay (
                  onPressed: (){},
                  refresh: _refresh(),
                  invoice_generated_from_quote: item.invoice_generated_from_quote,
                  service_provider: item.service_provider,
                  tracking_id: item.tracking_id.toString(),
                  created_at: item.created_at,
                  service_provider_address: item.service_provider['address'] ?? "no address",
                  service_provider_phone_number: item.service_provider['phone_number'] ?? "no phone number",
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
        ) : const FinancialsEmptyState(
          titleText: 'No invoice yet',
          subtitleText: 'an invoice',
        );
      }
    );
  }
}