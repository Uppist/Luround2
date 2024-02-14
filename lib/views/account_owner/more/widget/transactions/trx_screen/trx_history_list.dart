import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/transactions/transaction_model.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_content/trx_display.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_content/trx_empty_state.dart';






class TrxHistoryList extends StatefulWidget {
  TrxHistoryList({super.key});

  @override
  State<TrxHistoryList> createState() => _TrxHistoryListState();
}

class _TrxHistoryListState extends State<TrxHistoryList> {

  var service = Get.put(WithdrawalService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return service.filteredTrxList.isNotEmpty ? ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
          itemCount: service.filteredTrxList.length,
          //padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            //final item = service.filteredTrxList[index];
            final item = service.filteredTrxList[index];
            if(service.filteredTrxList.isEmpty) {
              return TrxEmptyState(
                onRefresh: () {
                  service.loadTransactionData();
                },
              );
            }
            return TrxDisplay(
              service_id: item.service_id,
              service_name: item.service_name,
              amount: item.amount,
              affliate_user: item.affliate_user,
              transaction_status: item.transaction_status,
              transaction_ref: item.transaction_ref,
              transaction_date: item.transaction_date,
              transaction_time: item.transaction_time,
            );
          }
        ) :TrxEmptyState(
          onRefresh: () {
            service.loadTransactionData();
          },
        );
      }
    );
    
  
  }
}