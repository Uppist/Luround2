import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class MySpecialWidget extends StatelessWidget {
  const MySpecialWidget({super.key, required this.trailing, required this.leading});
  final Widget trailing;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: leading),
        SizedBox(width: 10.w,),
        trailing
      ],
    );
  }
}