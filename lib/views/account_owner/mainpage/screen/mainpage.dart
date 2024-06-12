import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/account_owner/main/mainpage_controller.dart';
import '../widget/bottom_bar_widget.dart';





class MainPage extends StatefulWidget {
  const MainPage({Key? key,}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  final MainPageController controller = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return Center(
            child: controller.widgetOptions.elementAt(controller.selectedIndex.value),
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavBar(
            selectedIndex: controller.selectedIndex.value,
            onItemTapped: controller.setIndex,
            items: controller.navBarsItems(),
          );
        },
      ),
    );
  }
}
