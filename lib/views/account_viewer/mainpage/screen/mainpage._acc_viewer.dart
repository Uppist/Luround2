import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luround/views/account_viewer/people_profile/screen/profile_page_acc_viewer.dart';
import 'package:luround/views/account_viewer/services/screen/services_screen.dart';
import '../../../../controllers/account_owner/main/mainpage_controller.dart';
import '../../../../controllers/account_viewer/mainpage_controller_acc_viewer.dart';
import '../widget/bottom_bar_widget_acc_viewer.dart';





class MainPageAccViewer extends StatefulWidget {
  MainPageAccViewer({super.key,});

  @override
  State<MainPageAccViewer> createState() => _MainPageAccViewerState();
}

class _MainPageAccViewerState extends State<MainPageAccViewer> {

  final MainPageControllerAccViewer controller = MainPageControllerAccViewer();


  void _onItemTapped(int index) {
    setState(() {
      controller.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: controller.widgetOptions.elementAt(controller.selectedIndex),
      ),
      bottomNavigationBar: BottomNavBarAccViewer(
        selectedIndex: controller.selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}