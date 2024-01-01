import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/more/transaction_model.dart';
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


  /*Future<void> _loadData() async {
    try {
      setState(() {
        service.isLoading.value = true;
      });
      final List<UserTransactionsModel> transactions = await service.getUserTransactions();
      //transactions.sort((a, b) => a.service_name.toLowerCase().compareTo(b.service_name.toLowerCase()));
      setState(() {
        service.isLoading.value = false;
        service.filteredTrxList.value = List.from(transactions);
        print("initState: ${service.filteredTrxList}");
      });
    } 
    catch (error) {
      setState(() {
        service.isLoading.value = false;
      });
      print("Error fetching trx list: $error");
      // Handle error as needed, e.g., show an error message to the user
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserTransactionsModel>>(
      future: service.loadTransactionData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        if (snapshot.hasError) {
          debugPrint("${snapshot.error}");
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          debugPrint("sn-trace: ${snapshot.stackTrace}");
          debugPrint("sn-data: ${snapshot.data}");
          return TrxEmptyState(
            onRefresh: () {
              service.loadTransactionData();
            },
          );                   
        }
        if (snapshot.hasData) {

          var data = snapshot.data!;

          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
            itemCount: data.length,  //service.filteredTrxList.length,
            //padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              //final item = service.filteredTrxList[index];
              final item = data[index];
              if(data.isEmpty) {
                return TrxEmptyState(
                  onRefresh: () {
                    service.getUserTransactions();
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
          );
        }
        return Center(
          child: Text(
            "connection timed out",
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.normal
            )
          )
        );
      }
    );
  }
}