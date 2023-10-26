import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/time_selector_grid_view.dart';
import '../../../../../../utils/colors/app_theme.dart';








class Step3Screen extends StatefulWidget {
  Step3Screen({super.key,required this.onSubmit});
  final VoidCallback onSubmit;

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select time",
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20,),
          //time gridview        
          TimeGridView(),
          SizedBox(height: 100,),
          RebrandedReusableButton(
            textColor: AppColor.bgColor,
            color: AppColor.mainColor,
            text: "Next", 
            onPressed: widget.onSubmit,
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}