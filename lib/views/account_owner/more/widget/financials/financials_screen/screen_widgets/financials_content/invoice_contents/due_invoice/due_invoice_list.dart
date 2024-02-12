import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/invoice_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/due_invoice/due_invoice_display.dart';





class DueInvoiceList extends StatelessWidget {
  DueInvoiceList({super.key});
  
  var service = Get.put(InvoicesService());

  @override
  Widget build(BuildContext context) {
    return Obx(      () {
        return service.isLoading.value ? Expanded(child: Loader()) : service.filteredUnpaidInvoiceList.isNotEmpty ? Expanded(
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
              //bool isDueInThreeDays = service.isDueInThreeDays(item.due_date);

              if(service.filteredDueInvoiceList.isEmpty) {
                return FinancialsEmptyState(
                  titleText: 'No invoice yet',
                  subtitleText: 'an invoice',
                );
              }
              if(service.filteredDueInvoiceList.isNotEmpty) {
                return DueInvoiceDisplay (
                  onPressed: (){},
                  bank_name: item.bank_name,
                  account_name: item.account_name,
                  account_number: item.account_number,
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

              return FinancialsEmptyState(
                titleText: 'No invoice yet',
                subtitleText: 'an invoice',
              );
            
            }
          ),
        ) : FinancialsEmptyState(
            titleText: 'No invoice yet',
            subtitleText: 'an invoice',
          );
      }
    );
  }
}