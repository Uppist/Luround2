import 'package:flutter/material.dart';
import 'package:luround/utils/colors/app_theme.dart';







class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key, required this.onTaped});
  final VoidCallback onTaped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTaped,
      child: Container(
        height: 50,
        width: 250,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.greyColor,
          border: Border.all(color: AppColor.textGreyColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
      )
    );
  }
}