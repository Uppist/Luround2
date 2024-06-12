import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final List<BottomNavigationBarItem> items;
  final Function(int) onItemTapped;
  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.items, 
    required this.onItemTapped,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.bgColor,
      selectedItemColor: AppColor.greenColor,
      unselectedItemColor: AppColor.darkGreyColor,
      items: widget.items,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex,
      iconSize: 29.sp,
      onTap: widget.onItemTapped,
      elevation: 8, //5,
      selectedLabelStyle: GoogleFonts.inter(),
      unselectedLabelStyle: GoogleFonts.inter(),
    );
  }
}