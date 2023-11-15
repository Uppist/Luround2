import 'package:flutter/material.dart';
import 'package:luround/utils/colors/app_theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColor.mainColor,
        //color: AppColor.mainColor,
      )
    );
  }
}