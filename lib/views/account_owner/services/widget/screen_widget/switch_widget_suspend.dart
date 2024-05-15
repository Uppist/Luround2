import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:luround/utils/colors/app_theme.dart';







class SwitchWidgetSuspend extends StatefulWidget {
  SwitchWidgetSuspend({super.key, required this.onChanged, required this.isToggled});
  final void Function(bool)? onChanged;
  bool isToggled;

  @override
  State<SwitchWidgetSuspend> createState() => _SwitchWidgetSuspendState();
}

class _SwitchWidgetSuspendState extends State<SwitchWidgetSuspend > {

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0,
      child: CupertinoSwitch(
        activeColor: AppColor.mainColor,
        thumbColor: AppColor.bgColor,
        trackColor: AppColor.textGreyColor.withOpacity(0.2),
        value: widget.isToggled,
        onChanged: widget.onChanged
        /*(value) {
          setState(() {
            widget.isToggled = value;
            debugPrint("toggled: ${widget.isToggled}");
          });
        },*/
      ),
    );
  }
}