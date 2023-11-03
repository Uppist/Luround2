import 'package:flutter/material.dart';
import 'package:luround/utils/colors/app_theme.dart';






class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 200,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        )
      ),
    );
  }
}