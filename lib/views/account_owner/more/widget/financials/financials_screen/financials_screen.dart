import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/filter_financials_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/search_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';









class FinancialsPage extends StatefulWidget {
  FinancialsPage({super.key});

  @override
  State<FinancialsPage> createState() => _FinancialsPageState();
}

class _FinancialsPageState extends State<FinancialsPage> {
  var controller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor, //AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section/////
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: SvgPicture.asset("assets/svg/notify_active.svg"),
                      ),
                    ]
                  ),
                ]
              )
            ),
            ///Navigation Section, Search TextField and Filter/////
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7,),
              //height: 70, //65
              width: double.infinity,
              color: AppColor.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                   
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColor.blackColor,
                        )
                      ),
                      SizedBox(width: 3,),
                      Text(
                        "Financials",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  //search textfield
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child:FinancialsSearchTextField(
                      onTap: () {
                        setState(() {
                          controller.isFieldTapped.value = true;
                        });
                      },
                      onFieldSubmitted: (p0) {
                        setState(() {
                          controller.isFieldTapped.value = false;
                        });  
                      },
                      hintText: "Search",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textController: controller.searchController,
                    )                
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: FilterFinancialsButton(),
                  ),
                  //filter button
                  SizedBox(height: 15,),                 
                ],
              ),
            ),
            SizedBox(height: 20,),
          ]
        )
      )
    );
  }
}







