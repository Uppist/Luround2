import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luround/utils/colors/app_theme.dart';






class TrxHistoryList extends StatelessWidget {
  const TrxHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.1,),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        );
      },
    );
  }
}