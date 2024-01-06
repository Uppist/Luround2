import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/receipt_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/empty_state/financials_empty_state.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/receipts_contents/sent_receipts/sent_receipt_display.dart';






class SentReceiptList extends StatelessWidget {
  SentReceiptList({super.key});

  var service = Get.put(ReceiptsService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return service.isLoading.value ? Loader() : Expanded(
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
              if(service.filteredSentReceiptList.isEmpty) {
                return FinancialsEmptyState(
                  titleText: 'No receipt yet',
                  subtitleText: 'a receipt',
                );
              }
              if(service.filteredSentReceiptList.isNotEmpty) {
                return SentReceiptDisplay(
                  onPressed: (){},
                );
              }

              return FinancialsEmptyState(
                titleText: 'No receipt yet',
                subtitleText: 'a receipt',
              );
              
            }
          ),
        );
      }
    );
  }
}