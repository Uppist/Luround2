import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/invoice_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/unpaid_invoice/unpaid_invoice_display.dart';







class UnpaidInvoiceList extends StatelessWidget {
  UnpaidInvoiceList({super.key});

  var service = Get.put(InvoicesService());

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
            itemCount: service.filteredUnpaidInvoiceList.length,
            //padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final item = service.filteredUnpaidInvoiceList[index]; 
              if(service.filteredUnpaidInvoiceList.isEmpty) {
                return FinancialsEmptyState(
                  titleText: 'No invoice yet',
                  subtitleText: 'an invoice',
                );
              }
              if(service.filteredUnpaidInvoiceList.isNotEmpty) {
                 return UnpaidInvoiceDisplay(
                  onPressed: (){},
                );
              }

              return FinancialsEmptyState(
                titleText: 'No invoice yet',
                subtitleText: 'an invoice',
              );
            }
          ),
        );
      }
    );
  }
}