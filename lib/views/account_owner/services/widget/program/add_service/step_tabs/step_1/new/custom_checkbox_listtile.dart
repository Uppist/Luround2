import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class CustomCheckBoxListTile extends StatelessWidget {
  const CustomCheckBoxListTile({super.key, required this.checkbox, required this.title, required this.subtitle});
  final Checkbox checkbox;
  final Row title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        checkbox,
        SizedBox(width: 5.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              subtitle
            ],
          )
        )
      ],
    );
  }
}