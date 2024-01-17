import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luround/services/account_owner/more/financials/receipt_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/receipts_contents/drafted_receipts/drafted_receipt_display.dart';







class DraftedReceiptList extends StatelessWidget {
  DraftedReceiptList({super.key});

  var service = Get.put(ReceiptsService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return service.isLoading.value ? Expanded(child: Loader()) : service.filteredDraftedReceiptsList.isNotEmpty ? Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemCount: service.filteredDraftedReceiptsList.length,
            //padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final item = service.filteredDraftedReceiptsList[index]; 
              if(service.filteredDraftedReceiptsList.isEmpty) {
                return FinancialsEmptyState(
                  titleText: 'No receipt yet',
                  subtitleText: 'a receipt',
                );
              }
              if(service.filteredDraftedReceiptsList.isNotEmpty) {
                return DraftedReceiptDisplay(
                  onPressed: (){},
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

              return FinancialsEmptyState(
                titleText: 'No receipt yet',
                subtitleText: 'a receipt',
              );
             
            }
          ),
        ) : FinancialsEmptyState(
          titleText: 'No receipt yet',
          subtitleText: 'a receipt',
        );
      }
    );
  }
}