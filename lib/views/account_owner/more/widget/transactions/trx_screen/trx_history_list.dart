import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_content/trx_display.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_content/trx_empty_state.dart';






class TrxHistoryList extends StatelessWidget {
  const TrxHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
      itemCount: 6,
      //padding: EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return TrxDisplay();
      }
    );
  }
}