import 'package:flutter/cupertino.dart';
import 'package:luround/views/account_viewer/404page/unknown_route.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';






class LayoutWidget extends StatelessWidget {
  const LayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //mobile
        if(constraints.maxWidth < 600) {
          return MainPageAccViewer();
        }
        else {
          return NoLaptopView();
        }
      }
    );
  }
}