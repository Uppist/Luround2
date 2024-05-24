import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.checkbox, required this.title,});
  final Checkbox checkbox;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        checkbox,
        SizedBox(width: 5.w,),
        title
      ],
    );
  }
}