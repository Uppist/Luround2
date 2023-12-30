import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import '../../../../controllers/account_owner/main/mainpage_controller.dart';
import '../../../../controllers/account_viewer/mainpage_controller_acc_viewer.dart';





class BottomNavBarAccViewer extends StatefulWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;
  const BottomNavBarAccViewer({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  State<BottomNavBarAccViewer> createState() => _BottomNavBarAccViewerState();
}

class _BottomNavBarAccViewerState extends State<BottomNavBarAccViewer> {

  final MainPageControllerAccViewer controller = MainPageControllerAccViewer();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.bgColor,
      selectedItemColor: AppColor.greenColor,
      unselectedItemColor: AppColor.darkGreyColor,
      items: controller.navBarsItems(),
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex,
      iconSize: 29,
      onTap: widget.onItemTapped,
      elevation: 8, //5,
      selectedLabelStyle: GoogleFonts.poppins(),
      unselectedLabelStyle: GoogleFonts.poppins(),
      enableFeedback: true,
    );
  }
}