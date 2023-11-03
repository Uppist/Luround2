import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:luround/utils/colors/app_theme.dart';







class SwitchWidget extends StatefulWidget {
  SwitchWidget({super.key, required this.isToggled});
  bool isToggled;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: AppColor.mainColor,
      thumbColor: AppColor.bgColor,
      trackColor: AppColor.textGreyColor.withOpacity(0.2),
      value: widget.isToggled,
      onChanged: (value) {
        setState(() {
          this.widget.isToggled = value;
          debugPrint("toggled: ${widget.isToggled}");
        });
      },
    );
  }
}